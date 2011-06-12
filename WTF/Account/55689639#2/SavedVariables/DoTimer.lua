
AsheylaLib_Settings = {
	["Default"] = {
		["DoTimer"] = {
			["userAnchors"] = {
				["DoTimer Anchor"] = {
					["default"] = true,
				},
			},
			["updatedSettingsMouseover5.0"] = true,
			["updatedSettings4.3"] = true,
			["keybindings"] = {
				["Timer"] = {
					["Remove"] = "2",
					["Announce"] = "1",
					["Block"] = "s-2",
				},
			},
			["partyBuffs"] = {
				[" spirit"] = 1,
				["soulstone"] = 1,
				["shadow protection"] = 1,
				["thorns"] = 1,
				["blessing of"] = 1,
				["fortitude"] = 1,
				["^elixir"] = 1,
				["shout"] = 1,
				["of the wild"] = 1,
				["arcane"] = 1,
				["^potion"] = 1,
			},
		},
		["TimerLib"] = {
			["timerSettings"] = {
				["Default Timer"] = {
					["barTexture"] = "Banto",
				},
				["PlayerAuras Timer"] = {
					["barLeftText"] = "Time Remaining",
					["fadeInLength"] = 0,
					["barFlipIcon"] = true,
					["timeFormat"] = "letters",
					["barMinorLength"] = 14,
					["barShowIcon"] = true,
					["barFontHeight"] = 10,
					["barMajorLength"] = 150,
					["barGrow"] = false,
					["barRightText"] = "Timer Name",
					["barReversed"] = true,
				},
				["Cooldowns Timer"] = {
					["barGrow"] = false,
					["finalColor"] = {
						["r"] = 0.5254901960784314,
						["g"] = 0.9019607843137255,
						["b"] = 0.2156862745098039,
					},
					["barFlipIcon"] = false,
					["barTexture"] = "Banto-V",
					["barOrientation"] = "vertical",
					["barReversed"] = false,
					["barMajorLength"] = 85,
					["barMinorLength"] = 30,
					["startColor"] = {
						["r"] = 0.9019607843137255,
						["g"] = 0.2274509803921569,
						["b"] = 0.3019607843137255,
					},
				},
				["DoTimer Timer"] = {
				},
				["Debuff Timer"] = {
					["barLeftText"] = "Timer Name",
					["barFlipIcon"] = false,
					["reference"] = "PlayerAuras Timer",
					["barRightText"] = "Time Remaining",
					["barReversed"] = false,
				},
			},
			["anchorSettings"] = {
				["DoTimer Mouseover"] = {
					["positionX"] = 25,
					["positionY"] = -10,
				},
				["Cooldowns Anchor"] = {
					["overflowPoint"] = 0,
					["expectedScale"] = 0.6399999856948853,
					["defaultTimerSetting"] = "Cooldowns Timer",
					["scale"] = 1,
					["timerSpacing"] = 5,
					["positionY"] = 152.2435684204101,
					["groupDirection"] = "right",
					["anchorPoint"] = "BOTTOMLEFT",
					["displayNames"] = false,
					["positionX"] = 559.8895874023438,
					["timerSortMethod"] = "Time Added (A)",
					["locked"] = true,
					["maxNumGroups"] = 1,
					["overflowDirection"] = "up",
					["timerDirection"] = "right",
				},
				["Default Anchor"] = {
					["overflowPoint"] = 20,
					["timerDirection"] = "down",
					["scale"] = 0.800000011920929,
					["timerSpacing"] = 0,
					["standardAlpha"] = 0.800000011920929,
					["displayNames"] = true,
					["anchorPoint"] = "TOPLEFT",
					["mouseoverAlpha"] = 1,
					["combatAlpha"] = 0.800000011920929,
					["relativePoint"] = "BOTTOMLEFT",
					["expectedScale"] = 0.6399999856948853,
					["groupSpacing"] = 5,
					["overflowDirection"] = "right",
					["moveName"] = true,
				},
				["PlayerAuras Anchor"] = {
					["overflowPoint"] = 5,
					["expectedScale"] = 0.6399999856948853,
					["defaultTimerSetting"] = "PlayerAuras Timer",
					["interactable"] = true,
					["anchorPoint"] = "BOTTOMRIGHT",
					["positionY"] = 695.1258239746094,
					["locked"] = true,
					["groupSortMethod"] = "Time Added (A)",
					["mouseoverAlpha"] = 0.6000000238418579,
					["groupDirection"] = "up",
					["displayNames"] = false,
					["positionX"] = 975.7052612304688,
					["timerDirection"] = "up",
					["standardAlpha"] = 0.4000000059604645,
					["timerSortMethod"] = "Time Added (A)",
					["overflowDirection"] = "left",
					["combatAlpha"] = 0.800000011920929,
				},
				["DoTimer Anchor"] = {
					["positionY"] = 987.2465209960938,
					["positionX"] = 1689.742736816406,
					["defaultTimerSetting"] = "DoTimer Timer",
				},
				["Notifications Anchor"] = {
					["locked"] = true,
					["positionY"] = 499.9999694824219,
					["positionX"] = 565.4808959960938,
					["expectedScale"] = 0.6399999856948853,
				},
				["Debuffs"] = {
					["overflowPoint"] = 5,
					["timerDirection"] = "up",
					["defaultTimerSetting"] = "Debuff Timer",
					["groupSortMethod"] = "Time Added (A)",
					["mouseoverAlpha"] = 0.6000000238418579,
					["groupDirection"] = "up",
					["anchorPoint"] = "BOTTOMLEFT",
					["displayNames"] = false,
					["positionX"] = 1158.309875488281,
					["positionY"] = 692.5502624511719,
					["locked"] = true,
					["timerSortMethod"] = "Time Added (A)",
					["overflowDirection"] = "right",
					["standardAlpha"] = 0.4000000059604645,
				},
			},
		},
		["Cooldowns"] = {
			["keybindings"] = {
				["Timer"] = {
					["Remove"] = "2",
					["Announce"] = "1",
					["Block"] = "s-2",
				},
			},
			["userAnchors"] = {
				["Cooldowns Anchor"] = {
					["timerSettings"] = {
					},
					["timers"] = {
					},
					["externalLoc"] = false,
					["default"] = true,
				},
			},
			["updatedSettings4.3"] = true,
			["minCooldown"] = 2,
			["maxCooldown"] = 0,
		},
		["VersionCommunication"] = {
		},
		["Notifications"] = {
			["updatedSettings4.3.1"] = true,
		},
		["PlayerAuras"] = {
			["userAnchors-Buffs"] = {
				["PlayerAuras Anchor"] = {
					["default"] = true,
				},
			},
			["userAnchors-Buffs-pet"] = {
				["PetAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["userAnchors-Buffs-target"] = {
				["TargetAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["userAnchors-Debuffs-target"] = {
				["TargetAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["userAnchors-Debuffs-pet"] = {
				["PetAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["userAnchors-Debuffs"] = {
				["PlayerAuras Anchor"] = {
					["timerSettings"] = {
					},
					["timers"] = {
					},
				},
				["Debuffs"] = {
					["default"] = 1,
				},
			},
			["userAnchors-Buffs-focus"] = {
				["FocusAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["whiteList-Buffs"] = false,
			["keybindings"] = {
				["Timer"] = {
					["Remove"] = "2",
					["Announce"] = "1",
					["Block"] = "s-2",
				},
			},
			["userAnchors-Debuffs-focus"] = {
				["FocusAuras Anchor"] = {
					["timers"] = {
					},
					["default"] = true,
					["timerSettings"] = {
					},
				},
			},
			["blizzBuffs"] = true,
			["updatedSettings4.3"] = true,
			["updatedSettings4.3.3"] = true,
		},
	},
	["simpleMode"] = false,
}