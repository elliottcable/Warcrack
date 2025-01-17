local mod	= DBM:NewMod("LichKing", "DBM-Icecrown", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 199 $"):sub(12, -3))
mod:SetCreatureID(36597)
mod:SetEncounterID(1106)
mod:DisableEEKillDetection()--EE fires at 10%
mod:SetModelID(30721)
mod:SetZone()
mod:SetUsedIcons(2, 3, 4, 5, 6, 7, 8)
mod:SetMinSyncRevision(7)--Could break if someone is running out of date version with higher revision

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DISPEL",
	"SPELL_AURA_APPLIED",
	"SPELL_SUMMON",
	"UNIT_HEALTH target focus mouseover",
	"UNIT_AURA_UNFILTERED",
	"UNIT_DIED"
)

local isPAL = select(2, UnitClass("player")) == "PALADIN"
local isPRI = select(2, UnitClass("player")) == "PRIEST"

local warnRemorselessWinter = mod:NewSpellAnnounce(68981, 3) --Phase Transition Start Ability
local warnQuake				= mod:NewSpellAnnounce(72262, 4) --Phase Transition End Ability
local warnRagingSpirit		= mod:NewTargetAnnounce(69200, 3) --Transition Add
local warnShamblingSoon		= mod:NewSoonAnnounce(70372, 2) --Phase 1 Add
local warnShamblingHorror	= mod:NewSpellAnnounce(70372, 3) --Phase 1 Add
local warnDrudgeGhouls		= mod:NewSpellAnnounce(70358, 2) --Phase 1 Add
local warnShamblingEnrage	= mod:NewTargetAnnounce(72143, 3, nil, "Tank|Healer|RemoveEnrage") --Phase 1 Add Ability
local warnNecroticPlague	= mod:NewTargetAnnounce(70337, 3) --Phase 1+ Ability
local warnNecroticPlagueJump= mod:NewAnnounce("WarnNecroticPlagueJump", 4, 70337) --Phase 1+ Ability
local warnPhase2			= mod:NewPhaseAnnounce(2)
local valkyrWarning			= mod:NewAnnounce("ValkyrWarning", 3, 71844)--Phase 2 Ability
local warnDefileSoon		= mod:NewSoonAnnounce(72762, 3)	--Phase 2+ Ability
local warnSoulreaper		= mod:NewSpellAnnounce(69409, 4, nil, "Tank|Healer") --Phase 2+ Ability
local warnDefileCast		= mod:NewTargetAnnounce(72762, 4) --Phase 2+ Ability
local warnSummonValkyr		= mod:NewSpellAnnounce(69037, 3, 71844) --Phase 2 Add
local warnPhase3			= mod:NewPhaseAnnounce(3)
local warnSummonVileSpirit	= mod:NewSpellAnnounce(70498, 2) --Phase 3 Add
local warnHarvestSoul		= mod:NewTargetAnnounce(68980, 3) --Phase 3 Ability
local warnTrapCast			= mod:NewTargetAnnounce(73539, 4) --Phase 1 Heroic Ability
local warnRestoreSoul		= mod:NewCastAnnounce(73650, 2) --Phase 3 Heroic

local specWarnSoulreaper	= mod:NewSpecialWarningYou(69409) --Phase 1+ Ability
local specWarnNecroticPlague= mod:NewSpecialWarningYou(70337) --Phase 1+ Ability
local specWarnRagingSpirit	= mod:NewSpecialWarningYou(69200) --Transition Add
local specWarnYouAreValkd	= mod:NewSpecialWarning("SpecWarnYouAreValkd") --Phase 2+ Ability
local specWarnDefileCast	= mod:NewSpecialWarningYou(72762, nil, nil, nil, 3) --Phase 2+ Ability
local yellDefile			= mod:NewYell(72762)
local specWarnDefileNear	= mod:NewSpecialWarningClose(72762) --Phase 2+ Ability
local specWarnDefile		= mod:NewSpecialWarningMove(72762) --Phase 2+ Ability
local specWarnWinter		= mod:NewSpecialWarningMove(68983) --Transition Ability
local specWarnHarvestSoul	= mod:NewSpecialWarningYou(68980) --Phase 3+ Ability
local specWarnInfest		= mod:NewSpecialWarningSpell(70541, nil, nil, nil, 2) --Phase 1+ Ability
local specwarnSoulreaper	= mod:NewSpecialWarningTarget(69409, "Tank") --phase 2+
local specWarnTrap			= mod:NewSpecialWarningYou(73539, nil, nil, nil, 3) --Heroic Ability
local yellTrap				= mod:NewYell(73539)
local specWarnTrapNear		= mod:NewSpecialWarningClose(73539, nil, nil, nil, 3) --Heroic Ability
local specWarnHarvestSouls	= mod:NewSpecialWarningSpell(73654) --Heroic Ability
local specWarnValkyrLow		= mod:NewSpecialWarning("SpecWarnValkyrLow")

local timerCombatStart		= mod:NewCombatTimer(53.5)
local timerPhaseTransition	= mod:NewTimer(62.5, "PhaseTransition", 72262)
local timerSoulreaper	 	= mod:NewTargetTimer(5.1, 69409, nil, "Tank|Healer")
local timerSoulreaperCD	 	= mod:NewNextTimer(30.5, 69409, nil, "Tank|Healer")
local timerHarvestSoul	 	= mod:NewTargetTimer(6, 68980)
local timerHarvestSoulCD	= mod:NewNextTimer(75, 68980)
local timerInfestCD			= mod:NewNextTimer(22.5, 70541)
local timerNecroticPlagueCleanse = mod:NewTimer(5, "TimerNecroticPlagueCleanse", 70337, "Healer")
local timerNecroticPlagueCD	= mod:NewNextTimer(30, 70337)
local timerDefileCD			= mod:NewNextTimer(32.5, 72762)
local timerEnrageCD			= mod:NewCDTimer(20, 72143, nil, "Tank|RemoveEnrage")
local timerShamblingHorror 	= mod:NewNextTimer(60, 70372)
local timerDrudgeGhouls 	= mod:NewNextTimer(20, 70358)
local timerRagingSpiritCD	= mod:NewNextTimer(22, 69200)
local timerSummonValkyr 	= mod:NewCDTimer(45, 71844)
local timerVileSpirit 		= mod:NewNextTimer(30.5, 70498)
local timerTrapCD		 	= mod:NewNextTimer(15.5, 73539)
local timerRestoreSoul 		= mod:NewCastTimer(40, 73650)
local timerRoleplay			= mod:NewTimer(162, "TimerRoleplay", 72350)

local berserkTimer			= mod:NewBerserkTimer(900)

local countdownInfest		= mod:NewCountdown(22.5, 70541)
local countdownShadowTrap	= mod:NewCountdown(15.5, 73539, nil, nil, nil, nil, true)
local countdownDefile		= mod:NewCountdown(32.5, 72762, nil, nil, nil, nil, true)

mod:AddBoolOption("DefileIcon")
mod:AddBoolOption("NecroticPlagueIcon")
mod:AddBoolOption("RagingSpiritIcon", false)
mod:AddBoolOption("TrapIcon")
mod:AddBoolOption("ValkyrIcon")
mod:AddBoolOption("HarvestSoulIcon", false)
mod:AddBoolOption("AnnounceValkGrabs", false)

mod.vb.phase = 0
local warnedValkyrGUIDs = {}
local plagueHop = GetSpellInfo(70338)--Hop spellID only, not cast one.
local plagueExpires = {}
local lastPlague
local numberOfPlayers = 1

function mod:OnCombatStart(delay)
	numberOfPlayers = DBM:GetNumRealGroupMembers()
	if UnitExists("pet") then
		numberOfPlayers = numberOfPlayers + 1
	end
	self.vb.phase = 0
	self:NextPhase()
	table.wipe(warnedValkyrGUIDs)
	table.wipe(plagueExpires)
	if not self:IsTrivial(90) then--Only warning that uses these events is remorseless winter and that warning is completely useless spam for level 90s.
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE 68983",
			"SPELL_MISSED 68983"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:RestoreWipeTime()
	self:SetWipeTime(5)--Restore it after frostmourn room.
end

function mod:DefileTarget(targetname, uId)
	if not targetname then return end
	warnDefileCast:Show(targetname)
	if self.Options.DefileIcon then
		self:SetIcon(targetname, 8, 4)
	end
	if targetname == UnitName("player") then
		specWarnDefileCast:Show()
		yellDefile:Yell()
	else
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnDefileNear:Show(targetname)
			end
		end
	end
end

function mod:TrapTarget(targetname, uId)
	if not targetname then return end
	warnTrapCast:Show(targetname)
	if self.Options.TrapIcon then
		self:SetIcon(targetname, 8, 4)
	end
	if targetname == UnitName("player") then
		specWarnTrap:Show()
		yellTrap:Yell()
	else
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnTrapNear:Show(targetname)
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68981, 72259) then -- Remorseless Winter (phase transition start)
		warnRemorselessWinter:Show()
		timerPhaseTransition:Start()
		timerRagingSpiritCD:Start(6)
		warnShamblingSoon:Cancel()
		timerShamblingHorror:Cancel()
		timerDrudgeGhouls:Cancel()
		timerSummonValkyr:Cancel()
		timerInfestCD:Cancel()
		countdownInfest:Cancel()
		timerNecroticPlagueCD:Cancel()
		timerTrapCD:Cancel()
		countdownShadowTrap:Cancel()
		timerDefileCD:Cancel()
		countdownDefile:Cancel()
		warnDefileSoon:Cancel()
	elseif args.spellId == 72262 then -- Quake (phase transition end)
		warnQuake:Show()
		timerRagingSpiritCD:Cancel()
		self:NextPhase()
	elseif args.spellId == 70372 then -- Shambling Horror
		warnShamblingSoon:Cancel()
		warnShamblingHorror:Show()
		warnShamblingSoon:Schedule(55)
		timerShamblingHorror:Start()
	elseif args.spellId == 70358 then -- Drudge Ghouls
		warnDrudgeGhouls:Show()
		timerDrudgeGhouls:Start()
	elseif args.spellId == 70498 then -- Vile Spirits
		warnSummonVileSpirit:Show()
		timerVileSpirit:Start()
	elseif args.spellId == 70541 then -- Infest
		specWarnInfest:Show()
		timerInfestCD:Start()
		countdownInfest:Start()
	elseif args.spellId == 72762 then -- Defile
		self:BossTargetScanner(36597, "DefileTarget", 0.02, 15)
		warnDefileSoon:Cancel()
		warnDefileSoon:Schedule(27)
		timerDefileCD:Start()
		countdownDefile:Start()
	elseif args.spellId == 73539 then -- Shadow Trap (Heroic)
		self:BossTargetScanner(36597, "TrapTarget", 0.02, 15)
		timerTrapCD:Start()
		countdownShadowTrap:Start()
	elseif args.spellId == 73650 then -- Restore Soul (Heroic)
		warnRestoreSoul:Show()
		timerRestoreSoul:Start()
	elseif args.spellId == 72350 then -- Fury of Frostmourne
		self:SetWipeTime(190)--Change min wipe time mid battle to force dbm to keep module loaded for this long out of combat roleplay
		self:Stop()
		self:ClearIcons()
		timerRoleplay:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 70337 then -- Necrotic Plague (SPELL_AURA_APPLIED is not fired for this spell)
		lastPlague = args.destName
		warnNecroticPlague:Show(lastPlague)
		timerNecroticPlagueCD:Start()
		timerNecroticPlagueCleanse:Start()
		if args:IsPlayer() then
			specWarnNecroticPlague:Show()
		end
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(args.destName, 5, 5)
		end
	elseif args.spellId == 69409 then -- Soul reaper (MT debuff)
		warnSoulreaper:Show(args.destName)
		specwarnSoulreaper:Show(args.destName)
		timerSoulreaper:Start(args.destName)
		timerSoulreaperCD:Start()
		if args:IsPlayer() then
			specWarnSoulreaper:Show()
		end
	elseif args.spellId == 69200 then -- Raging Spirit
		warnRagingSpirit:Show(args.destName)
		if args:IsPlayer() then
			specWarnRagingSpirit:Show()
		end
		if self.vb.phase == 1 then
			timerRagingSpiritCD:Start()
		else
			timerRagingSpiritCD:Start(17)
		end
		if self.Options.RagingSpiritIcon then
			self:SetIcon(args.destName, 7, 5)
		end
	elseif args.spellId == 68980 then -- Harvest Soul
		warnHarvestSoul:Show(args.destName)
		timerHarvestSoul:Start(args.destName)
		timerHarvestSoulCD:Start()
		if args:IsPlayer() then
			specWarnHarvestSoul:Show()
		end
		if self.Options.HarvestSoulIcon then
			self:SetIcon(args.destName, 6, 5)
		end
	elseif args.spellId == 73654 then -- Harvest Souls (Heroic)
		specWarnHarvestSouls:Show()
		timerVileSpirit:Cancel()
		timerSoulreaperCD:Cancel()
		timerDefileCD:Cancel()
		countdownDefile:Cancel()
		warnDefileSoon:Cancel()
		self:SetWipeTime(50)--We set a 45 sec min wipe time to keep mod from ending combat if you die while rest of raid is in frostmourn
		self:ScheduleMethod(50, "RestoreWipeTime")
	end
end

function mod:SPELL_DISPEL(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 70337 or args.extraSpellId == 70338) then
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 72143 then -- Shambling Horror enrage effect.
		warnShamblingEnrage:Show(args.destName)
		timerEnrageCD:Start(args.sourceGUID)
	elseif args.spellId == 72754 and args:IsPlayer() and self:AntiSpam(2, 1) then		-- Defile Damage
		specWarnDefile:Show()
	elseif args.spellId == 73650 and self:AntiSpam(3, 2) then		-- Restore Soul (Heroic)
		timerHarvestSoulCD:Start(58)
		timerVileSpirit:Start(10)--May be wrong too but we'll see, didn't have enough log for this one.
	end
end

do
	local valkIcons = {}
	local valkyrTargets = {}
	local currentIcon = 2
	local grabIcon = 2
	local iconsSet = 0
	local lastValk = 0
	
	local function resetValkIconState()
		table.wipe(valkIcons)
		currentIcon = 2
		iconsSet = 0
	end
	
	local function scanValkyrTargets()
		if (time() - lastValk) < 10 then    -- scan for like 10secs
			for uId in DBM:GetGroupMembers() do        -- for every raid member check ..
				if UnitInVehicle(uId) and not valkyrTargets[uId] then      -- if person #i is in a vehicle and not already announced 
					valkyrWarning:Show(UnitName(uId))  -- GetRaidRosterInfo(i) returns the name of the person who got valkyred
					valkyrTargets[uId] = true          -- this person has been announced
					if UnitIsUnit(uId, "player") then
						specWarnYouAreValkd:Show()
					end
					if IsInGroup() and mod.Options.AnnounceValkGrabs and DBM:GetRaidRank() > 1 then
						local channel = (IsInRaid() and "RAID") or "PARTY"
						if mod.Options.ValkyrIcon then
							SendChatMessage(L.ValkGrabbedIcon:format(grabIcon, UnitName(uId)), channel)
							grabIcon = grabIcon + 1
						else
							SendChatMessage(L.ValkGrabbed:format(UnitName(uId)), channel)
						end
					end
				end
			end
			mod:Schedule(0.5, scanValkyrTargets)  -- check for more targets in a few
		else
			table.wipe(valkyrTargets)       -- no more valkyrs this round, so lets clear the table
			grabIcon = 2
		end
	end  
	
	
	function mod:SPELL_SUMMON(args)
		if args.spellId == 69037 then -- Summon Val'kyr
			if time() - lastValk > 15 then -- show the warning and timer just once for all three summon events
				warnSummonValkyr:Show()
				if numberOfPlayers > 1 then--It's still cast in solo raid, and they do come, we just don't care since they don't grab main threat target, so supress timer anyways.
					timerSummonValkyr:Start()
				end
				lastValk = time()
				scanValkyrTargets()
				if self.Options.ValkyrIcon then
					resetValkIconState()
				end
			end
			if self.Options.ValkyrIcon then
				valkIcons[args.destGUID] = currentIcon
				currentIcon = currentIcon + 1
			end
		end
	end
	
	mod:RegisterOnUpdateHandler(function(self)
		if self.Options.ValkyrIcon and (DBM:GetRaidRank() > 0 and not (iconsSet == 3 and self:IsDifficulty("normal25", "heroic25") or iconsSet == 1 and self:IsDifficulty("normal10", "heroic10"))) then
			for i = 1, DBM:GetNumGroupMembers() do
				local uId = "raid"..i.."target"
				local guid = UnitGUID(uId)
				if valkIcons[guid] then
					SetRaidTarget(uId, valkIcons[guid])
					iconsSet = iconsSet + 1
					valkIcons[guid] = nil
				end
			end
		end
	end, 1)
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 68983 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then		-- Remorseless Winter
		specWarnWinter:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_HEALTH(uId)
	if self:IsDifficulty("heroic10", "heroic25") and uId == "target" and self:GetUnitCreatureId(uId) == 36609 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.55 and not warnedValkyrGUIDs[UnitGUID(uId)] then
		warnedValkyrGUIDs[UnitGUID(uId)] = true
		specWarnValkyrLow:Show()
	end
end

function mod:NextPhase()
	self.vb.phase = self.vb.phase + 1
	if self.vb.phase == 1 then
		berserkTimer:Start()
		warnShamblingSoon:Schedule(15)
		timerShamblingHorror:Start(20)
		timerDrudgeGhouls:Start(10)
		if numberOfPlayers > 1 then
			timerNecroticPlagueCD:Start(27)
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			timerTrapCD:Start()
			countdownShadowTrap:Start()
		end
	elseif self.vb.phase == 2 then
		warnPhase2:Show()
		if numberOfPlayers > 1 then
			timerSummonValkyr:Start(20)
		end
		timerSoulreaperCD:Start(40)
		timerDefileCD:Start(38)
		countdownDefile:Start(38)
		timerInfestCD:Start(14)
		countdownInfest:Start(14)
		warnDefileSoon:Schedule(33)
	elseif self.vb.phase == 3 then
		warnPhase3:Show()
		timerVileSpirit:Start(20)
		timerSoulreaperCD:Start(40)
		timerDefileCD:Start(38)
		countdownDefile:Start(38)
		timerHarvestSoulCD:Start(14)
		warnDefileSoon:Schedule(33)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.LKPull or msg:find(L.LKPull) then
		self:SendSync("CombatStart")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 37698 then--Shambling Horror
		timerEnrageCD:Cancel(args.sourceGUID)
	end
end

function mod:UNIT_AURA_UNFILTERED(uId)
	local name = DBM:GetUnitFullName(uId)
	if (not name) or (name == lastPlague) then return end
	local expires = select(7, UnitDebuff(uId, plagueHop)) or 0
	local spellId = select(11, UnitDebuff(uId, plagueHop)) or 0
	if spellId == 70338 and expires > 0 and not plagueExpires[expires] then
		plagueExpires[expires] = true
		warnNecroticPlagueJump:Show(name)
		timerNecroticPlagueCleanse:Start()
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(uId, 5, 5)
		end
	end
end

function mod:OnSync(msg, guid)
	if msg == "CombatStart" then
		timerCombatStart:Start()
	end
end
