local L = LibStub("AceLocale-3.0"):GetLocale("IceHUD", false)
IceCustomCount = IceCore_CreateClass(IceElement)

local IceHUD = _G.IceHUD

IceCustomCount.prototype.countSize = 20
IceCustomCount.prototype.lastPoints = 0

local validUnits = {"player", "target", "focus", "pet", "vehicle", "targettarget", "main hand weapon", "off hand weapon"}
local buffOrDebuff = {"buff", "debuff", "charges", "spell count"}

-- Constructor --
function IceCustomCount.prototype:init()
	IceCustomCount.super.prototype.init(self, "CustomCount")

	self.scalingEnabled = true
end


-- OVERRIDE
function IceCustomCount.prototype:GetOptions()
	local opts = IceCustomCount.super.prototype.GetOptions(self)

	opts["customHeader"] = {
		type = 'header',
		name = L["Aura settings"],
		order = 30.1,
	}

	opts["deleteme"] = {
		type = 'execute',
		name = L["Delete me"],
		desc = L["Deletes this custom module and all associated settings. Cannot be undone!"],
		func = function()
			local dialog = StaticPopup_Show("ICEHUD_DELETE_CUSTOM_MODULE")
			if dialog then
				dialog.data = self
			end
		end,
		order = 20.1,
	}

	opts["duplicateme"] = {
		type = 'execute',
		name = L["Duplicate me"],
		desc = L["Creates a new module of this same type and with all the same settings."],
		func = function()
			IceHUD:CreateCustomModuleAndNotify(self.moduleSettings.customBarType, self.moduleSettings)
		end,
		order = 20.2,
	}

	opts["type"] = {
		type = "description",
		name = string.format("%s %s", L["Module type:"], tostring(self:GetBarTypeDescription("Counter"))),
		order = 21,
	}

	opts["name"] = {
		type = 'input',
		name = L["Counter name"],
		desc = L["The name of this counter (must be unique!). \n\nRemember to press ENTER after filling out this box with the name you want or it will not save."],
		get = function()
			return self.elementName
		end,
		set = function(info, v)
			if v ~= "" then
				IceHUD.IceCore:RenameDynamicModule(self, v)
			end
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		usage = "<a name for this bar>",
		order = 30.3,
	}

	opts["auraTarget"] = {
		type = 'select',
		values = validUnits,
		name = L["Unit to track"],
		desc = L["Select which unit that this bar should be looking for buffs/debuffs on"],
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.auraTarget)
		end,
		set = function(info, v)
			self.moduleSettings.auraTarget = info.option.values[v]
			self.unit = info.option.values[v]
			self:Redraw()
			IceHUD:NotifyOptionsChange()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.moduleSettings.auraType == "charges" or self.moduleSettings.auraType == "spell count"
		end,
		order = 30.4,
	}

	opts["auraType"] = {
		type = 'select',
		values = buffOrDebuff,
		name = L["Buff or debuff?"],
		desc = L["Whether we are tracking a buff or debuff"],
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.auraType)
		end,
		set = function(info, v)
			self.moduleSettings.auraType = info.option.values[v]
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.unit == "main hand weapon" or self.unit == "off hand weapon"
		end,
		order = 30.5,
	}

	opts["auraName"] = {
		type = 'input',
		name = L["Aura to track"],
		desc = L["Which buff/debuff this counter will be tracking. \n\nRemember to press ENTER after filling out this box with the name you want or it will not save."],
		get = function()
			return self.moduleSettings.auraName
		end,
		set = function(info, v)
			self.moduleSettings.auraName = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.unit == "main hand weapon" or self.unit == "off hand weapon"
		end,
		usage = "<which aura to track>",
		order = 30.6,
	}

	opts["trackOnlyMine"] = {
		type = 'toggle',
		name = L["Only track auras by me"],
		desc = L["Checking this means that only buffs or debuffs that the player applied will trigger this bar"],
		get = function()
			return self.moduleSettings.onlyMine
		end,
		set = function(info, v)
			self.moduleSettings.onlyMine = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.unit == "main hand weapon" or self.unit == "off hand weapon"
				or self.moduleSettings.auraType == "charges" or self.moduleSettings.auraType == "spell count"
		end,
		order = 30.7,
	}

	opts["countColor"] = {
		type = 'color',
		name = L["Count color"],
		desc = L["The color for this counter"],
		get = function()
			return self:GetCustomColor()
		end,
		set = function(info, r,g,b)
			self.moduleSettings.countColor.r = r
			self.moduleSettings.countColor.g = g
			self.moduleSettings.countColor.b = b
			self:SetCustomColor()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 30.8,
	}

	opts["countMinColor"] = {
		type = 'color',
		name = L["Count minimum color"],
		desc = L["The minimum color for this counter (only used if Change Color is enabled)"],
		get = function()
			return self:GetCustomMinColor()
		end,
		set = function(info, r,g,b)
			self.moduleSettings.countMinColor.r = r
			self.moduleSettings.countMinColor.g = g
			self.moduleSettings.countMinColor.b = b
			self:SetCustomColor()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.gradient
		end,
		order = 30.81,
	}

	opts["maxCount"] = {
		type = 'input',
		name = L["Maximum applications"],
		desc = L["How many total applications of this buff/debuff can be applied. For example, only 5 sunders can ever be on a target, so this would be set to 5 for tracking Sunder.\n\nRemember to press ENTER after filling out this box with the name you want or it will not save."],
		get = function()
			return tostring(self.moduleSettings.maxCount)
		end,
		set = function(info, v)
			if not v or not tonumber(v) or tonumber(v) <= 0 then
				v = 5
			end
			self.moduleSettings.maxCount = tonumber(v)
			self:CreateCustomFrame(true)
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.moduleSettings.auraType == "charges"
		end,
		usage = "<the maximum number of valid applications>",
		order = 30.9,
	}

	opts["normalHeader"] = {
		type = 'header',
		name = L["Counter look and feel"],
		order = 31,
	}

	opts["vpos"] = {
		type = "range",
		name = L["Vertical Position"],
		desc = L["Vertical Position"],
		get = function()
			return self.moduleSettings.vpos
		end,
		set = function(info, v)
			self.moduleSettings.vpos = v
			self:Redraw()
		end,
		min = -400,
		max = 700,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 31.1
	}

	opts["hpos"] = {
		type = "range",
		name = L["Horizontal Position"],
		desc = L["Horizontal Position"],
		get = function()
			return self.moduleSettings.hpos
		end,
		set = function(info, v)
			self.moduleSettings.hpos = v
			self:Redraw()
		end,
		min = -700,
		max = 700,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 31.2
	}

	opts["CustomFontSize"] = {
		type = "range",
		name = L["Font Size"],
		desc = L["Font Size"],
		get = function()
			return self.moduleSettings.countFontSize
		end,
		set = function(info, v)
			self.moduleSettings.countFontSize = v
			self:Redraw()
		end,
		min = 10,
		max = 40,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled or self.moduleSettings.countMode ~= "Numeric"
		end,
		order = 32
	}

	opts["CustomMode"] = {
		type = 'select',
		name = L["Display Mode"],
		desc = L["Show graphical or numeric counts"],
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.countMode)
		end,
		set = function(info, v)
			self.moduleSettings.countMode = info.option.values[v]
			self:CreateCustomFrame(true)
			self:Redraw()
			IceHUD:NotifyOptionsChange()
		end,
		values = { "Numeric", "Graphical Bar", "Graphical Circle", "Graphical Glow", "Graphical Clean Circle" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 33
	}

	opts["graphicalLayout"] = {
		type = 'select',
		name = L["Layout"],
		desc = L["How the graphical counter should be displayed"],
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.graphicalLayout)
		end,
		set = function(info, v)
			self.moduleSettings.graphicalLayout = info.option.values[v]
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.moduleSettings.countMode == "Numeric"
		end,
		values = {"Horizontal", "Vertical"},
		order = 33.1
	}

	opts["countGap"] = {
		type = 'range',
		name = L["Icon gap"],
		desc = L["Spacing between each icon (only works for graphical mode)"],
		min = 0,
		max = 100,
		step = 1,
		get = function()
			return self.moduleSettings.countGap
		end,
		set = function(info, v)
			self.moduleSettings.countGap = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.moduleSettings.countMode == "Numeric"
		end,
		order = 33.2
	}

	opts["gradient"] = {
		type = "toggle",
		name = L["Change color"],
		desc = L["This will fade the bars or numeric representation from the min color specified to the regular color\n\n(e.g. if the min color is yellow, the color is red, and there are 3 total applications, then the first would be yellow, second orange, and third red)"],
		get = function()
			return self.moduleSettings.gradient
		end,
		set = function(info, v)
			self.moduleSettings.gradient = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 34
	}

	return opts
end

function IceCustomCount.prototype:GetCustomColor()
	return self.moduleSettings.countColor.r, self.moduleSettings.countColor.g, self.moduleSettings.countColor.b, self.alpha
end

function IceCustomCount.prototype:GetCustomMinColor()
	return self.moduleSettings.countMinColor.r, self.moduleSettings.countMinColor.g, self.moduleSettings.countMinColor.b, self.alpha
end

function IceCustomCount.prototype:GetMaxCount()
	if self.moduleSettings.auraType == "charges" then
		local _, max = GetSpellCharges(self.moduleSettings.auraName)
		return max or 1
	else
		return self.moduleSettings.maxCount
	end
end

-- OVERRIDE
function IceCustomCount.prototype:GetDefaultSettings()
	local defaults =  IceCustomCount.super.prototype.GetDefaultSettings(self)
	defaults["vpos"] = 0
	defaults["hpos"] = 0
	defaults["countFontSize"] = 20
	defaults["countMode"] = "Numeric"
	defaults["gradient"] = false
	defaults["usesDogTagStrings"] = false
	defaults["alwaysFullAlpha"] = true
	defaults["graphicalLayout"] = "Horizontal"
	defaults["countGap"] = 0
	defaults["maxCount"] = 5
	defaults["auraTarget"] = "player"
	defaults["auraName"] = ""
	defaults["onlyMine"] = true
	defaults["customBarType"] = "Counter"
	defaults["countMinColor"] = {r=1, g=1, b=0, a=1}
	defaults["countColor"] = {r=1, g=0, b=0, a=1}
	defaults["auraType"] = "buff"
	return defaults
end


-- OVERRIDE
function IceCustomCount.prototype:Redraw()
	IceCustomCount.super.prototype.Redraw(self)

	self:CreateFrame()
	self:UpdateCustomCount()
end


-- OVERRIDE
function IceCustomCount.prototype:Enable(core)
	IceCustomCount.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "UpdateCustomCount")
	self:RegisterEvent("UNIT_PET", "UpdateCustomCount")
	self:RegisterEvent("PLAYER_PET_CHANGED", "UpdateCustomCount")
	self:RegisterEvent("PLAYER_FOCUS_CHANGED", "UpdateCustomCount")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateCustomCount")
	self:RegisterEvent("PLAYER_DEAD", "UpdateCustomCount")
	self:RegisterEvent("SPELL_UPDATE_CHARGES", "UpdateCustomCount")

	self.unit = self.moduleSettings.auraTarget or "player"

	if not tonumber(self.moduleSettings.maxCount) or tonumber(self.moduleSettings.maxCount) <= 0 then
		self.moduleSettings.maxCount = 5
		self:CreateCustomFrame(true)
		self:Redraw()
	else
		self:CreateCustomFrame(true)
	end
	self:UpdateCustomCount()
end



-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function IceCustomCount.prototype:CreateFrame()
	IceCustomCount.super.prototype.CreateFrame(self)

	self.frame:SetFrameStrata("BACKGROUND")
	if self.moduleSettings.graphicalLayout == "Horizontal" then
		self.frame:SetWidth((self.countSize + self.moduleSettings.countGap)*self:GetMaxCount())
		self.frame:SetHeight(1)
	else
		self.frame:SetWidth(1)
		self.frame:SetHeight((self.countSize + self.moduleSettings.countGap)*self:GetMaxCount())
	end
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", self.parent, "BOTTOM", self.moduleSettings.hpos, self.moduleSettings.vpos)

	self:Show(true)

	self:CreateCustomFrame()
end



function IceCustomCount.prototype:CreateCustomFrame(doTextureUpdate)
	-- create numeric counts
	self.frame.numeric = self:FontFactory(self.moduleSettings.countFontSize, nil, self.frame.numeric)

	self.frame.numeric:SetWidth(50)
	self.frame.numeric:SetJustifyH("CENTER")

	self.frame.numeric:SetPoint("TOP", self.frame, "TOP", 0, 0)
	self.frame.numeric:Show()

	if (not self.frame.graphicalBG) then
		self.frame.graphicalBG = {}
		self.frame.graphical = {}
	end

	local max = self:GetMaxCount()

	-- create backgrounds
	for i = 1, max do
		if (not self.frame.graphicalBG[i]) then
			local frame = CreateFrame("Frame", nil, self.frame)
			self.frame.graphicalBG[i] = frame
			frame.texture = frame:CreateTexture()
			frame.texture:SetAllPoints(frame)
		end

		if doTextureUpdate then
			if self.moduleSettings.countMode == "Graphical Bar" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboBG")
			elseif self.moduleSettings.countMode == "Graphical Circle" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboRoundBG")
			elseif self.moduleSettings.countMode == "Graphical Glow" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboGlowBG")
			elseif self.moduleSettings.countMode == "Graphical Clean Circle" then
				self.frame.graphicalBG[i].texture:SetTexture(IceElement.TexturePath .. "ComboCleanCurvesBG")
			end
		end

		self.frame.graphicalBG[i]:SetFrameStrata("BACKGROUND")
		self.frame.graphicalBG[i]:SetWidth(self.countSize)
		self.frame.graphicalBG[i]:SetHeight(self.countSize)
		if self.moduleSettings.graphicalLayout == "Horizontal" then
			self.frame.graphicalBG[i]:SetPoint("TOPLEFT", ((i-1) * (self.countSize-5)) + (i-1) + ((i-1) * self.moduleSettings.countGap), 0)
		else
			self.frame.graphicalBG[i]:SetPoint("TOPLEFT", 0, -1 * (((i-1) * (self.countSize-5)) + (i-1) + ((i-1) * self.moduleSettings.countGap)))
		end
		self.frame.graphicalBG[i]:SetAlpha(0.15)

		self.frame.graphicalBG[i]:Hide()
	end

	-- create counts
	for i = 1, max do
		if (not self.frame.graphical[i]) then
			local frame = CreateFrame("Frame", nil, self.frame)
			self.frame.graphical[i] = frame
			frame.texture = frame:CreateTexture()
			frame.texture:SetAllPoints(frame)
		end

		if doTextureUpdate then
			if self.moduleSettings.countMode == "Graphical Bar" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "Combo")
			elseif self.moduleSettings.countMode == "Graphical Circle" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboRound")
			elseif self.moduleSettings.countMode == "Graphical Glow" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboGlow")
			elseif self.moduleSettings.countMode == "Graphical Clean Circle" then
				self.frame.graphical[i].texture:SetTexture(IceElement.TexturePath .. "ComboCleanCurves")
			end
		end

		self.frame.graphical[i]:SetFrameStrata("BACKGROUND")
		self.frame.graphical[i]:SetAllPoints(self.frame.graphicalBG[i])

		self.frame.graphical[i]:Hide()
	end

	self:SetCustomColor()
end


function IceCustomCount.prototype:SetCustomColor()
	for i=1, self:GetMaxCount() do
		self.frame.graphicalBG[i].texture:SetVertexColor(self:GetCustomColor())

		local r, g, b = self:GetCustomColor()
		if (self.moduleSettings.gradient) then
			r,g,b = self:GetGradientColor(i)
		end
		self.frame.graphical[i].texture:SetVertexColor(r, g, b)
	end
end

function IceCustomCount.prototype:GetGradientColor(curr)
	local max = self:GetMaxCount()
	local r, g, b = self:GetCustomColor()
	local mr, mg, mb = self:GetCustomMinColor()
	local scale = max > 1 and ((curr-1)/(max-1)) or 1

	r = r * scale + mr * (1-scale)
	g = g * scale + mg * (1-scale)
	b = b * scale + mb * (1-scale)

	return r, g, b
end


function IceCustomCount.prototype:UpdateCustomCount()
	if not self.moduleSettings.auraName then
		return
	end

	local points
	if IceHUD.IceCore:IsInConfigMode() then
		points = tonumber(self.moduleSettings.maxCount)
	else
		if self.moduleSettings.auraType == "charges" then
			points = GetSpellCharges(self.moduleSettings.auraName) or 0
		elseif self.moduleSettings.auraType == "spell count" then
			points = GetSpellCount(self.moduleSettings.auraName) or 0
		else
			points = IceHUD:GetAuraCount(self.moduleSettings.auraType == "buff" and "HELPFUL" or "HARMFUL",
				self.unit, self.moduleSettings.auraName, self.moduleSettings.onlyMine, true)
		end
	end

	self.lastPoints = points

	if (points == 0) then
		points = nil
	end

	if (self.moduleSettings.countMode == "Numeric") then
		local r, g, b = self:GetCustomColor()
		if (self.moduleSettings.gradient and points) then
			r, g, b = self:GetGradientColor(points)
		end
		self.frame.numeric:SetTextColor(r, g, b, 0.7)

		self.frame.numeric:SetText(points)
	else
		self.frame.numeric:SetText()

		for i = 1, table.getn(self.frame.graphical) do
			if (points ~= nil) then
				self.frame.graphicalBG[i]:Show()
			else
				self.frame.graphicalBG[i]:Hide()
			end

			if (points ~= nil and i <= points) then
				self.frame.graphical[i]:Show()
			else
				self.frame.graphical[i]:Hide()
			end
		end
	end

	self:Update()
end

function IceCustomCount.prototype:UseTargetAlpha(scale)
	return self.lastPoints ~= nil and self.lastPoints > 0
end
