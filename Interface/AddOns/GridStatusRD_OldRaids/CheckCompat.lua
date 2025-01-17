-- Check to make sure we are using a compatible version of GridStatusRaidDebuff.

-- Disable if we are using an incompatible version of GridStatusRaidDebuff.

local GSRDVersion = GetAddOnMetadata("GridStatusRaidDebuff","Version")

GridStatusRD_OldRaids = {}
GridStatusRD_OldRaids.rd_version = 0

StaticPopupDialogs["GridStatusRD_OldRaids_Compat"] = {
  text = "GridStatusRaidDebuff is out of date and incompatible. " ..
         "Please upgrade:\n" ..
         "http://www.curse.com/addons/wow/gridstatusraiddebuff-mop",
  button1 = "Close",
  OnAccept = function() end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

function GridStatusRD_OldRaids:PrintNotCompat()
	ChatFrame1:AddMessage("GridStatusRD_OldRaids: Incompatible version of GridStatusRaidDebuff: " .. GSRDVersion)
end

-- With the wrong version of GridStatusRaidDebuff, they already get a pop-up
if GSRDVersion == "v4.99-switch" then
	GridStatusRD_OldRaids:PrintNotCompat()
	return
end

do
	local a, b = strsplit(".", GSRDVersion) -- e.g. "4", "0", "6"
	GridStatusRD_OldRaids.rd_version = 100*a + b -- e.g. 40006
end

local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:SetScript("OnEvent", function(self, event, ...)
	if GridStatusRD_OldRaids.rd_version < 502 then
		GridStatusRD_OldRaids:PrintNotCompat()
		StaticPopup_Show("GridStatusRD_OldRaids_Compat")
	end
end)

