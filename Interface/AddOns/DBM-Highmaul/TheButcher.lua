local mod	= DBM:NewMod(971, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 13746 $"):sub(12, -3))
mod:SetCreatureID(77404)
mod:SetEncounterID(1706)
mod:SetZone()
mod:SetModelSound("sound\\creature\\thebutcher\\VO_60_OGRERAID_BUTCHER_AGGRO.ogg", "sound\\creature\\thebutcher\\VO_60_OGRERAID_BUTCHER_SPELL_B.ogg")

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156157 156293",
	"SPELL_AURA_APPLIED 156152 156151 156598",
	"SPELL_AURA_APPLIED_DOSE 156152 156151",
	"SPELL_AURA_REMOVED 156152",
	"SPELL_CAST_SUCCESS 156143 156172",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Probably fix the update bar if it lua errors or doesn't work right.
local warnCleave					= mod:NewCountAnnounce(156157, 2, nil, false)
local warnTenderizer				= mod:NewStackAnnounce(156151, 2, nil, "Tank")
local warnCleaver					= mod:NewSpellAnnounce("OptionVersion2", 156143, 3, nil, false)--Saberlash
local warnFrenzy					= mod:NewSpellAnnounce(156598, 4)

local specWarnTenderizer			= mod:NewSpecialWarningStack(156151, nil, 2)
local specWarnTenderizerOther		= mod:NewSpecialWarningTaunt(156151, nil, nil, nil, nil, 2)
local specWarnGushingWounds			= mod:NewSpecialWarningStack(156152, nil, 2, nil, nil, nil, 2)
local specWarnBoundingCleave		= mod:NewSpecialWarningCount(156160, nil, nil, nil, 2, 2)
local specWarnBoundingCleaveEnded	= mod:NewSpecialWarningEnd(156160)
local specWarnPaleVitriol			= mod:NewSpecialWarningMove(163046, nil, nil, nil, nil, 2)--Mythic

local timerCleaveCD					= mod:NewCDTimer(6, 156157, nil, false)
local timerTenderizerCD				= mod:NewCDTimer(15.2, 156151, nil, "Tank")
local timerCleaverCD				= mod:NewCDTimer(7.5, 156143, nil, "Tank")
local timerGushingWounds			= mod:NewBuffFadesTimer(15, 156152)
local timerBoundingCleaveCD			= mod:NewNextCountTimer(60, 156160)
local timerBoundingCleave			= mod:NewCastTimer(15, 156160)

local berserkTimer					= mod:NewBerserkTimer(300)

local countdownTenderizer			= mod:NewCountdown("Alt17", 156151, "Tank")
local countdownBoundingCleave		= mod:NewCountdown(60, 156160)

local voiceCleave					= mod:NewVoice(156157, "Melee")
local voiceTenderizer				= mod:NewVoice("OptionVersion2", 156151)
local voiceGushingWound				= mod:NewVoice(156152, false)--off by default because only one person needs to run out in most strats, not everyone. Only that person should enable option
local voiceFrenzy					= mod:NewVoice(156598)
local voiceBoundingCleaveSoon		= mod:NewVoice(156160)
local voicePaleVitriol				= mod:NewVoice(163046) --Mythic only

mod.vb.cleaveCount = 0
mod.vb.boundingCleave = 0
mod.vb.isFrenzied = false

function mod:OnCombatStart(delay)
	self.vb.cleaveCount = 0
	self.vb.boundingCleave = 0
	self.vb.isFrenzied = false
	timerTenderizerCD:Start(6-delay)
	countdownTenderizer:Start(6-delay)
	timerCleaveCD:Start(10-delay)--Verify this wasn't caused by cleave bug.
	timerCleaverCD:Start(12-delay)
	timerBoundingCleaveCD:Start(-delay, 1)
	voiceBoundingCleaveSoon:Schedule(53.5-delay, "156160")
	countdownBoundingCleave:Start(-delay)
	if self:IsMythic() then
		berserkTimer:Start(240-delay)
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE 163046",
			"SPELL_ABSORBED 163046"
		)
	elseif self:IsHeroic() then
		berserkTimer:Start(-delay)
	else
		--Find berserk for LFR & Normal
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156157 or spellId == 156293 then
		self.vb.cleaveCount = self.vb.cleaveCount + 1
		warnCleave:Show(self.vb.cleaveCount)
		if self.vb.isFrenzied then
			timerCleaveCD:Start(3.5)
		else
			timerCleaveCD:Start()
		end
		if not self:IsLFR() then --never play this in LFR
			voiceCleave:Play("156157")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156152 and args:IsPlayer() then
		local amount = args.amount or 1
		timerGushingWounds:Start()
		if (self:IsMythic() and amount > 1) or (self:IsHeroic() and amount > 2) or (self:IsNormal() and amount > 3) then--Mythic max stack 4, heroic 5, normal 6. Common Strats re generally out at 2, 3, 4
			specWarnGushingWounds:Show(amount)
			voiceGushingWound:Play("runout")
		end
	elseif spellId == 156151 then
		local amount = args.amount or 1
		timerTenderizerCD:Start()
		countdownTenderizer:Start()
		if amount >= 2 then
			voiceTenderizer:Play("changemt")
			if args:IsPlayer() then
				specWarnTenderizer:Show(amount)
			else
				if not UnitDebuff("player", GetSpellInfo(156151)) and not UnitIsDeadOrGhost("player") then
					specWarnTenderizerOther:Show(args.destName)
				else
					warnTenderizer:Show(args.destName, amount)
				end
			end
		else
			warnTenderizer:Show(args.destName, amount)
		end
	elseif spellId == 156598 then
		self.vb.isFrenzied = true
		warnFrenzy:Show()
		voiceFrenzy:Play("frenzy")
		--Update bounding cleave timer
		local bossPower = UnitPower("boss1")
		local bossProgress = bossPower * 0.3--Under frenzy he gains energy twice as fast. So about 3.33 energy per seocnd, 30 seconds to full power.
		local timeRemaining = 30-bossProgress
		timerBoundingCleaveCD:Update(bossProgress, 30, self.vb.boundingCleave+1)--Will bar update work correctly on a count bar? Looking at code I don't think it will, it doesn't accept/pass on extra args in Update call.
		countdownBoundingCleave:Cancel()
		voiceBoundingCleaveSoon:Cancel()
		if timeRemaining >= 3 then--Don't start countdown if only 2 seconds left
			countdownBoundingCleave:Start(timeRemaining)
		end
		if timeRemaining >= 8.5 then--Prevent a number lower than 2
			voiceBoundingCleaveSoon:Schedule(30-bossProgress-6.5, "156160")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156152 and args:IsPlayer() then
		timerGushingWounds:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 156143 then
		warnCleaver:Show()
		timerCleaverCD:Start()
	elseif spellId == 156172 then--The cleave finisher of Bounding Cleave. NOT to be confused with other cleave.
		specWarnBoundingCleaveEnded:Show()
		--Timer for when regular cleave resumes
		if self.vb.isFrenzied then
			timerCleaveCD:Start(5)
		else
			timerCleaveCD:Start(11)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 163046 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnPaleVitriol:Show()
		voicePaleVitriol:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 156197 or spellId == 156257 then
		self.vb.cleaveCount = 0
		self.vb.boundingCleave = self.vb.boundingCleave + 1
		timerCleaveCD:Cancel()
		countdownTenderizer:Cancel()
		specWarnBoundingCleave:Show(self.vb.boundingCleave)
		timerTenderizerCD:Start(15)
		countdownTenderizer:Start(15)
		timerCleaverCD:Start(21)
		if self.vb.isFrenzied then
			timerBoundingCleave:Start(5)
			timerBoundingCleaveCD:Start(30, self.vb.boundingCleave+1)
			countdownBoundingCleave:Start(30)
			voiceBoundingCleaveSoon:Schedule(23.5, "156160")
		else
			timerBoundingCleave:Start(9)
			timerBoundingCleaveCD:Start(nil, self.vb.boundingCleave+1)
			countdownBoundingCleave:Start(60)
			voiceBoundingCleaveSoon:Schedule(53.5, "156160")
		end
	end
end
