local mod	= DBM:NewMod(569, "DBM-Party-BC", 3, 259)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 563 $"):sub(12, -3))
mod:SetCreatureID(16808)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_SPELLCAST_SUCCEEDED"
)

--186782 Some Random Orc Icon. Could not find red fel orc icon. Only green orcs or brown orcs. Brown closer to red than green is.
local warnHeathenGuard			= mod:NewCountAnnounce("ej5927", 2, 186782)
local warnReaverGuard			= mod:NewCountAnnounce("ej5930", 2, 186782)
local warnSharpShooterGuard		= mod:NewCountAnnounce("ej5934", 2, 186782)

local specWarnBladeDance		= mod:NewSpecialWarningSpell(30739)

local timerHeathenCD			= mod:NewNextTimer(21, "ej5927", nil, nil, nil, 186782)
local timerReaverCD				= mod:NewNextTimer(21, "ej5930", nil, nil, nil, 186782)
local timerSharpShooterCD		= mod:NewNextTimer(21, "ej5934", nil, nil, nil, 186782)
local timerBladeDanceCD			= mod:NewCDTimer(35, 30739)--Probalby a next timer, but need more data

mod.vb.addSet = 0
mod.vb.addType = 0

local function Adds(self)
	self.vb.addSet = self.vb.addSet + 1
	self.vb.addType = self.vb.addType + 1
	if self.vb.addType == 1 then--Heathen
		warnHeathenGuard:Show(self.vb.addSet.."-"..self.vb.addType)
		timerReaverCD:Start()
	elseif self.vb.addType == 2 then--Reaver
		warnReaverGuard:Show(self.vb.addSet.."-"..self.vb.addType)
		timerSharpShooterCD:Start()
	elseif self.vb.addType == 3 then--SharpShooter
		warnSharpShooterGuard:Show(self.vb.addSet.."-"..self.vb.addType)
		timerHeathenCD:Start()
		self.vb.addType = 0
	end
	self:Schedule(21, Adds, self)
end

function mod:OnCombatStart(delay)
	self.vb.addSet = 0
	self.vb.addType = 0
	timerHeathenCD:Start(29-delay)
	self:Schedule(29, Adds, self)--When reaches stairs, not when enters/spawns way down hallway.
	timerBladeDanceCD:Start(72-delay)
end

--Change to no sync if blizz adds IEEU(boss1)
function mod:UNIT_SPELLCAST_START(uId, _, _, _, spellId)
   if spellId == 30738 then -- Blade Dance Targeting
   		self:SendSync("BladeDance")
   end
end

function mod:OnSync(event, arg)
	if event == "BladeDance" then
		specWarnBladeDance:Show()
		timerBladeDanceCD:Start()
	end
end