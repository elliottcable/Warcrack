local ADDON_NAME, private = ...

local Garrison = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)

local AceConfigRegistry = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local LSM = LibStub:GetLibrary("LibSharedMedia-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

local table, print, pairs, strsub, tonumber = _G.table, _G.print, _G.pairs, _G.strsub, _G.tonumber

local garrisonDb, globalDb, configDb

local debugPrint = Garrison.debugPrint

local orderValues = nil

local fonts = {}
local sounds = {}

local prefixSortValue = "sortValue"
local prefixSortAscending = "sortAscending"
local prefixDataOptionTooltip = "dataOptionTooltip"
local prefixDataOptionNotification = "dataOptionNotification"
local prefixDataOptionLDB = "dataOptionLDB"

local prefixDataOptionCharOrder = "dataOptionCharOrder"

local lenPrefixSortValue = _G.strlen(prefixSortValue)
local lenPrefixSortAscending = _G.strlen(prefixSortAscending)
local lenPrefixDataOptionTooltip = _G.strlen(prefixDataOptionTooltip)
local lenPrefixDataOptionNotification = _G.strlen(prefixDataOptionNotification)
local lenPrefixDataOptionLDB = _G.strlen(prefixDataOptionLDB)

local lenPrefixDataOptionCharOrder = _G.strlen(prefixDataOptionCharOrder)
local charLookupTable = {}

local garrisonOptions

StaticPopupDialogs["DELETE_CHARACTER_CONFIRMATION"] = {
	text = "Delete character data? (%s-%s)",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function(self)
		Garrison:deletechar(self.realmName, self.playerName)		
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}


function Garrison:returnchars()
	local a = {}

	for realmName,realmData in Garrison.pairsByKeys(globalDb.data) do
		for playerName,value in Garrison.pairsByKeys(realmData) do

			if (not (Garrison.charInfo.playerName == playerName and Garrison.charInfo.realmName == realmName)) then
				table.insert(a,playerName..":"..realmName)
			end
		end
	end

	table.sort(a)
	return a
end

function Garrison:GetFonts()
	for k in pairs(fonts) do fonts[k] = nil end

	for _, name in pairs(LSM:List(LSM.MediaType.FONT)) do
		fonts[name] = name
	end

	return fonts
end

function Garrison:GetSounds()
	for k in pairs(sounds) do sounds[k] = nil end

	for _, name in pairs(LSM:List(LSM.MediaType.SOUND)) do
		sounds[name] = name
	end

	return sounds
end

function Garrison:GetTemplates(paramType)
	local templates = {}
	for k,v in pairs(Garrison.ldbTemplate) do
		if not v.type or v.type == paramType then
			templates[k] = v.name
		end
	end

	templates["custom"] = L["Custom"]

	return templates
end

function Garrison:GetLDBVariables(paramType)
	local vars = {}

	for k,v in Garrison.sort(Garrison.ldbVars, "name,a") do
		if not v.type or v.type == paramType then
			vars[k] = v.name
		end
	end

	return vars
end

function Garrison:GetTooltipSortOptions(paramType)
	local vars = {}

	for k,v in pairs(Garrison.tooltipConfig) do
		if not v.type or v.type == paramType then
			vars[k] = v.name
		end
	end

	return vars
end

function Garrison:GetLDBText(paramType)
	local template = configDb.general[paramType].ldbTemplate

	local ldbText = ""

	if template == "custom" then
		ldbText = configDb.general[paramType].ldbText
	elseif Garrison.ldbTemplate and Garrison.ldbTemplate[template] then

		ldbText = Garrison.ldbTemplate[template].text
	end

	return ldbText
end


function Garrison:deletechar(realmName, playerName)
	if not realmName or realmName == nil or realmName == "" then return nil end
	if not playerName or playerName == nil or playerName == "" then return nil end

	globalDb.data[realmName][playerName] = nil

	local lastPlayer = true
	for realmName,realmData in pairs(globalDb.data[realmName]) do
		lastPlayer = false
	end

	if lastPlayer then
		globalDb.data[realmName] = nil
	end

	debugPrint(("%s-%s deleted."):format(realmName, playerName))
	garrisonOptions.args.data.args = Garrison.getDataOptionTable()

end


-- Options
function Garrison:GetOptions()
	local options = {
		name = L["Broker Garrison"],
		type = "group",
		childGroups = "tab",
		handler = self,
		args = {
			confdesc = {
				order = 1,
				type = "description",
				name = L["Garrison display for LDB\n"],
				cmdHidden = true,
			},
			general = {
				order = 100,
				type = "group",
				name = L["General"],
				cmdHidden = false,
				args = {				
					garrisonMinimapButton = {
						order = 100,
						type = "toggle",
						width = "full",
						name = L["Hide Garrison Minimap-Button"],
						desc = L["Hide Garrison Minimap-Button"],
						get = function() return configDb.general.hideGarrisonMinimapButton end,
						set = function(_,v) configDb.general.hideGarrisonMinimapButton = v
							Garrison:UpdateConfig()
						end,
					},	
					highAccuracy = {
						order = 110,
						type = "toggle",
						width = "double",
						name = L["High Accuracy"],
						desc = L["Update LDB/Tooltip every second"],
						get = function() return configDb.general.highAccuracy end,
						set = function(_,v) configDb.general.highAccuracy = v
							Garrison:UpdateLDB()
						end,
					},
					showSeconds = {
						order = 115,
						type = "toggle",
						width = "double",
						name = L["Show seconds in LDB/Tooltip"],
						desc = L["Show seconds in LDB/Tooltip"],
						get = function() return configDb.general.showSeconds end,
						set = function(_,v) configDb.general.showSeconds = v
							Garrison:UpdateLDB()
						end,
						--disabled = function() return not configDb.general.highAccuracy end,
					},
					updateInCombat = {
						order = 120,
						type = "toggle",
						width = "double",
						name = L["Run updates (LDB, data queries) in combat"],
						desc = L["Run updates (LDB, data queries) in combat"],
						get = function() return configDb.general.updateInCombat end,
						set = function(_,v) configDb.general.updateInCombat = v
							Garrison:UpdateLDB()
						end,
						--disabled = function() return not configDb.general.highAccuracy end,
					},
					mission = {
						order = 200,
						type = "group",
						name = L["Mission"],
						cmdHidden = false,
						args = {
							ldbHeader = {
								order = 100,
								type = "header",
								name = L["LDB Display"],
								cmdHidden = true,
							},
							ldbLabelText = {
								order = 110,
								type = "input",
								width = "full",
								name = L["Label Text"],
								desc = L["Label Text"],
								get = function() return configDb.general.mission.ldbLabelText end,
								set = function(_,v) configDb.general.mission.ldbLabelText = v
								end,							
							},
							ldbTemplateSelect = {
								order = 120,
								type = "select",
								width = "full",
								name = L["LDB Text"],
								desc = L["LDB Text"],
								values = Garrison:GetTemplates(Garrison.TYPE_MISSION),
								get = function() return configDb.general.mission.ldbTemplate end,
								set = function(_,v) 
									if v then
										if configDb.general.mission.ldbText == "custom" then
											configDb.general.mission.ldbText = Garrison:GetLDBText(Garrison.TYPE_MISSION) or ""
											configDb.general.mission.ldbTemplate = v
										else
											configDb.general.mission.ldbTemplate = v
											configDb.general.mission.ldbText = Garrison:GetLDBText(Garrison.TYPE_MISSION) or ""
										end
									end
								end,
							},							
							ldbText = {
								order = 130,
								type = "input",
								multiline = 5,
								width = "full",
								name = L["Custom LDB Text"],
								desc = L["Custom LDB Text"],
								get = function() return configDb.general.mission.ldbText end,
								set = function(_,v) configDb.general.mission.ldbText = v
								end,
								disabled = function() return not configDb.general.mission.ldbTemplate or not (configDb.general.mission.ldbTemplate == "custom") end,
							},
							ldbVar = {
								order = 140,
								type = "select",
								width = "full",
								name = L["Add item to custom LDB Text"],
								name = L["Add item to custom LDB Text"],
								values = Garrison:GetLDBVariables(Garrison.TYPE_MISSION),
								get = function() return "" end,
								set = function(_,v) 									
									configDb.general.mission.ldbText = ("%s%%%s%%"):format(configDb.general.mission.ldbText or "", v or "")
								end,
								disabled = function() return not configDb.general.mission.ldbTemplate or not (configDb.general.mission.ldbTemplate == "custom") end,
							},

						},
					},
					building = {
						order = 200,
						type = "group",
						name = L["Building"],
						cmdHidden = false,
						args = {					
							ldbHeader = {
								order = 100,
								type = "header",
								name = L["LDB Display"],
								cmdHidden = true,
							},	
							ldbLabelText = {
								order = 110,
								type = "input",
								width = "full",
								name = L["Label Text"],
								desc = L["Label Text"],
								get = function() return configDb.general.building.ldbLabelText end,
								set = function(_,v) configDb.general.building.ldbLabelText = v
								end,							
							},							
							ldbTemplateSelect = {
								order = 120,
								type = "select",
								width = "full",
								name = L["LDB Text"],
								desc = L["LDB Text"],
								values = Garrison:GetTemplates(Garrison.TYPE_BUILDING),
								get = function() return configDb.general.building.ldbTemplate end,
								set = function(_,v) 
									if v then
										if configDb.general.building.ldbText == "custom" then
											configDb.general.building.ldbText = Garrison:GetLDBText(Garrison.TYPE_BUILDING) or ""
											configDb.general.building.ldbTemplate = v
										else
											configDb.general.building.ldbTemplate = v
											configDb.general.building.ldbText = Garrison:GetLDBText(Garrison.TYPE_BUILDING) or ""
										end
									end
									
								end,
							},							
							ldbText = {
								order = 130,
								type = "input",
								width = "full",
								multiline = 5,
								name = L["Custom LDB Text"],
								desc = L["Custom LDB Text"],
								get = function() return configDb.general.building.ldbText end,
								set = function(_,v) configDb.general.building.ldbText = v
								end,
								disabled = function() return not configDb.general.building.ldbTemplate or not (configDb.general.building.ldbTemplate == "custom") end,
							},
							ldbVar = {
								order = 140,
								type = "select",
								width = "full",
								name = L["Add item to custom LDB Text"],
								name = L["Add item to custom LDB Text"],
								values = Garrison:GetLDBVariables(Garrison.TYPE_BUILDING),
								get = function() return "" end,
								set = function(_,v) 									
									configDb.general.building.ldbText = ("%s%%%s%%"):format(configDb.general.building.ldbText or "", v or "")
								end,
								disabled = function() return not configDb.general.building.ldbTemplate or not (configDb.general.building.ldbTemplate == "custom") end,
							},							
	
						},
					},					
				},
			},
			data = {
				order = 200,
				type = "group",
				name = L["Data"],
				cmdHidden = false,
				args = {
				},
			},
			notification = {			
				order = 300,
				type = "group",
				name = L["Notifications"],
				cmdHidden = false,
				args = {
					notificationGeneral = {
						order = 10,
						type = "group",
						name = L["General"],
						cmdHidden = false,
						args = {
							disableInParty = {
								order = 100,
								type = "toggle",
								width = "full",
								name = L["Disable Notifications in Dungeon/Scenario"],
								desc = L["Disable Notifications in Dungeon/Scenario"],
								get = function() return configDb.notification.general.disableInParty end,
								set = function(_,v) configDb.notification.general.disableInParty = v
								end,
							},
							disableInRaid = {
								order = 200,
								type = "toggle",
								width = "full",
								name = L["Disable Notifications in Raid"],
								desc = L["Disable Notifications in Raid"],
								get = function() return configDb.notification.general.disableInRaid end,
								set = function(_,v) configDb.notification.general.disableInRaid = v
								end,
							},
							disableInPvP = {
								order = 300,
								type = "toggle",
								width = "full",
								name = L["Disable Notifications in PvP"],
								desc = L["Disable Notifications in Battleground/arena"],
								get = function() return configDb.notification.general.disableInPvP end,
								set = function(_,v) configDb.notification.general.disableInPvP = v
								end,
							},
						},
					},
					notificationMission = {
						order = 100,
						type = "group",
						name = L["Mission"],
						cmdHidden = false,
						args = {
							notificationToggle = {
								order = 100,
								type = "toggle",
								width = "full",
								name = L["Enable Notifications"],
								desc = L["Enable Notifications"],
								get = function() return configDb.notification.mission.enabled end,
								set = function(_,v) configDb.notification.mission.enabled = v
								end,
							},
							notificationRepeatOnLoad = {
								order = 200,
								type = "toggle",
								width = "full",
								name = L["Repeat on Load"],
								desc = L["Shows notification on each login/ui-reload"],
								get = function() return configDb.notification.mission.repeatOnLoad end,
								set = function(_,v) configDb.notification.mission.repeatOnLoad = v
								end,
								disabled = function() return not configDb.notification.mission.enabled end,
							},
							toastHeader = {
								order = 300,
								type = "header",
								name = L["Toast Notifications"],
								cmdHidden = true,
							},
							toastToggle = {
								order = 310,
								type = "toggle",
								width = "full",
								name = L["Enable Toasts"],
								desc = L["Enable Toasts"],
								get = function() return configDb.notification.mission.toastEnabled end,
								set = function(_,v) configDb.notification.mission.toastEnabled = v
								end,
								disabled = function() return not configDb.notification.mission.enabled end,
							},
							notificationQueueEnabled = {
								order = 315,
								type = "toggle",
								width = "full",
								name = L["Summary on login"],
								desc = L["Summary on login"],
								get = function() return configDb.notification.mission.notificationQueueEnabled end,
								set = function(_,v) configDb.notification.mission.notificationQueueEnabled = v
								end,
								disabled = function() return not configDb.notification.mission.enabled
														or not configDb.notification.mission.toastEnabled end,
							},
							toastPersistent = {
								order = 320,
								type = "toggle",
								width = "full",
								name = L["Persistent Toasts"],
								desc = L["Make Toasts persistent (no auto-hide)"],
								get = function() return configDb.notification.mission.toastPersistent end,
								set = function(_,v) configDb.notification.mission.toastPersistent = v
								end,
								disabled = function() return not configDb.notification.mission.enabled
														or not configDb.notification.mission.toastEnabled end,
							},
							notificationExtendedToast = {
								order = 330,
								type = "toggle",
								width = "full",
								name = L["Advanced Toast controls"],
								desc = L["Adds OK/Dismiss Button to Toasts (Requires 'Repeat on Load')"],
								get = function() return configDb.notification.mission.extendedToast end,
								set = function(_,v) configDb.notification.mission.extendedToast = v
								end,
								disabled = function() return not configDb.notification.mission.enabled
														or not configDb.notification.mission.toastEnabled
														or not configDb.notification.mission.repeatOnLoad
														 end,
							},
							compactToast = {
								order = 340,
								type = "toggle",
								width = "full",
								name = L["Compact Toast"],
								desc = L["Compact Toast"],
								get = function() return configDb.notification.mission.compactToast end,
								set = function(_,v)
									configDb.notification.mission.compactToast = v
								end,
							},							
							miscHeader = {
								order = 400,
								type = "header",
								name = L["Misc"],
								cmdHidden = true,
							},
							hideBlizzardNotification = {
								order = 410,
								type = "toggle",
								width = "full",
								name = L["Hide Blizzard notifications"],
								desc = L["Don't show the built-in notifications"],
								get = function() return configDb.notification.mission.hideBlizzardNotification end,
								set = function(_,v)
									configDb.notification.mission.hideBlizzardNotification = v
									Garrison:UpdateConfig()
								end,
								disabled = function() return not configDb.notification.mission.enabled end,
							},							
							garrisonMinimapButtonAnimation = {
								order = 420,
								type = "toggle",
								width = "full",
								name = L["Hide Minimap-Button animation"],
								desc = L["Don't play pulse/flash animations on Minimap-Button"],
								get = function() return configDb.notification.mission.hideMinimapPulse end,
								set = function(_,v) configDb.notification.mission.hideMinimapPulse = v end,
								disabled = function() return configDb.general.hideGarrisonMinimapButton end,
							},
							playSound = {
								order = 430,
								type = "toggle",
								name = L["Play Sound"],
								desc = L["Play Sound"],
								get = function() return configDb.notification.mission.playSound end,
								set = function(_,v)
									configDb.notification.mission.playSound = v
								end,
								disabled = function() return not configDb.notification.mission.enabled end,
							},
							playSoundOnMissionCompleteName = {
								order = 440,
								type = "select",
								name = L["Sound"],
								desc = L["Sound"],
								dialogControl = "LSM30_Sound",
								values = LSM:HashTable("sound"),
								get = function() return configDb.notification.mission.soundName end,
								set = function(_,v)
									configDb.notification.mission.soundName = v
								end,
								disabled = function() return not configDb.notification.mission.enabled or not configDb.notification.mission.playSound end,
							},
						},
					},
					notificationBuilding = {
						order = 200,
						type = "group",
						name = L["Building"],
						cmdHidden = false,
						args = {
							notificationToggle = {
								order = 100,
								type = "toggle",
								width = "full",
								name = L["Enable Notifications"],
								desc = L["Enable Notifications"],
								get = function() return configDb.notification.building.enabled end,
								set = function(_,v) configDb.notification.building.enabled = v
									Garrison:Update()
								end,
							},
							notificationRepeatOnLoad = {
								order = 200,
								type = "toggle",
								width = "full",
								name = L["Repeat on Load"],
								desc = L["Shows notification on each login/ui-reload"],
								get = function() return configDb.notification.building.repeatOnLoad end,
								set = function(_,v) configDb.notification.building.repeatOnLoad = v
									Garrison:Update()
								end,
								disabled = function() return not configDb.notification.building.enabled end,
							},
							toastHeader = {
								order = 300,
								type = "header",
								name = L["Toast Notifications"],
								cmdHidden = true,
							},
							toastToggle = {
								order = 310,
								type = "toggle",
								width = "full",
								name = L["Enable Toasts"],
								desc = L["Enable Toasts"],
								get = function() return configDb.notification.building.toastEnabled end,
								set = function(_,v) configDb.notification.building.toastEnabled = v
								end,
								disabled = function() return not configDb.notification.building.enabled end,
							},
							notificationQueueEnabled = {
								order = 315,
								type = "toggle",
								width = "full",
								name = L["Summary on login"],
								desc = L["Summary on login"],
								get = function() return configDb.notification.building.notificationQueueEnabled end,
								set = function(_,v) configDb.notification.building.notificationQueueEnabled = v
								end,
								disabled = function() return not configDb.notification.building.enabled
														or not configDb.notification.building.toastEnabled end,
							},							
							toastPersistent = {
								order = 320,
								type = "toggle",
								width = "full",
								name = L["Persistent Toasts"],
								desc = L["Make Toasts persistent (no auto-hide)"],
								get = function() return configDb.notification.building.toastPersistent end,
								set = function(_,v) configDb.notification.building.toastPersistent = v
								end,
								disabled = function() return not configDb.notification.building.enabled
														or not configDb.notification.building.toastEnabled end,
							},
							notificationExtendedToast = {
								order = 330,
								type = "toggle",
								width = "full",
								name = L["Advanced Toast controls"],
								desc = L["Adds OK/Dismiss Button to Toasts (Requires 'Repeat on Load')"],
								get = function() return configDb.notification.building.extendedToast end,
								set = function(_,v) configDb.notification.building.extendedToast = v
								end,
								disabled = function() return not configDb.notification.building.enabled
														or not configDb.notification.building.toastEnabled
														or not configDb.notification.building.repeatOnLoad
														 end,
							},
							compactToast = {
								order = 340,
								type = "toggle",
								width = "full",
								name = L["Compact Toast"],
								desc = L["Compact Toast"],
								get = function() return configDb.notification.building.compactToast end,
								set = function(_,v)
									configDb.notification.building.compactToast = v
								end,
							},							
							miscHeader = {
								order = 400,
								type = "header",
								name = L["Misc"],
								cmdHidden = true,
							},
							hideBlizzardNotification = {
								order = 410,
								type = "toggle",
								width = "full",
								name = L["Hide Blizzard notifications"],
								desc = L["Don't show the built-in notifications"],
								get = function() return configDb.notification.building.hideBlizzardNotification end,
								set = function(_,v)
									configDb.notification.building.hideBlizzardNotification = v
									Garrison:UpdateConfig()
								end,
								disabled = function() return not configDb.notification.building.enabled end,
							},
							garrisonMinimapButtonAnimation = {
								order = 420,
								type = "toggle",
								width = "full",
								name = L["Hide Minimap-Button animation"],
								desc = L["Don't play pulse/flash animations on Minimap-Button"],
								get = function() return configDb.notification.building.hideMinimapPulse end,
								set = function(_,v) configDb.notification.building.hideMinimapPulse = v
								end,
								disabled = function() return configDb.general.hideGarrisonMinimapButton end,
							},							
							playSound = {
								order = 430,
								type = "toggle",
								name = L["Play Sound"],
								desc = L["Play Sound"],
								get = function() return configDb.notification.building.playSound end,
								set = function(_,v)
									configDb.notification.building.playSound = v
								end,
								disabled = function() return not configDb.notification.building.enabled end,
							},
							playSoundOnMissionCompleteName = {
								order = 440,
								type = "select",
								name = L["Sound"],
								desc = L["Sound"],
								dialogControl = "LSM30_Sound",
								values = LSM:HashTable("sound"),
								get = function() return configDb.notification.building.soundName end,
								set = function(_,v)
									configDb.notification.building.soundName = v
								end,
								disabled = function() return not configDb.notification.building.enabled or not configDb.notification.building.playSound end,
							},
						},
					},
					notificationShipment = {
						order = 300,
						type = "group",
						name = L["Shipment"],
						cmdHidden = false,
						args = {
							notificationToggle = {
								order = 100,
								type = "toggle",
								width = "full",
								name = L["Enable Notifications"],
								desc = L["Enable Notifications"],
								get = function() return configDb.notification.shipment.enabled end,
								set = function(_,v) configDb.notification.shipment.enabled = v
									Garrison:Update()
								end,
							},
							notificationRepeatOnLoad = {
								order = 200,
								type = "toggle",
								width = "full",
								name = L["Repeat on Load"],
								desc = L["Shows notification on each login/ui-reload"],
								get = function() return configDb.notification.shipment.repeatOnLoad end,
								set = function(_,v) configDb.notification.shipment.repeatOnLoad = v
									Garrison:Update()
								end,
								disabled = function() return not configDb.notification.shipment.enabled end,
							},
							toastHeader = {
								order = 300,
								type = "header",
								name = L["Toast Notifications"],
								cmdHidden = true,
							},
							toastToggle = {
								order = 310,
								type = "toggle",
								width = "full",
								name = L["Enable Toasts"],
								desc = L["Enable Toasts"],
								get = function() return configDb.notification.shipment.toastEnabled end,
								set = function(_,v) configDb.notification.shipment.toastEnabled = v
								end,
								disabled = function() return not configDb.notification.shipment.enabled end,
							},
							notificationQueueEnabled = {
								order = 315,
								type = "toggle",
								width = "full",
								name = L["Summary on login"],
								desc = L["Summary on login"],
								get = function() return configDb.notification.shipment.notificationQueueEnabled end,
								set = function(_,v) configDb.notification.shipment.notificationQueueEnabled = v
								end,
								disabled = function() return not configDb.notification.shipment.enabled
														or not configDb.notification.shipment.toastEnabled end,
							},							
							toastPersistent = {
								order = 320,
								type = "toggle",
								width = "full",
								name = L["Persistent Toasts"],
								desc = L["Make Toasts persistent (no auto-hide)"],
								get = function() return configDb.notification.shipment.toastPersistent end,
								set = function(_,v) configDb.notification.shipment.toastPersistent = v
								end,
								disabled = function() return not configDb.notification.shipment.enabled
														or not configDb.notification.shipment.toastEnabled end,
							},
							notificationExtendedToast = {
								order = 330,
								type = "toggle",
								width = "full",
								name = L["Advanced Toast controls"],
								desc = L["Adds OK/Dismiss Button to Toasts (Requires 'Repeat on Load')"],
								get = function() return configDb.notification.shipment.extendedToast end,
								set = function(_,v) configDb.notification.shipment.extendedToast = v
								end,
								disabled = function() return not configDb.notification.shipment.enabled
														or not configDb.notification.shipment.toastEnabled
														or not configDb.notification.shipment.repeatOnLoad
														 end,
							},
							compactToast = {
								order = 340,
								type = "toggle",
								width = "full",
								name = L["Compact Toast"],
								desc = L["Compact Toast"],
								get = function() return configDb.notification.shipment.compactToast end,
								set = function(_,v)
									configDb.notification.shipment.compactToast = v
								end,
							},
							miscHeader = {
								order = 400,
								type = "header",
								name = L["Misc"],
								cmdHidden = true,
							},
							hideBlizzardNotification = {
								order = 410,
								type = "toggle",
								width = "full",
								name = L["Hide Blizzard notifications"],
								desc = L["Don't show the built-in notifications"],
								get = function() return configDb.notification.shipment.hideBlizzardNotification end,
								set = function(_,v)
									configDb.notification.shipment.hideBlizzardNotification = v
									Garrison:UpdateConfig()
								end,
								disabled = true --function() return not configDb.notification.shipment.enabled end,
							},
							garrisonMinimapButtonAnimation = {
								order = 420,
								type = "toggle",
								width = "full",
								name = L["Hide Minimap-Button animation"],
								desc = L["Don't play pulse/flash animations on Minimap-Button"],
								get = function() return configDb.notification.shipment.hideMinimapPulse end,
								set = function(_,v) configDb.notification.shipment.hideMinimapPulse = v
								end,
								disabled = function() return configDb.general.hideGarrisonMinimapButton end,
							},
							playSound = {
								order = 430,
								type = "toggle",
								name = L["Play Sound"],
								desc = L["Play Sound"],
								get = function() return configDb.notification.shipment.playSound end,
								set = function(_,v)
									configDb.notification.shipment.playSound = v
								end,
								disabled = function() return not configDb.notification.shipment.enabled end,
							},
							playSoundOnMissionCompleteName = {
								order = 440,
								type = "select",
								name = L["Sound"],
								desc = L["Sound"],
								dialogControl = "LSM30_Sound",
								values = LSM:HashTable("sound"),
								get = function() return configDb.notification.shipment.soundName end,
								set = function(_,v)
									configDb.notification.shipment.soundName = v
								end,
								disabled = function() return not configDb.notification.shipment.enabled or not configDb.notification.shipment.playSound end,
							},
						},
					},	
					outputHeader = {
						order = 500,
						type = "header",
						name = L["Output"],
						cmdHidden = true,
					},
					notificationLibSink = Garrison:GetSinkAce3OptionsDataTable(),
				},
			},			
			display = {
				order = 500,
				type = "group",
				name = L["Display"],
				cmdHidden = false,
				args = {
					scale = {
						order = 110,
						type = "range",
						width = "full",
						name = L["Tooltip Scale"],
						min = 0.5,
						max = 2,
						step = 0.01,
						get = function()
							return configDb.display.scale or 1
						end,
						set = function(info, value)
							configDb.display.scale = value
						end,
					},
					autoHideDelay = {
						order = 120,
						type = "range",
						width = "full",
						name = L["Auto-Hide delay"],
						min = 0.1,
						max = 3,
						step = 0.01,
						get = function()
							return configDb.display.autoHideDelay or 0.25
						end,
						set = function(info, value)
							configDb.display.autoHideDelay = value
						end,
					},
					fontName = {
						order = 130,
						type = "select",
						name = L["Font"],
						desc = L["Font"],
						dialogControl = "LSM30_Font",
						values = LSM:HashTable("font"),
						get = function() return configDb.display.fontName end,
						set = function(_,v)
							configDb.display.fontName = v
						end,
					},
					fontSize = {
						order = 140,
						type = "range",
						min = 5,
						max = 20,
						step = 1,
						width = "full",
						name = L["Font Size"],
						desc = L["Font Size"],
						get = function() return configDb.display.fontSize or 12 end,
						set = function(_,v)
							configDb.display.fontSize = v
						end,
					},
					showIcon = {
						order = 150,
						type = "toggle",
						width = "full",
						name = L["Show Icons"],
						desc = L["Show Icons"],
						get = function() return configDb.display.showIcon end,
						set = function(_,v)
							configDb.display.showIcon = v
						end,
					},
					backgroundColor = {
						order = 160,
						type = "range",
						width = "full",
						step = 1,
						min = 0,
						max = 255,
						name = L["Background Alpha"],
						desc = L["Background Alpha"],
						get = function() return math.floor(configDb.display.backgroundAlpha * 255) end,
						set = function(_,v)
							configDb.display.backgroundAlpha = (v / 255)
						end,
					},
					minimapHeader = {
						order = 200,
						type = "header",
						name = L["Minimap"],
						cmdHidden = true,
					},
					minimapButton = {
						order = 205,
						type = "toggle",
						width = "full",
						name = L["Load Minimap icon"],
						desc = L["Load Minimap icon (requires ui reload!)"],
						get = function() return configDb.minimap.load end,
						set = function(_,v) configDb.minimap.load = v
							Garrison:UpdateConfig()
						end,
					},
					minimapMissionHide = {
						order = 210,
						type = "toggle",
						width = "full",
						name = L["Mission: Hide minimap icon"],
						desc = L["Mission: Hide minimap icon"],
						get = function() return configDb.minimap.mission.hide end,
						set = function(_,v) configDb.minimap.mission.hide = v
							Garrison:UpdateConfig()
						end,
						disabled = function() return not configDb.minimap.load end,
					},
					minimapBuildingHide = {
						order = 220,
						type = "toggle",
						width = "full",
						name = L["Building: Hide minimap icon"],
						desc = L["Building: Hide minimap icon"],
						get = function() return configDb.minimap.building.hide end,
						set = function(_,v) configDb.minimap.building.hide = v
							Garrison:UpdateConfig()
						end,
						disabled = function() return not configDb.minimap.load end,
					},
				},
			},
			tooltip = {
				order = 600,
				type = "group",
				name = L["Tooltip"],
				cmdHidden = false,
				args = {
					mission = {
						order = 100,
						type = "group",
						name = L["Mission"],
						cmdHidden = false,
						args = {
							miscHeader = {
								order = 10,
								type = "header",
								name = L["Misc"],
								cmdHidden = true,
							},
							hideCharactersWithoutMissions = {
								order = 50,
								type = "toggle",
								width = "full",
								name = L["Hide characters without missions"],
								desc = L["Don't display characters without missions"],
								get = function() return configDb.general.mission.hideCharactersWithoutMissions end,
								set = function(_,v) configDb.general.mission.hideCharactersWithoutMissions = v
									Garrison:Update()
								end,						
							},	
							showOnlyCurrentRealm = {
								order = 60,
								type = "toggle",
								width = "full",
								name = L["Show only current realm"],
								desc = L["Show only current realm"],
								get = function() return configDb.general.mission.showOnlyCurrentRealm end,
								set = function(_,v) configDb.general.mission.showOnlyCurrentRealm = v
									Garrison:Update()
								end,						
							},
							collapseOtherCharsOnLogin = {
								order = 70,
								type = "toggle",
								width = "full",
								name = L["Collapse all other characters on login"],
								desc = L["Collapse all other characters on login"],
								get = function() return configDb.general.mission.collapseOtherCharsOnLogin end,
								set = function(_,v) configDb.general.mission.collapseOtherCharsOnLogin = v
									Garrison:Update()
								end,						
							},
							compactTooltip = {
								order = 80,
								type = "toggle",
								width = "full",
								name = L["Compact Tooltip"],
								desc = L["Don't show empty newlines in tooltip"],
								get = function() return configDb.general.mission.compactTooltip end,
								set = function(_,v)
									configDb.general.mission.compactTooltip = v
								end,
							},
							showFollowers = {
								order = 90,
								type = "toggle",
								width = "full",
								name = L["Show followers for each mission"],
								desc = L["Show followers for each mission"],
								get = function() return configDb.general.mission.showFollowers end,
								set = function(_,v)
									configDb.general.mission.showFollowers = v
								end,								
							},			
							showRewards = {
								order = 91,
								type = "toggle",
								width = "full",
								name = L["Show rewards for each mission"],
								desc = L["Show rewards for each mission"],
								get = function() return configDb.general.mission.showRewards end,
								set = function(_,v)
									configDb.general.mission.showRewards = v
								end,
							},
							showRewardXP = {
								order = 92,
								type = "toggle",
								width = "full",
								name = L["Show follower XP rewards"],
								desc = L["Show follower XP rewards"],
								get = function() return configDb.general.mission.showRewardsXP end,
								set = function(_,v)
									configDb.general.mission.showRewardsXP = v
								end,
								disabled = function() return not configDb.general.mission.showRewards end,
							},	
							showRewardsAmount = {
								order = 93,
								type = "toggle",
								width = "full",
								name = L["Show reward amount"],
								desc = L["Show reward amount"],
								get = function() return configDb.general.mission.showRewardsAmount end,
								set = function(_,v)
									configDb.general.mission.showRewardsAmount = v
								end,
								disabled = function() return not configDb.general.mission.showRewards end,
							},							
							groupHeader = {
								order = 100,
								type = "header",
								name = L["Group by"],
								cmdHidden = true,
							},						
							groupOptionValue = {
								order = 200,
								type = "select",
								width = "double",
								name = L["Group by"],
								desc = L["Group by"],
								values = Garrison:GetTooltipSortOptions(Garrison.TYPE_MISSION),
								get = function() return configDb.tooltip.mission.group[1].value end,
								set = function(_,v)
									configDb.tooltip.mission.group[1].value = v
								end,
							},
							groupOptionAscending = {
								order = 201,
								type = "toggle",
								name = L["Sort ascending"],
								desc = L["Sort ascending"],
								get = function() return configDb.tooltip.mission.group[1].ascending end,
								set = function(_,v)
									configDb.tooltip.mission.group[1].ascending = v
								end,
								disabled = function() return (configDb.tooltip.mission.group[1].value or "-") == "-" end,
							},
							groupOptionNewline = {
								order = 202,
								type = "description",
								name = "",
								width = "full",
							},
							sortHeader = {
								order = 300,
								type = "header",
								name = L["Sort by"],
								cmdHidden = true,
							},
						},
					},
					building = {
						order = 200,
						type = "group",
						name = L["Building"],
						cmdHidden = false,
						args = {
							miscHeader = {
								order = 10,
								type = "header",
								name = L["Misc"],
								cmdHidden = true,
							},						
							hideHeader = {
								order = 20,
								type = "toggle",
								width = "full",
								name = L["Hide column header"],
								desc = L["Hide column header"],
								get = function() return configDb.general.building.hideHeader end,
								set = function(_,v) configDb.general.building.hideHeader = v
									Garrison:Update()
								end,						
							},								
							hideBuildingWithoutShipments = {
								order = 50,
								type = "toggle",
								width = "full",
								name = L["Hide buildings without shipments"],
								desc = L["Don't display buildings without shipments (barracks, stables, ...)"],
								get = function() return configDb.general.building.hideBuildingWithoutShipments end,
								set = function(_,v) configDb.general.building.hideBuildingWithoutShipments = v
									Garrison:Update()
								end,						
							},	
							showOnlyCurrentRealm = {
								order = 60,
								type = "toggle",
								width = "full",
								name = L["Show only current realm"],
								desc = L["Show only current realm"],
								get = function() return configDb.general.building.showOnlyCurrentRealm end,
								set = function(_,v) configDb.general.building.showOnlyCurrentRealm = v
									Garrison:Update()
								end,
							},
							collapseOtherCharsOnLogin = {
								order = 70,
								type = "toggle",
								width = "full",
								name = L["Collapse all other characters on login"],
								desc = L["Collapse all other characters on login"],
								get = function() return configDb.general.building.collapseOtherCharsOnLogin end,
								set = function(_,v) configDb.general.building.collapseOtherCharsOnLogin = v
									Garrison:Update()
								end,
							},
							compactTooltip = {
								order = 80,
								type = "toggle",
								width = "full",
								name = L["Compact Tooltip"],
								desc = L["Don't show empty newlines in tooltip"],
								get = function() return configDb.general.building.compactTooltip end,
								set = function(_,v)
									configDb.general.building.compactTooltip = v
								end,
							},							
							groupHeader = {
								order = 100,
								type = "header",
								name = L["Group by"],
								cmdHidden = true,
							},						
							groupOptionValue = {
								order = 200,
								type = "select",
								width = "double",
								name = L["Group by"],
								desc = L["Group by"],
								values = Garrison:GetTooltipSortOptions(Garrison.TYPE_BUILDING),
								get = function() return configDb.tooltip.building.group[1].value end,
								set = function(_,v)
									configDb.tooltip.building.group[1].value = v
								end,
							},
							groupOptionAscending = {
								order = 201,
								type = "toggle",
								name = L["Sort ascending"],
								desc = L["Sort ascending"],
								get = function() return configDb.tooltip.building.group[1].ascending end,
								set = function(_,v)
									configDb.tooltip.building.group[1].ascending = v
								end,
								disabled = function() return (configDb.tooltip.building.group[1].value or "-") == "-" end,
							},
							groupOptionNewline = {
								order = 202,
								type = "description",
								name = "",
								width = "full",
							},						
							sortHeader = {
								order = 300,
								type = "header",
								name = L["Sort by"],
								cmdHidden = true,
							},
						},
					},
				},
			},
			about = {
				order = 900,
				type = "group",
				name = L["About"],
				cmdHidden = false,
				args = {
					aboutHeader = {
						order = 100,
						type = "header",
						name = L["Broker Garrison"],
						cmdHidden = true,
					},
					version = {				
						order = 200,
						type = "description",
						fontSize = "medium",
						name = ("Version: %s\n"):format(Garrison.versionString),
						cmdHidden = true,
					},
					about = {
						order = 300,
						type = "description",
						fontSize = "medium",
						name = ("Author: %s <EU-Khaz'Goroth>\n\nLayout: %s %s / %s <EU-Khaz'Goroth> %s\n\nThanks to:\n\n%s"):format(Garrison.getColoredUnitName("Smb","PRIEST", "EU-Khaz'Goroth"), 
																										 Garrison.getIconString(Garrison.ICON_PATH_ABOUT1, 20, false, false),
																										 Garrison.getColoredUnitName("Jarves","ROGUE", "EU-Khaz'Goroth"),
																										 Garrison.getColoredUnitName("Hotaruby","DRUID", "EU-Khaz'Goroth"),
																										 Garrison.getIconString(Garrison.ICON_PATH_ABOUT1, 20, false, false),
																										 "znf (Ideas)\nStanzilla (Ideas)\nTorhal (Ideas, LibQTip, Toaster, ...)\nMegalon (AILO, Lockouts)"
																										 ),
						cmdHidden = true,
					},
				},
			},
		},
		plugins = {},
	}

	return options
end

function Garrison:SetSortOptionValue(info, value)
	local key = strsub(info[#info], lenPrefixSortValue + 1)
	configDb.tooltip[info[2]].sort[tonumber(key)].value = value
end
function Garrison:GetSortOptionValue(info, ...)	
	local key = strsub(info[#info], lenPrefixSortValue + 1)
	return configDb.tooltip[info[2]].sort[tonumber(key)].value 
end
function Garrison:SetSortOptionAscending(info, value)
	local key = strsub(info[#info], lenPrefixSortAscending + 1)
	configDb.tooltip[info[2]].sort[tonumber(key)].ascending = value
end
function Garrison:GetSortOptionAscending(info, ...)	
	local key = strsub(info[#info], lenPrefixSortAscending + 1)
	return configDb.tooltip[info[2]].sort[tonumber(key)].ascending 
end


function Garrison:GetDataOptionTooltip(info, ...)
	local key = strsub(info[#info], lenPrefixDataOptionTooltip + 1)
	
	local retVal = charLookupTable[tonumber(key)].tooltipEnabled
	if retVal == nil then
		charLookupTable[tonumber(key)].tooltipEnabled = true
		retVal = true
	end

	return retVal
end

function Garrison:GetDataOptionNotification(info, ...)
	local key = strsub(info[#info], lenPrefixDataOptionNotification + 1)
	
	local retVal = charLookupTable[tonumber(key)].notificationEnabled
	if retVal == nil then
		charLookupTable[tonumber(key)].notificationEnabled = true
		retVal = true
	end

	return retVal
end

function Garrison:GetDataOptionLDB(info, ...)
	local key = strsub(info[#info], lenPrefixDataOptionLDB + 1)
	
	local retVal = charLookupTable[tonumber(key)].ldbEnabled
	if retVal == nil then
		charLookupTable[tonumber(key)].ldbEnabled = true
		retVal = true
	end

	return retVal
end

function Garrison:SetDataOptionTooltip(info, value)
	local key = strsub(info[#info], lenPrefixDataOptionTooltip + 1)
	charLookupTable[tonumber(key)].tooltipEnabled = value
end

function Garrison:SetDataOptionNotification(info, value)
	local key = strsub(info[#info], lenPrefixDataOptionNotification + 1)
	charLookupTable[tonumber(key)].notificationEnabled = value
end

function Garrison:SetDataOptionLDB(info, value)
	local key = strsub(info[#info], lenPrefixDataOptionLDB + 1)
	charLookupTable[tonumber(key)].ldbEnabled = value
end

function Garrison:DeleteCharacter(info, ...)
	local key = strsub(info[#info], 10 + 1)
	local playerData = charLookupTable[tonumber(key)]

	if playerData then
		local dialog = StaticPopup_Show("DELETE_CHARACTER_CONFIRMATION", playerData.info.realmName, playerData.info.playerName)
		if dialog then
			dialog.realmName = playerData.info.realmName
			dialog.playerName = playerData.info.playerName
		end
	end

	garrisonOptions.args.data.args = Garrison.getDataOptionTable()
end

function Garrison:SetCharOrder(info, value)	
	local key = strsub(info[#info], lenPrefixDataOptionCharOrder + 1)
	
	charLookupTable[tonumber(key)].order = value

	garrisonOptions.args.data.args = Garrison.getDataOptionTable()
end

function Garrison:GetCharOrder(info, ...)	
	local key = strsub(info[#info], lenPrefixDataOptionCharOrder + 1)
	
	local orderCurrent = charLookupTable[tonumber(key)].order

	return orderCurrent or 5
end

function Garrison:GetCharOrderValues()	

	if orderValues == nil then
		orderValues = {}
		for i=1,11 do
			orderValues[i] = (i < 10 and '0' or '')..tostring(i);
		end
	end

	return orderValues
end


local function GetSortOptionTable(numOptions, paramType, baseOrder, sortTable)

	local i 	

	for i = 1, numOptions do
		sortTable[prefixSortValue..i] = {
			order = baseOrder + (i * 10) ,
			type = "select",
			width = "double",
			name = (L["Sort order %i"]):format(i),
			desc = (L["Sort order %i"]):format(i),
			values = Garrison:GetTooltipSortOptions(paramType),
			get = "GetSortOptionValue",
			set = "SetSortOptionValue",
		}
		sortTable[prefixSortAscending..i] = {
			order = baseOrder + (i * 10) + 1,
			type = "toggle",
			name = L["Sort ascending"],
			desc = L["Sort ascending"],
			get = "GetSortOptionAscending",
			set = "SetSortOptionAscending",
		}
		sortTable["sortNewline"..i] = {
			order = baseOrder + (i * 10) + 2,
			type = "description",
			name = "",
			width = "full",
		}
	end

	return sortTable
end

function Garrison.getDataOptionTable()

	local baseOrder = 100
	
	charLookupTable = {}


	local dataTable = {
		newline = {
			type = "description",
			name = "",
			width = "full",
			order = 80,
		},
		title1 = {
			type = "description",
			name = "Character",
			width = "normal",
			order = 90,
		},
		title2 = {
			type = "description",
			name = L["Tooltip"],
			width = "half",
			order = 91,
		},
		title3 = {
			type = "description",
			name = L["Notifications"],
			width = "half",
			order = 92,
		},
		title4 = {
			type = "description",
			name = L["LDB"],
			width = "half",
			order = 93,
		},
		title5 = {
			type = "description",
			name = "Order",
			width = "half",
			order = 94,
		},
		title6 = {
			type = "description",
			name = "",
			width = "half",
			order = 95,
		},
		title7 = {
			type = "description",
			name = "",
			width = "full",
			order = 95,
		},
	}


	--globalDb
	for realmName,realmData in Garrison.pairsByKeys(globalDb.data) do

		dataTable["dataRealmName"..baseOrder] = {
			order = baseOrder,
			type = "header",
			name = realmName,
			cmdHidden = true,
		}

		local i = 0

		local sortOptions = {}
		sortOptions[#sortOptions] = "order,a"
		sortOptions[#sortOptions] = "info.playerName,a"
			
		local sortedPlayerTable = Garrison.sort(realmData, "order,a", "info.playerName,a")

		for playerName,playerData in sortedPlayerTable do
			dataTable["dataCharName"..(baseOrder + i)] = {
				order = baseOrder + (i * 10),
				type = "description",
				width = "normal",
				name = Garrison.getColoredUnitName(playerData.info.playerName, playerData.info.playerClass, realmName),
				cmdHidden = true,
			}
			dataTable[prefixDataOptionTooltip..(baseOrder + i)] = {
				order = baseOrder + (i * 10) + 1,
				type = "toggle",
				name = "",
				get = "GetDataOptionTooltip",
				set = "SetDataOptionTooltip",
				cmdHidden = false,
				width = "half",
			}
			dataTable[prefixDataOptionNotification..(baseOrder + i)] = {
				order = baseOrder + (i * 10) + 2,
				type = "toggle",
				name = "",
				get = "GetDataOptionNotification",
				set = "SetDataOptionNotification",
				cmdHidden = false,
				width = "half",
			}
			dataTable[prefixDataOptionLDB..(baseOrder + i)] = {
				order = baseOrder + (i * 10) + 3,
				type = "toggle",
				name = "",
				get = "GetDataOptionLDB",
				set = "SetDataOptionLDB",
				cmdHidden = false,
				width = "half",
			}			
			dataTable[prefixDataOptionCharOrder..(baseOrder + i)] = {
				order = baseOrder + (i * 10) + 4,
				type = "select",
				name = "",
				get = "GetCharOrder",
				set = "SetCharOrder",
				values = "GetCharOrderValues",
				cmdHidden = false,
				width = "half",
			}
			dataTable["dataDelete"..(baseOrder + i)] = {
				order = baseOrder + (i * 10) + 5,
				type = "execute",
				name = L["Delete"],
				func = "DeleteCharacter",
				width = "half",
				cmdHidden = true,
			}
			dataTable["dataNewline"..(baseOrder + i)] = {
				order = baseOrder + (i * 10) + 6,
				type = "description",
				name = "",
				width = "full",
				cmdHidden = true,
			}

			charLookupTable[(baseOrder + i)] = playerData

			i = i + 1
		end

		baseOrder = baseOrder + 200
	end

	return dataTable
end

function Garrison:SetupOptions()
	garrisonDb = self.DB
	configDb = garrisonDb.profile
	globalDb = garrisonDb.global

	local options = Garrison:GetOptions()
	garrisonOptions = options

	AceConfigRegistry:RegisterOptionsTable(ADDON_NAME, options, {"brokergarrison", "garrison"})
	Garrison.optionsFrame = AceConfigDialog:AddToBlizOptions(ADDON_NAME, Garrison.cleanName)
	

	-- Fix sink config options
	options.args.notification.args.notificationLibSink.order = 600
	options.args.notification.args.notificationLibSink.inline = true
	options.args.notification.args.notificationLibSink.name = ""
	--options.args.notificationGroup.args.notificationLibSink.disabled = function() return not configDb.notification.enabled end

	options.plugins["profiles"] = {
		--profiles = AceDBOptions:GetOptionsTable(garrisonDb)
	}
	--options.plugins.profiles.profiles.order = 800


	options.args.tooltip.args.building.args = GetSortOptionTable(7, Garrison.TYPE_BUILDING, 400, options.args.tooltip.args.building.args)
	options.args.tooltip.args.mission.args = GetSortOptionTable(7, Garrison.TYPE_MISSION, 400, options.args.tooltip.args.mission.args)	

	options.args.data.args = Garrison.getDataOptionTable()

	--local sortedOptions = Garrison.sort(options.args, "order,a")
	--for k, v in sortedOptions do
	--	if v and v.type == "group" then
	--		print("AddOption "..k)
	--		AceConfigRegistry:RegisterOptionsTable(ADDON_NAME.."-"..k, v)			
	--		AceConfigDialog:AddToBlizOptions(ADDON_NAME.."-"..k, v.name, Garrison.cleanName)
	--	end
	--end
end
