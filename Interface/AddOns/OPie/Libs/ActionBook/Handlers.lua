local _, T = ...
if T.SkipLocalActionBook then return end
local AB = assert(T.ActionBook:compatible(2,14), "A compatible version of ActionBook is required")
local RW = assert(AB:compatible("Rewire",1,2), "A compatible version of Rewire is required")
local EV = assert(T.Evie)
local spellFeedback, itemFeedback, toyFeedback
_ = T.Toboe and T.Toboe()

local safequote do
	local r = {u="\\117", ["{"]="\\123", ["}"]="\\125"}
	function safequote(s)
		return (("%q"):format(s):gsub("[{}u]", r))
	end
end

do -- spell: spell ID + mount spell ID
	local function currentShapeshift()
		local id, n = GetShapeshiftForm()
		if id == 0 then return end
		id, n = GetShapeshiftFormInfo(id)
		return n
	end
	local actionMap, spellMap, mountMap, spellMountID = {}, {}, {}, {}
	local companionUpdate do -- maintain mountMap/spellMountID
		function companionUpdate(event)
			local changed, myFactionId = false, UnitFactionGroup("player") == "Horde" and 0 or 1
			for i=1, C_MountJournal.GetNumMounts() do
				local exists, _1, sid, _3, _4, _5, _6, _7, factionLocked, factionId, hide, have = false, C_MountJournal.GetMountInfo(i)
				if not hide and (not factionLocked or factionId == myFactionId) then
					local sname, srank, rname = GetSpellInfo(sid)
					exists, rname = have and GetSpellInfo(sname, srank) ~= nil, (sname .. "(" .. (srank or "") .. ")") -- Paladin/Warlock/Death Knight horses have spell ranks
					spellMountID[sid], mountMap[sid], mountMap[sname], mountMap[sname:lower()], mountMap[rname], mountMap[rname:lower()] =
						i, exists and rname, sid, sid, sid, sid
				end
				changed = changed or exists ~= (mountMap[sid] ~= nil)
			end
			if changed then AB:NotifyObservers("spell") end
		end
		local rname, _, ricon = GetSpellInfo(150544)
		mountMap[150544], actionMap[150544] = 150544, AB:CreateActionSlot(function()
			return HasFullControl() and not IsIndoors(), 0, ricon, rname, 0, 0, 0, GameTooltip.SetMountBySpellID, 150544
		end, nil, "func", C_MountJournal.Summon, 0)
		EV.RegisterEvent("COMPANION_LEARNED", companionUpdate)
		EV.RegisterEvent("PLAYER_ENTERING_WORLD", companionUpdate)
		EV.RegisterEvent("MOUNT_JOURNAL_USABILITY_CHANGED", companionUpdate)
	end

	local function SetSpellBookItem(self, id)
		return self:SetSpellBookItem(id, BOOKTYPE_SPELL)
	end
	local function hint(n, _, target)
		if not n then return end
		local csid, time = mountMap[n], GetTime()
		if csid then
			local usable = (not (InCombatLockdown() or IsIndoors())) and HasFullControl() and not UnitIsDeadOrGhost("player")
			local cdStart, cdLength = GetSpellCooldown(csid)
			local cname, acsid, icon, active, usable2 = C_MountJournal.GetMountInfo(spellMountID[csid])
			if acsid ~= csid then
				companionUpdate()
				cname, acsid, icon, active, usable2 = C_MountJournal.GetMountInfo(spellMountID[csid])
			end
			return usable and cdStart == 0 and usable2, active and 1 or 0, icon, cname, 0, (cdStart or 0) > 0 and (cdStart+cdLength-time) or 0, cdLength, GameTooltip.SetMountBySpellID, csid
		end
		local msid, sname, _, _, _, _, _, sid = spellMap[n], GetSpellInfo(n)
		if not sname then return end
		local inRange, usable, nomana, hasRange = IsSpellInRange(n, target or "target"), IsUsableSpell(n)
		inRange, hasRange = inRange ~= false, inRange ~= nil
		local usable, cooldown, cdLength, enabled = usable and inRange, GetSpellCooldown(n)
		local cdLeft = (cooldown or 0) > 0 and (enabled ~= 0) and (cooldown + cdLength - time) or 0
		local count, charges, maxCharges, chargeStart, chargeDuration = GetSpellCount(n), GetSpellCharges(n)
		local state = ((IsSelectedSpellBookItem(n) or IsCurrentSpell(n) or n == currentShapeshift() or enabled == 0) and 1 or 0) +
		              (IsSpellOverlayed(msid or 0) and 2 or 0) + (nomana and 8 or 0) + (inRange and 0 or 16) + (charges and charges > 0 and 64 or 0) + (hasRange and 512 or 0)
		usable = not not (usable and (cooldown == nil or cooldown == 0) or (enabled == 0))
		if charges and maxCharges and charges < maxCharges and cdLeft == 0 then
			cdLeft, cdLength = chargeStart-time + chargeDuration, chargeDuration
		end
		local sbslot = msid and msid ~= 161691 and FindSpellBookSlotBySpellID(msid)
		return usable, state, GetSpellTexture(n), sname or n, count <= 1 and charges or count, cdLeft, cdLength, sbslot and SetSpellBookItem or (msid or sid) and GameTooltip.SetSpellByID, sbslot or sid or msid
	end
	function spellFeedback(sname, target, spellId)
		spellMap[sname] = spellId or spellMap[sname] or tonumber((GetSpellLink(sname) or ""):match("spell:(%d+)"))
		return hint(sname, nil,  target)
	end
	
	AB:RegisterActionType("spell", function(id)
		if type(id) ~= "number" then return end
		local action = mountMap[id]
		if action == nil then
			local s0, r0 = GetSpellInfo(id)
			local o, s, r = pcall(GetSpellInfo, s0, r0)
			if not (o and s and r and s0) then return end
			action = s0
		end
		if action and not actionMap[action] then
			spellMap[action], spellMap[action:lower()], actionMap[action] = id, id, AB:CreateActionSlot(hint, action, "attribute", "type","spell", "spell",action)
		end
		return actionMap[action]
	end, function(id)
		local name2, _, icon2, name, sname, icon = nil, nil, nil, GetSpellInfo(id)
		if name then name2, _, icon2 = GetSpellInfo(name, sname) end
		return spellMountID[id] and "Mount" or "Spell", name2 or name, icon2 or icon, nil, GameTooltip.SetSpellByID, id
	end)
	local gab = GetSpellInfo(161691)
	actionMap[gab] = AB:CreateActionSlot(hint, gab, "conditional", "[outpost]", "attribute", "type","spell", "spell",gab)
	spellMap[gab], spellMap[gab:lower()] = 161691, 161691
	
	EV.RegisterEvent("SPELLS_CHANGED", function() AB:NotifyObservers("spell") end)
end
do -- item: items ID/inventory slot
	local actionMap, itemIdMap, lastSlot = {}, {}, INVSLOT_LAST_EQUIPPED
	local function containerTip(self, bagslot)
		local slot = bagslot % 100
		self:SetBagItem((bagslot-slot)/100, slot)
	end
	local function playerInventoryTip(self, slot)
		self:SetInventoryItem("player", slot)
	end
	local function GetItemLocation(iid, name, name2)
		local name2, cb, cs, n = name2 and name2:lower()
		for i=1, INVSLOT_LAST_EQUIPPED do
			if GetInventoryItemID("player", i) == iid then
				n = GetItemInfo(GetInventoryItemLink("player", i))
				if n == name or n and name2 and n:lower() == name2 then
					return nil, i
				elseif not cs then
					cb, cs = nil, i
				end
			end
		end
		for i=0,4 do
			for j=1,GetContainerNumSlots(i) do
				if iid == GetContainerItemID(i, j) then
					n = GetItemInfo(GetContainerItemLink(i, j))
					if n == name or n and name2 and n:lower() == name2 then
						return i, j
					elseif not cs then
						cb, cs = i, j
					end
				end
			end
		end
		return cb, cs
	end
	local function hint(ident, _, target, purpose, ibag, islot)
		local name, link, icon, _, bag, slot, tip, tipArg
		if type(ident) == "number" and ident <= lastSlot then
			local invid = GetInventoryItemID("player", ident)
			if invid == nil then return end
			bag, slot, name, link = nil, invid, GetItemInfo(GetInventoryItemLink("player", ident) or invid)
			if name then ident = name end
		else
			name, link, _, _, _, _, _, _, _, icon = GetItemInfo(ident)
		end
		local iid, cdStart, cdLen = (link and tonumber(link:match("item:(%d+)"))) or itemIdMap[ident]
		if iid and PlayerHasToy(iid) and GetItemCount(iid) == 0 then
			return toyFeedback(iid)
		elseif iid then
			cdStart, cdLen = GetItemCooldown(iid)
		end
		local inRange, hasRange = IsItemInRange(ident, target or "target")
		inRange, hasRange = inRange ~= false, inRange ~= nil
		if ibag and islot then
			bag, slot = ibag, islot
		elseif iid then
			bag, slot = GetItemLocation(iid, name, ident)
		end
		if bag and slot then
			tip, tipArg = containerTip, bag * 100 + slot
		elseif slot then
			tip, tipArg = playerInventoryTip, slot
		elseif iid then
			tip, tipArg = GameTooltip.SetItemByID, iid
		end
		local nCharge = GetItemCount(ident, false, true) or 0
		local usable = nCharge > 0 and ((cdLen or 0) == 0 and ((GetItemSpell(ident) == nil) or (IsUsableItem(ident) and inRange)))
		return not not usable, (IsCurrentItem(ident) and 1 or 0) + (inRange and 0 or 16) + (slot and IsEquippableItem(ident) and (bag and (purpose == "equip" and 128 or 0) or (slot and 256 or 0)) or 0) + (hasRange and 512 or 0),
			icon or GetItemIcon(ident), name or ident, nCharge,
			(cdStart or 0) > 0 and (cdStart - GetTime() + cdLen) or 0, cdLen or 0, tip, tipArg
	end
	function itemFeedback(name, target, bag, slot, purpose)
		return hint(name, nil, target, purpose, bag, slot)
	end
	AB:RegisterActionType("item", function(id, byName, forceShow, onlyEquipped)
		if type(id) ~= "number" then return end
		local name = id <= lastSlot and id or (byName and GetItemInfo(id) or ("item:" .. id))
		if not forceShow and onlyEquipped and not ((id > lastSlot and IsEquippedItem(name)) or (id <= lastSlot and GetInventoryItemLink("player", id))) then return end
		if not forceShow and GetItemCount(name) == 0 then return end
		if not actionMap[name] then
			actionMap[name], itemIdMap[name] = AB:CreateActionSlot(hint, name, "attribute", "type","item", "item",name), id
		end
		return actionMap[name]
	end, function(id) return "Item", GetItemInfo(id), GetItemIcon(id), nil, GameTooltip.SetItemByID, tonumber(id) end, {"byName", "forceShow", "onlyEquipped"})
	EV.RegisterEvent("BAG_UPDATE", function() AB:NotifyObservers("item") end)
	RW:SetCommandHint(SLASH_EQUIP1, 70, function(slash, _, clause, target)
		if clause and clause ~= "" and GetItemInfo(clause) then
			return true, itemFeedback(clause, nil, nil, nil, "equip")
		end
	end)
	RW:SetCommandHint(SLASH_EQUIP_TO_SLOT1, 70, function(slash, _, clause, target)
		local item = clause and clause:match("^%s*%d+%s+(.*)")
		if item then
			return RW:GetCommandAction(SLASH_EQUIP1, item)
		end
	end)
end
do -- macrotext
	local map = {}
	local function hint(mtext, modLockState)
		return RW:GetMacroAction(mtext, modLockState)
	end
	AB:RegisterActionType("macrotext", function(macrotext)
		if type(macrotext) ~= "string" then return end
		if not map[macrotext] then
			map[macrotext] = AB:CreateActionSlot(hint, macrotext, "recall", RW:seclib(), "RunMacro", macrotext)
		end
		return map[macrotext]
	end, function(macrotext)
		if macrotext == "" then return "Custom Macro", "New Macro", "Interface/Icons/Temp" end
		local _, _, ico = RW:GetMacroAction(macrotext)
		return "Custom Macro", "", ico
	end)
	local function checkReturn(pri, ...)
		if select("#", ...) > 0 then return pri, ... end
	end
	AB:AddActionToCategory("Miscellaneous", "macrotext", "")
	RW:SetCommandHint("/use", 100, function(slash, _, clause, target)
		if not clause or clause == "" then return end
		local link, bag, slot = SecureCmdItemParse(clause)
		if link and GetItemInfo(link) then
			return checkReturn(90, itemFeedback(link, target, bag, slot))
		end
		return checkReturn(true, spellFeedback(clause, target))
	end)
	RW:SetCommandHint(SLASH_CASTSEQUENCE1, 100, function(slash, _, clause, target)
		if not clause or clause == "" then return end
		local _, item, spell = QueryCastSequence(clause)
		clause = (item or spell)
		if clause then
			return RW:GetCommandAction("/use", clause, target)
		end
	end)
	do -- /userandom
		local f, seed = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate"), math.random(2^30)
		f:Execute("seed, t = " .. seed .. ", newtable()")
		f:SetAttribute("RunSlashCmd", [[--
			local cmd, v, target, s = ...
			if v == "" or not v then
				return
			elseif not t[v] then
				local tv, tn = newtable(), 1
				for f in v:gmatch("[^,]+") do
					tv[tn], tn = f:match("^%s*(.-)%s*$"), tn + 1
				end
				t[v], tv[0] = tv, seed
			end
			v = t[v]
			v, v[0] = v[1 + v[0] % #v], (v[0] * 37 + 13) % 2^32
			if target and target ~= "" then
				v = "[@" .. target "]" .. v
			end
			return "/cast " .. v
		]])
		RW:RegisterCommand(SLASH_USERANDOM1, true, true, f)
		local sc, ic = GetManagedEnvironment(f).t, {}
		RW:SetCommandHint(SLASH_USERANDOM1, 50, function(slash, _, clause, target)
			if not clause or clause == "" then return end
			local t1, t, n = sc[clause]
			t = t1 or ic[clause]
			if t1 then
				ic[clause] = nil
			elseif not t then
				t, n = {[0]=seed}, 0
				for s in clause:gmatch("[^,]+") do
					t[n+1], n = s, n + 1
				end
				ic[clause] = t
			end
			if t then
				return RW:GetCommandAction("/use", t[1 + t[0] % #t], target)
			end
		end)
	end
end
do -- macro: name
	local map, f, sm, macroHint = {}, CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate") do
		f:SetFrameRef("Rewire", RW:seclib())
		f:Execute('macros, RW = newtable(), self:GetFrameRef("Rewire")')
		f:SetAttribute("RunNamedMacro", [[-- AB_RunStoredMacro_Command
			return RW:RunAttribute('RunMacro', macros[...])
		]])
		sm = GetManagedEnvironment(f).macros
		local pending
		local function sync()
			local s, numGlobal, numChar = "", GetNumMacros()
			for k in rtable.pairs(sm) do
				if not GetMacroInfo(k) then
					s = ("%s\nmacros[%s] = nil"):format(s, safequote(k))
					RW:ClearNamedMacroHandler(k, f)
				end
			end
			local ofs = MAX_ACCOUNT_MACROS - numGlobal
			for i=1,numGlobal + numChar do
				local name, _, text = GetMacroInfo((i > numGlobal and ofs or 0)+i)
				if name and sm[name] ~= text then
					s = ("%s\nmacros[%s] = %s"):format(s, safequote(name), safequote(text))
					RW:SetNamedMacroHandler(name, f, macroHint)
				end
			end
			if s ~= "" then
				f:Execute(s)
				AB:NotifyObservers("macro")
			end
			pending = nil
			return "remove"
		end
		EV.RegisterEvent("UPDATE_MACROS", function()
			if InCombatLockdown() then
				pending = pending or EV.RegisterEvent("PLAYER_REGEN_ENABLED", sync) or true
			else
				sync()
			end
		end)
	end
	local function check(name, pri, ...)
		if ... == nil then
			local _, ico = GetMacroInfo(name)
			return ico and 10 or false, sm[name] ~= nil, 0, ico, name, 0, 0, 0
		end
		return pri, ...
	end
	local function tail(a, ...)
		return ...
	end
	local function hint(name, modState)
		return tail(check(name, 10, RW:GetMacroAction(sm[name], modState)))
	end
	function macroHint(name, target, modState, priLimit)
		return check(name, RW:GetMacroAction(sm[name], modState, priLimit))
	end
	AB:RegisterActionType("macro", function(name, forceShow)
		if type(name) == "string" and (forceShow or sm[name]) then
			if not map[name] then
				map[name] = AB:CreateActionSlot(hint, name, "recall", RW:seclib(), "RunSlashCmd", "/runmacro", name)
			end
			return map[name]
		end
	end, function(name)
		local n, ico = GetMacroInfo(name)
		return "Macro", n or name, ico
	end, {"forceShow"})
end
do -- battlepet: pet ID
	local petAction = {}
	local function tip(self, id)
		local sid, cname, lvl, _, _, _, _, name, _, ptype, _, _, _, _, cb = C_PetJournal.GetPetInfoByPetID(id)
		if not sid then return false end
		local hp, mhp, ap, spd, rarity = C_PetJournal.GetPetStats(id)
		local qc, nc, icof = ITEM_QUALITY_COLORS[rarity-1], HIGHLIGHT_FONT_COLOR, "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:0:0:32:32:%d:%d:%d:%d|t %s"
		self:AddLine(cname or name, qc.r, qc.g, qc.b)
		if cb then
			self:AddLine(UNIT_TYPE_LEVEL_TEMPLATE:format(lvl, _G["BATTLE_PET_NAME_".. ptype]), nc.r, nc.g, nc.b)
			self:AddLine(icof:format(0, 16, 0, 16, ap) .. "   " .. icof:format(0, 16, 16, 32, spd) .. "   " .. icof:format(16,32,16,32, hp < mhp and (hp .. "/" .. mhp) or hp), nc.r, nc.g, nc.b)
		end
	end
	local function hint(pid)
		local sid, cn, _, _, _, _, _, n, tex = C_PetJournal.GetPetInfoByPetID(pid)
		local cooldown, duration, enabled = C_PetJournal.GetPetCooldownByGUID(pid)
		local cdLeft = (cooldown or 0) > 0 and (enabled ~= 0) and (cooldown + duration - GetTime())
		local active = C_PetJournal.GetSummonedPetGUID()
		return sid and not cdLeft and not C_PetJournal.PetIsRevoked(pid), (active and active:upper()) == pid and 1 or 0, tex, cn or n or "", 0, cdLeft or 0, duration or 0, tip, pid
	end
	local function create(pid)
		local ok, sid = pcall(C_PetJournal.GetPetInfoByPetID, pid)
		if not (ok and sid) then return end
		pid = pid:upper()
		if not petAction[pid] then
			petAction[pid] = AB:CreateActionSlot(hint, pid, "func", C_PetJournal.SummonPetByGUID, pid)
		end
		return petAction[pid]
	end
	local function describe(pid)
		local ok, sid, cn, lvl, _, _, _, _, n, tex = pcall(C_PetJournal.GetPetInfoByPetID, pid)
		if not (ok and sid) then return "Battle Pet", "?" end
		if (cn or n) and ((lvl or 0) > 1) then cn = "[" .. lvl .. "] " .. (cn or n) end
		return "Battle Pet", cn or n or ("#" .. tostring(pid)), tex, nil, tip, pid
	end
	AB:RegisterActionType("battlepet", create, describe)
	RW:SetCommandHint(SLASH_SUMMON_BATTLE_PET1, 60, function(slash, _, clause, target)
		if clause and clause ~= "" then
			local _, petID = C_PetJournal.FindPetIDByName(clause:trim())
			if petID then
				return true, hint(petID)
			end
		end
	end)
end
do -- equipmentset: equipment sets by name
	local setMap = {}
	local function hint(name)
		local icon, _, active, total, equipped, available = GetEquipmentSetInfoByName(name)
		if icon then
			return total == equipped or (available > 0), active and 1 or 0, "interface/icons/" .. icon, name, nil, 0, 0, GameTooltip.SetEquipmentSet, name
		end
	end
	AB:RegisterActionType("equipmentset", function(name)
		if type(name) ~= "string" or not GetEquipmentSetInfoByName(name) then return end
		if not setMap[name] then
			setMap[name] = AB:CreateActionSlot(hint, name, "attribute", "type","macro", "macrotext", (SLASH_EQUIP_SET1 or "/equipset") .. " " .. name)
		end
		return setMap[name]
	end, function(name)
		return "Equipment Set", name, "Interface/Icons/" .. (GetEquipmentSetInfoByName(tostring(name)) or "INV_Misc_QuestionMark"), nil, GameTooltip.SetEquipmentSet, name
	end)
	RW:SetCommandHint(SLASH_EQUIP_SET1, 80, function(slash, _, clause, target)
		if clause and clause ~= "" then
			return true, hint(clause)
		end
	end)
end
do -- raidmark
	local map = {}
	local function CanChangeRaidMarkers(unit)
		return not not ((not IsInRaid() or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and not (unit and UnitIsPlayer(unit) and UnitIsEnemy("player", unit)))
	end
	local function click(id)
		if GetRaidTargetIndex("target") == id then id = 0 end
		SetRaidTarget("target", id)
	end
	local function hint(i, _, target)
		local target = target or "target"
		return CanChangeRaidMarkers(target), GetRaidTargetIndex(target) == i and 1 or 0, "Interface/TargetingFrame/UI-RaidTargetingIcon_" .. i, _G["RAID_TARGET_" .. i], 0, 0, 0
	end
	local function removeHint()
		return CanChangeRaidMarkers(), 0, "Interface/Icons/INV_Gauntlets_02", REMOVE_WORLD_MARKERS, 0, 0, 0
	end
	map[0] = AB:CreateActionSlot(removeHint, nil, "func", function()
		if not CanChangeRaidMarkers() then return end
		for i=1,8 do
			SetRaidTarget("player", i)
		end
		SetRaidTarget("player", IsInGroup() and 9 or 0)
	end)
	for i=1,8 do
		map[i] = AB:CreateActionSlot(hint, i, "func", click, i)
	end
	AB:RegisterActionType("raidmark", function(id) return map[id] end, function(id)
		if id == 0 then return "Raid Marker", REMOVE_WORLD_MARKERS, "Interface/Icons/INV_Gauntlets_02" end
		return "Raid Marker", _G["RAID_TARGET_" .. id], "Interface/TargetingFrame/UI-RaidTargetingIcon_" .. id
	end)
	RW:ImportSlashCmd("TARGET_MARKER", true, false, 40, function(slash, _, clause, target)
		clause = tonumber(clause)
		if clause == 0 then
			return true, removeHint()
		elseif clause then
			return true, hint(clause, nil, target)
		end
	end)
end
do -- worldmarker
	local map, icons = {}, {[0]="Interface/Icons/INV_Misc_PunchCards_White",
		"Interface/Icons/INV_Misc_QirajiCrystal_04","Interface/Icons/INV_Misc_QirajiCrystal_03",
		"Interface/Icons/INV_Misc_QirajiCrystal_05","Interface/Icons/INV_Misc_QirajiCrystal_02",
		"Interface/Icons/INV_Misc_QirajiCrystal_01","Interface/Icons/INV_Elemental_Primal_Fire",
		"Interface/Icons/INV_jewelcrafting_taladiterecrystal","Interface/Icons/INV_jewelcrafting_taladitecrystal"}
	local function hint(i)
		return not not (IsInGroup() and (not IsInRaid() or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or IsEveryoneAssistant())), i > 0 and IsRaidMarkerActive(i) and 1 or 0, icons[i], i == 0 and REMOVE_WORLD_MARKERS or _G["WORLD_MARKER" .. i], 0, 0, 0
	end
	for i=1, 8 do
		map[i] = AB:CreateActionSlot(hint, i, "attribute", "type","worldmarker", "action","toggle", "marker",i)
	end
	map[0] = AB:CreateActionSlot(hint, 0, "attribute", "type","macro", "macrotext",SLASH_CLEAR_WORLD_MARKER1 .. " " .. ALL)
	AB:RegisterActionType("worldmark", function(id) return map[id] end, function(id) return "Raid World Marker", id == 0 and REMOVE_WORLD_MARKERS or _G["WORLD_MARKER" .. id], icons[id] end)
	RW:SetCommandHint(SLASH_WORLD_MARKER1, 40, function(slash, _, clause, target)
		clause = tonumber(clause)
		if clause and clause >= 1 and clause <= 8 then
			return true, hint(clause)
		end
	end)
end
do -- opie.databroker.launcher
	local nameMap, LDB = {}
	local function checkLDB()
		LDB = LibStub and LibStub:GetLibrary("LibDataBroker-1.1", 1)
	end
	local function call(obj, btn)
		obj:OnClick(btn)
	end
	local function describe(name)
		local obj = (LDB or checkLDB() or LDB) and LDB:GetDataObjectByName(name);
		return "Launcher", obj and obj.label or name, obj and obj.icon or "Interface/Icons/INV_Misc_QuestionMark", obj
	end
	local function hint(obj)
		if not obj then return end
		return true, 0, obj.icon, obj.label or obj.text, 0,0,0, obj.OnTooltipShow, nil, obj
	end
	local function create(name, rightClick)
		if type(name) ~= "string" or not (LDB or checkLDB() or LDB) then return end
		local pname = name .. "#" .. (rightClick and "R" or "L")
		if not nameMap[pname] then
			local obj = LDB:GetDataObjectByName(name)
			if not obj then return end
			nameMap[pname] = AB:CreateActionSlot(hint, obj, "func", call, obj, rightClick and "RightButton" or "LeftButton")
		end
		return nameMap[pname]
	end
	AB:RegisterActionType("opie.databroker.launcher", create, describe, {"clickUsingRightButton"})
end
do -- extrabutton
	local slot = GetExtraBarIndex()*12 - 11
	local function hint()
		if not HasExtraActionBar() then
			return false, 0, "Interface/Icons/temp", "", 0, 0, 0
		end
		local at, aid = GetActionInfo(slot)
		local inRange, usable, nomana, hasRange = IsActionInRange(slot), IsUsableAction(slot)
		inRange, hasRange = inRange ~= false, inRange ~= nil
		local usable, cooldown, cdLength, enabled = usable and inRange, GetActionCooldown(slot)
		local cdLeft = (cooldown or 0) > 0 and (enabled ~= 0) and (cooldown + cdLength - GetTime()) or 0
		local count, charges, maxCharges, chargeStart, chargeDuration = GetActionCount(slot), GetActionCharges(slot)
		local state = ((IsCurrentAction(slot) or enabled == 0) and 1 or 0) +
		              (at == "spell" and IsSpellOverlayed(aid) and 2 or 0) +
		              (nomana and 8 or 0) + (inRange and 0 or 16) + (charges and charges > 0 and 64 or 0) + (hasRange and 512 or 0)
		if charges and maxCharges and charges < maxCharges and cdLeft == 0 then
			cdLeft, cdLength = chargeStart-time + chargeDuration, chargeDuration
		end
		usable = not not (usable and ((cooldown == nil or cooldown == 0) or (enabled == 0) or (charges > 0)))
		return usable, state, GetActionTexture(slot), GetActionText(slot) or (at == "spell" and GetSpellInfo(aid)), count <= 1 and charges or count, cdLeft, cdLength, GameTooltip.SetAction, slot
	end
	local aid = AB:CreateActionSlot(hint, nil, "conditional", "[extrabar]", "attribute", "type","action", "action",slot)
	local aid2 = AB:CreateActionSlot(hint, nil, "attribute", "type","action", "action",slot)
	AB:RegisterActionType("extrabutton", function(id, forceShow)
		return id == 1 and (forceShow and aid2 or aid) or nil
	end, function(id)
		local name, tex = "Extra Action Button", "Interface/Icons/Temp"
		if HasExtraActionBar() then
			local at, aid = GetActionInfo(slot)
			name, tex = GetActionText(slot) or (at == "spell" and GetSpellInfo(aid)) or name, GetActionTexture(slot) or tex
		end
		return "Extra Action Button", name, tex
	end, {"forceShow"})
	AB:AddActionToCategory("Miscellaneous", "extrabutton", 1)
	RW:SetClickHint("ExtraActionButton1", 95, function()
		if HasExtraActionBar() then
			return true, hint()
		end
	end)
end
do -- petspell: spell ID
	local actionID, _, class = {}, UnitClass("player")
	local actionInfo = { stay={"Interface\\Icons\\Spell_Nature_TimeStop", "PET_ACTION_WAIT"}, move={"Interface\\Icons\\Ability_Hunter_Pet_Goto", "PET_ACTION_MOVE_TO", 1}, follow={"Interface\\Icons\\Ability_Tracking", "PET_ACTION_FOLLOW"}, attack={"Interface\\Icons\\Ability_GhoulFrenzy", "PET_ACTION_ATTACK"},
		defend={"Interface\\Icons\\Ability_Defend", "PET_MODE_DEFENSIVE"}, assist={"Interface\\Icons\\Ability_Hunter_Pet_Assist", "PET_MODE_ASSIST"}, passive={"Interface\\Icons\\Ability_Seal", "PET_MODE_PASSIVE"},
		dismiss={class == "WARLOCK" and "Interface\\Icons\\spell_shadow_sacrificialshield" or "Interface\\Icons\\spell_nature_spiritwolf"}}
	local function petTip(self, slot)
		return self:SetSpellBookItem(slot, "pet")
	end
	local function hint(sid)
		local info = actionInfo[sid]
		if sid == "dismiss" then
			if class == "HUNTER" and PetCanBeAbandoned() then
				return spellFeedback(2641, nil, 2641)
			end
			return HasFullControl() and UnitExists("pet") and PetCanBeDismissed(), 0, info[1], PET_ACTION_DISMISS
		elseif info then
			local ico, name, slot = info[1], info[2], info[3]
			if GetSpellBookItemTexture(slot or 0, "pet") ~= ico then
				slot = nil
				for i=1,HasPetSpells() or 0 do
					if GetSpellBookItemTexture(i, "pet") == ico and GetSpellBookItemInfo(i, "pet") == "PETACTION" then
						info[3], slot = i, i
						break
					end
				end
			end
			return not not slot, slot and IsSelectedSpellBookItem(slot, "pet") and 1 or 0, ico, _G[name] or (slot and GetSpellBookItemName(slot, "pet")) or "", 0, 0, 0, slot and petTip or nil, slot
		elseif sid then
			return spellFeedback(sid, nil, sid)
		end
	end
	local function create(id)
		if type(id) == "number" and id > 0 and not actionID[id] then
			actionID[id] = AB:CreateActionSlot(hint, id, "conditional","[petcontrol,known:" .. id .. "];hide", "attribute", "type","spell", "spell",id)
		end
		return actionID[id]
	end
	local function describe(id)
		if type(id) == "number" then
			local name, _, icon = GetSpellInfo(id)
			return "Pet Ability", name, icon, nil, GameTooltip.SetSpellByID, id
		elseif actionID[id] then
			local _, _, icon, name, _, _, _, tipf, tipa = hint(id)
			local _, st = GetSpellBookItemName(tipa or 0, "pet")
			return st or "Pet Ability", name, icon, nil, tipf, tipa
		end
	end
	AB:RegisterActionType("petspell", create, describe)
	do
		local cnd, macroMap = "[petcontrol,@pet,help,novehicleui]", {}
		local function check(...)
			if ... ~= nil then
				return true, ...
			end
		end
		local function macroHint(slash, _, clause, target)
			local aid = clause and macroMap[slash]
			if aid then
				return check(hint(aid))
			end
		end
		local function add(cmd, key)
			actionID[key] = AB:CreateActionSlot(hint, key, "conditional", cnd, "attribute", "type","macro", "macrotext",cmd)
			RW:SetCommandHint(cmd, 75, macroHint)
			macroMap[cmd:lower()] = key
		end
		add(SLASH_PET_STAY1, "stay")
		add(SLASH_PET_MOVE_TO1, "move")
		add(SLASH_PET_FOLLOW1, "follow")
		add(SLASH_PET_ATTACK1, "attack")
		add(SLASH_PET_DEFENSIVE1, "defend")
		add(SLASH_PET_ASSIST1, "assist")
		add(SLASH_PET_PASSIVE1, "passive")
		if class == "HUNTER" then
			actionID["dismiss"] = AB:CreateActionSlot(hint, "dismiss", "conditional", cnd, "attribute", "type","macro", "macrotext",SLASH_CAST1.." "..GetSpellInfo(HUNTER_DISMISS_PET))
		else
			actionID["dismiss"] = AB:CreateActionSlot(hint, "dismiss", "conditional", cnd, "func", PetDismiss)
		end
	end
end
do -- toybox: item ID
	local map = {}
	function toyFeedback(iid)
		local _, name, icon = C_ToyBox.GetToyInfo(iid)
		local cdStart, cdLength = GetItemCooldown(iid)
		return name and cdStart == 0, 0, icon, name, 0, (cdStart or 0) > 0 and (cdStart+cdLength-GetTime()) or 0, cdLength, GameTooltip.SetToyByItemID, iid
	end
	AB:RegisterActionType("toy", function(id)
		if type(id) == "number" and not map[id] then
			if PlayerHasToy(id) then
				local _, name = C_ToyBox.GetToyInfo(id)
				map[id] = AB:CreateActionSlot(toyFeedback, id, "attribute", "type","macro", "macrotext",SLASH_USE_TOY1 .. " " .. name)
			end
		end
		return map[id]
	end, function(id)
		if type(id) ~= "number" then return end
		local _, name, tex = C_ToyBox.GetToyInfo(id)
		return "Toy", name, tex, nil, GameTooltip.SetToyByItemID, id
	end)
	RW:SetCommandHint(SLASH_USE_TOY1, 60, function(slash, _, clause, target)
		if clause and clause ~= "" then
			local _, link = GetItemInfo(clause)
			local iid = link and tonumber(link:match("item:(%d+)"))
			if iid then
				return true, toyFeedback(iid)
			end
		end
	end)
end