--[[

	AtlasQuest, a World of Warcraft addon.
	Email me at mystery8@gmail.com

	This file is part of AtlasQuest.

	AtlasQuest is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	AtlasQuest is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with AtlasQuest; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

-----------------------------------------------------------------------------
-- Colours
-----------------------------------------------------------------------------

local PURPLE = "|cff999999"; -- grey atm -- removed/useless atm
local RED = "|cffff0000";
local REDA = "|cffcc6666";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local GREY = "|cff9F3FFF"; -- purple now ^^
local BLUE = "|cff0070dd";
local ORANGE = "|cffff6090"; -- it is pink now
local YELLOW = "|cffffff00";
local BLACK = "|c0000000f";
local DARKGREEN = "|cff008000";
local BLUB = "|cffd45e19";

-- Quest Color
local Grau = "|cff9d9d9d"
local Gruen = "|cff1eff00"
local Orange = "|cffFF8000"
local Rot = "|cffFF0000"
local Gelb = "|cffFFd200"
local Blau = "|cff0070dd"



-----------------------------------------------------------------------------
-- Variables
-----------------------------------------------------------------------------

AQ = {};

local Initialized = nil; -- the variables are not loaded yet

LibStub("LibAboutPanel").new(parentframe, "AtlasQuest")

Allianceorhorde = 1; -- variable that configures whether horde or alliance is shown

AQINSTANZ = 1; -- currently shown instance-pic (see AtlasQuest_Instanzen.lua)

AQINSTATM = ""; -- variable to check whether AQINSTANZ has changed (see function AtlasQuestSetTextandButtons())

-- Sets the max number of instances and quests to check for. 
local AQMAXINSTANCES = "155"
local AQMAXQUESTS = "22"

-- Set title for AtlasQuest side panel
ATLASQUEST_VERSION = ""..BLUE.."AtlasQuest 4.9.3";

local AtlasQuest_Defaults = {
  ["Version"] =  "4.9.3",
  [UnitName("player")] = {
    ["ShownSide"] = "Left",
    ["AtlasAutoShow"] = 1,
    ["NOColourCheck"] = nil,
    ["CheckQuestlog"] = nil,
    ["AutoQuery"] = nil,
    ["NoQuerySpam"] = "yes",
    ["CompareTooltip"] = nil,
  },
};



-----------------------------------------------------------------------------
-- Functions
-----------------------------------------------------------------------------


--******************************************
-- Events: OnEvent
--******************************************

-----------------------------------------------------------------------------
-- Called when the player starts the game loads the variables
-----------------------------------------------------------------------------

function AtlasQuest_OnEvent(self,event,...)
   local arg1 = ...;
   if (event == "ADDON_LOADED" and arg1 == "AtlasQuest") then
      VariablesLoaded = 1; -- data is loaded completely
   else
      AtlasQuest_Initialize(); -- player enters world / initialize the data
   end
end

-----------------------------------------------------------------------------
-- Detects whether the variables have to be loaded
-- or reestablishes them
-----------------------------------------------------------------------------
function AtlasQuest_Initialize()
  if (Initialized or (not VariablesLoaded)) then
    return;
  end
  if (not AtlasQuest_Options) then
    AtlasQuest_Options = AtlasQuest_Defaults;
    DEFAULT_CHAT_FRAME:AddMessage("AtlasQuest Options database not found. Generating...");
  elseif (not AtlasQuest_Options[UnitName("player")]) then
    DEFAULT_CHAT_FRAME:AddMessage("Generate default database for this character");
    AtlasQuest_Options[UnitName("player")] = AtlasQuest_Defaults[UnitName("player")]
  end
  if (type(AtlasQuest_Options[UnitName("player")]) == "table") then
    AQVersionCheck();
    AtlasQuest_LoadData();
  end

  -- Register AQ Tooltip with EquipCompare if enabled.
  if((AQCompareTooltip ~= nil) and EquipCompare_RegisterTooltip) then
    EquipCompare_RegisterTooltip(AtlasQuestTooltip);
  end
  Initialized = 1;
end


-----------------------------------------------------------------------------
-- New Version check
-----------------------------------------------------------------------------
function AQVersionCheck()
 if (AtlasQuest_Options["Version"] == nil or AtlasQuest_Options["Version"] ~= AtlasQuest_Defaults["Version"] ) then
   AtlasQuest_Options["Version"] = AtlasQuest_Defaults["Version"];
   DEFAULT_CHAT_FRAME:AddMessage("First load after updating to "..ATLASQUEST_VERSION);
 end
end



-----------------------------------------------------------------------------
-- Loads the saved variables
-----------------------------------------------------------------------------
function AtlasQuest_LoadData()
  -- Which side
  if(AtlasQuest_Options[UnitName("player")]["ShownSide"] ~= nil) then
    AQ_ShownSide = AtlasQuest_Options[UnitName("player")]["ShownSide"];
  end
  -- atlas autoshow
  if(AtlasQuest_Options[UnitName("player")]["AtlasAutoShow"] ~= nil) then
    AQAtlasAuto = AtlasQuest_Options[UnitName("player")]["AtlasAutoShow"];
  end
  -- Colour Check? if nil = no cc; if true = cc
  AQNOColourCheck = AtlasQuest_Options[UnitName("player")]["ColourCheck"];
  -- Finished?   
  for i=1, AQMAXINSTANCES do
   for b=1, AQMAXQUESTS do
    AQ[ "AQFinishedQuest_Inst"..i.."Quest"..b ] = AtlasQuest_Options[UnitName("player")]["AQFinishedQuest_Inst"..i.."Quest"..b]
    AQ[ "AQFinishedQuest_Inst"..i.."Quest"..b.."_HORDE" ] = AtlasQuest_Options[UnitName("player")]["AQFinishedQuest_Inst"..i.."Quest"..b.."_HORDE"]
   end
  end
  --AQCheckQuestlog
  AQCheckQuestlog = AtlasQuest_Options[UnitName("player")]["CheckQuestlog"];
  -- AutoQuery option
  AQAutoQuery = AtlasQuest_Options[UnitName("player")]["AutoQuery"];
  -- Suppress Server Query Text option
  AQNoQuerySpam = AtlasQuest_Options[UnitName("player")]["NoQuerySpam"];
  -- Comparison Tooltips option
  AQCompareTooltip = AtlasQuest_Options[UnitName("player")]["CompareTooltip"];

end


-----------------------------------------------------------------------------
-- Saves the variables
-----------------------------------------------------------------------------
function AtlasQuest_SaveData()
  AtlasQuest_Options[UnitName("player")]["ShownSide"] = AQ_ShownSide;
  AtlasQuest_Options[UnitName("player")]["AtlasAutoShow"] = AQAtlasAuto;
  AtlasQuest_Options[UnitName("player")]["ColourCheck"] = AQNOColourCheck;
  AtlasQuest_Options[UnitName("player")]["CheckQuestlog"] = AQCheckQuestlog;
  AtlasQuest_Options[UnitName("player")]["AutoQuery"] = AQAutoQuery;
  AtlasQuest_Options[UnitName("player")]["NoQuerySpam"] = AQNoQuerySpam;
  AtlasQuest_Options[UnitName("player")]["CompareTooltip"] = AQCompareTooltip;
end




--******************************************
-- Events: OnLoad
--******************************************

-----------------------------------------------------------------------------
-- Call OnLoad set Variables and hides the panel
-----------------------------------------------------------------------------
function AQ_OnLoad()
    AtlasQuestFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
    AtlasQuestFrame:RegisterEvent("ADDON_LOADED");
    AQSetButtontext(); -- translation for all buttons
    if ( AtlasFrame ) then
    	AQATLASMAP = AtlasMap:GetTexture()
    else
	  AQATLASMAP = 36;
    end
    --this:RegisterForDrag("LeftButton");
    AQSlashCommandfunction();
	-- not showed yet
    HideUIPanel(AtlasQuestFrame);
    HideUIPanel(AtlasQuestInsideFrame);
    HideUIPanel(AtlasQuestOptionFrame);
    AQUpdateNOW = true;
end


-----------------------------------------------------------------------------
-- Slash command added
-----------------------------------------------------------------------------
function AQSlashCommandfunction()
    SlashCmdList["ATLASQ"]=atlasquest_command;
	SLASH_ATLASQ1="/aq";
	SLASH_ATLASQ2="/atlasquest";
end

-----------------------------------------------------------------------------
-- Set the button text
-----------------------------------------------------------------------------
function AQSetButtontext()
--      STORYbutton:SetText(AQStoryB);
      OPTIONbutton:SetText(AQOptionB);
      AQOptionCloseButton:SetText(AQ_OK);
	  AQOptionQuestQueryButton:SetText(AQQuestQueryButtonTEXT);
	  AQOptionQuestQuery:SetText(AQQuestQueryTEXT);
 	  AQOptionClaerQuestAndQueryButton:SetText(AQClearQuestAndQueryButtonTEXT);
 	  AQOptionClearQuestAndQuery:SetText(AQClearQuestAndQueryTEXT);
      AtlasQuestTitle:SetText(ATLASQUEST_VERSION);
      AQCaptionOptionTEXT:SetText(AQOptionsCaptionTEXT);
      AQAutoshowOptionTEXT:SetText(AQOptionsAutoshowTEXT);
      AQLEFTOptionTEXT:SetText(AQOptionsLEFTTEXT);
      AQRIGHTOptionTEXT:SetText(AQOptionsRIGHTTEXT);
      AQColourOptionTEXT:SetText(AQOptionsCCTEXT);
      AQFQ_TEXT:SetText(AQFinishedTEXT);
      AQCheckQuestlogTEXT:SetText(AQQLColourChange);
      AQAutoQueryTEXT:SetText(AQOptionsAutoQueryTEXT);
      AQNoQuerySpamTEXT:SetText(AQOptionsNoQuerySpamTEXT);
      AQCompareTooltipTEXT:SetText(AQOptionsCompareTooltipTEXT);
end




--******************************************
-- Events: OnUpdate
--******************************************

-----------------------------------------------------------------------------
-- Check which program is used (Atlas or AlphaMap)
-- hide panel if instance is 36 (nothing)
-----------------------------------------------------------------------------
function AQ_OnUpdate(arg1)
  local previousValue = AQINSTANZ;

        AQ_AtlasOrAMVISCheck(); -- Show whether atlas or am is shown atm

        ------- SEE AtlasQuest_Instanzen.lua
        if (AtlasORAlphaMap == "Atlas") then
           AtlasQuest_Instanzenchecken();
        elseif (AtlasORAlphaMap == "AlphaMap") then
           AtlasQuest_InstanzencheckAM();
        end

        -- Hides the panel if the map which is shown no quests have (map = 36)
        -- Disabled this by changing 36 here to 0 until it can be written out or re-written. 
       if ( AQINSTANZ == 0) then
             HideUIPanel(AtlasQuestFrame);
             HideUIPanel(AtlasQuestInsideFrame);
       elseif (( AQINSTANZ ~= previousValue ) or (AQUpdateNOW ~= nil)) then
           AtlasQuestSetTextandButtons();
           AQUpdateNOW = nil
           AQ_SetCaption();
       elseif ((AtlasORAlphaMap == "AlphaMap") and (AlphaMapAlphaMapFrame:IsVisible() == nil)) then
           HideUIPanel(AtlasQuestFrame);
           HideUIPanel(AtlasQuestInsideFrame);
       end
end


-----------------------------------------------------------------------------
--  Show whether atlas or am is shown atm
-----------------------------------------------------------------------------
function AQ_AtlasOrAMVISCheck()
        if ((AtlasFrame ~= nil) and (AtlasFrame:IsVisible())) then
           AtlasORAlphaMap = "Atlas";
        elseif (AlphaMapFrame:IsVisible()) then
           AtlasORAlphaMap = "AlphaMap";
        end
end


-----------------------------------------------------------------------------
--  AlphaMap parent change
-----------------------------------------------------------------------------
function AQ_AtlasOrAlphamap()
        if ((AtlasFrame ~= nil) and (AtlasFrame:IsVisible())) then
           AtlasORAlphaMap = "Atlas";
           --
           AtlasQuestFrame:SetParent(AtlasFrame);
           if (AQ_ShownSide == "Right" ) then
               AtlasQuestFrame:ClearAllPoints();
               AtlasQuestFrame:SetPoint("TOP","AtlasFrame", 555, -35);
           else
               AtlasQuestFrame:ClearAllPoints();
               AtlasQuestFrame:SetPoint("TOP","AtlasFrame", -545, -35);
           end
           AtlasQuestInsideFrame:SetParent(AtlasFrame);
           AtlasQuestInsideFrame:ClearAllPoints();
           AtlasQuestInsideFrame:SetPoint("TOPLEFT","AtlasFrame", 18, -84);
        elseif ((AlphaMapFrame ~= nil) and (AlphaMapFrame:IsVisible())) then
           AtlasORAlphaMap = "AlphaMap";
           --
           AtlasQuestFrame:SetParent(AlphaMapFrame);
           if (AQ_ShownSide == "Right" ) then
             AtlasQuestFrame:ClearAllPoints();
             AtlasQuestFrame:SetPoint("TOP","AlphaMapFrame", 400, -107);
           else
             AtlasQuestFrame:ClearAllPoints();
             AtlasQuestFrame:SetPoint("TOPLEFT","AlphaMapFrame", -195, -107);
           end
           AtlasQuestInsideFrame:SetParent(AlphaMapFrame);
           AtlasQuestInsideFrame:ClearAllPoints();
           AtlasQuestInsideFrame:SetPoint("TOPLEFT","AlphaMapFrame", 1, -108);
        end
end


-----------------------------------------------------------------------------
--  Set the ZoneName
-----------------------------------------------------------------------------
function AQ_SetCaption()
    Ueberschriftborder:SetText();
    if (getglobal("Inst"..AQINSTANZ.."Caption") ~= nil) then
      Ueberschriftborder:SetText(getglobal("Inst"..AQINSTANZ.."Caption"))
    end
end


-----------------------------------------------------------------------------
--  Set the Buttontext and the buttons if available
--  and check whether its a other inst or not -> works fine
--  added: Check for Questline arrows
--  Questline arrows are shown if InstXQuestYFQuest = "true"
--  QuestStart icon are shown if InstXQuestYPreQuest = "true"
-----------------------------------------------------------------------------
function AtlasQuestSetTextandButtons()
local AQQuestlevelf
local AQQuestfarbe
local AQQuestfarbe2
   if (AQINSTATM ~= AQINSTANZ) then
      HideUIPanel(AtlasQuestInsideFrame);
   end
   if (getglobal("Inst"..AQINSTANZ.."General") ~= nil) then
     AQGeneralButton:Enable();
   else
     AQGeneralButton:Disable();
   end

       if (Allianceorhorde == 1) then
           AQINSTATM = AQINSTANZ;
           if (getglobal("Inst"..AQINSTANZ.."QAA") ~= nil) then
               AtlasQuestAnzahl:SetText(getglobal("Inst"..AQINSTANZ.."QAA"));
           else
               AtlasQuestAnzahl:SetText("");
           end
           for b=1, AQMAXQUESTS do
             if (getglobal("Inst"..AQINSTANZ.."Quest"..b.."FQuest")) then
                getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\Glues\\Login\\UI-BackArrow")
                getglobal("AQQuestlineArrow_"..b):Show();
             elseif (getglobal("Inst"..AQINSTANZ.."Quest"..b.."PreQuest")) then
                getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\GossipFrame\\PetitionGossipIcon")
                getglobal("AQQuestlineArrow_"..b):Show();
             else
                getglobal("AQQuestlineArrow_"..b):Hide();
             end
             if (AQ[ "AQFinishedQuest_Inst"..AQINSTANZ.."Quest"..b ] == 1) then
               getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\GossipFrame\\BinderGossipIcon")
               getglobal("AQQuestlineArrow_"..b):Show();
             end
             AQQuestlevelf = tonumber(getglobal("Inst"..AQINSTANZ.."Quest"..b.."_Level"));
             if (getglobal("Inst"..AQINSTANZ.."Quest"..b) ~= nil) then
                if ( AQQuestlevelf ~= nil or AQQuestlevelf ~= 0 or AQQuestlevelf ~= "") then
                   if ( AQQuestlevelf == UnitLevel("player") or AQQuestlevelf == UnitLevel("player") + 2 or AQQuestlevelf  == UnitLevel("player") - 2 or AQQuestlevelf == UnitLevel("player") + 1 or AQQuestlevelf  == UnitLevel("player") - 1) then
                     AQQuestfarbe = Gelb;
                   elseif ( AQQuestlevelf > UnitLevel("player") + 2 and AQQuestlevelf <= UnitLevel("player") + 4) then
                     AQQuestfarbe = Orange;
                   elseif ( AQQuestlevelf >= UnitLevel("player") + 5 and AQQuestlevelf ~= 200) then
                     AQQuestfarbe = Rot;
                   elseif ( AQQuestlevelf < UnitLevel("player") - 7) then
                     AQQuestfarbe = Grau;
                   elseif ( AQQuestlevelf >= UnitLevel("player") - 7 and AQQuestlevelf < UnitLevel("player") - 2) then
                     AQQuestfarbe = Gruen;
                   end
                   if (AQNOColourCheck) then
                      AQQuestfarbe = Gelb;
                   end
                   if ( AQQuestlevelf == 200 or AQCompareQLtoAQ(b)) then
                      AQQuestfarbe = Blau;
                   end
                   if ( AQ[ "AQFinishedQuest_Inst"..AQINSTANZ.."Quest"..b ] == 1) then
                     AQQuestfarbe = WHITE;
                   end
                end
                getglobal("AQQuestbutton"..b):Enable();
                getglobal("AQBUTTONTEXT"..b):SetText(AQQuestfarbe..getglobal("Inst"..AQINSTANZ.."Quest"..b));
             else
                getglobal("AQQuestbutton"..b):Disable();
                getglobal("AQBUTTONTEXT"..b):SetText();
             end
           end
       end
       if (Allianceorhorde == 2) then
           AQINSTATM = AQINSTANZ;
           if (getglobal("Inst"..AQINSTANZ.."QAH") ~= nil) then
               AtlasQuestAnzahl:SetText(getglobal("Inst"..AQINSTANZ.."QAH"));
           else
               AtlasQuestAnzahl:SetText("");
           end
           for b=1, AQMAXQUESTS do
             if (getglobal("Inst"..AQINSTANZ.."Quest"..b.."FQuest_HORDE")) then
                getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\Glues\\Login\\UI-BackArrow")
                getglobal("AQQuestlineArrow_"..b):Show();
             elseif (getglobal("Inst"..AQINSTANZ.."Quest"..b.."PreQuest_HORDE")) then
                getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\GossipFrame\\PetitionGossipIcon")
                getglobal("AQQuestlineArrow_"..b):Show();
             else
                getglobal("AQQuestlineArrow_"..b):Hide();
             end
             if (AQ[ "AQFinishedQuest_Inst"..AQINSTANZ.."Quest"..b.."_HORDE" ] == 1) then
               getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\GossipFrame\\BinderGossipIcon")
               getglobal("AQQuestlineArrow_"..b):Show();
             end
             if (getglobal("Inst"..AQINSTANZ.."Quest"..b.."_HORDE") ~= nil) then
                AQQuestlevelf = tonumber(getglobal("Inst"..AQINSTANZ.."Quest"..b.."_HORDE_Level"));
                if ( AQQuestlevelf ~= nil or AQQuestlevelf ~= 0 or AQQuestlevelf ~= "") then
                   if ( AQQuestlevelf == UnitLevel("player") or AQQuestlevelf == UnitLevel("player") + 2 or AQQuestlevelf  == UnitLevel("player") - 2 or AQQuestlevelf == UnitLevel("player") + 1 or AQQuestlevelf  == UnitLevel("player") - 1) then
                     AQQuestfarbe = Gelb;
                   elseif ( AQQuestlevelf > UnitLevel("player") + 2 and AQQuestlevelf <= UnitLevel("player") + 4) then
                     AQQuestfarbe = Orange;
                   elseif ( AQQuestlevelf >= UnitLevel("player") + 5 and AQQuestlevelf ~= 200) then
                     AQQuestfarbe = Rot;
                   elseif ( AQQuestlevelf < UnitLevel("player") - 7) then
                     AQQuestfarbe = Grau;
                   elseif ( AQQuestlevelf >= UnitLevel("player") - 7 and AQQuestlevelf < UnitLevel("player") - 2) then
                     AQQuestfarbe = Gruen;
                   end
                   if (AQNOColourCheck) then
                      AQQuestfarbe = Gelb;
                   end
                   if ( AQQuestlevelf == 200 or AQCompareQLtoAQ(b)) then
                      AQQuestfarbe = Blau;
                   end
                   if ( AQ[ "AQFinishedQuest_Inst"..AQINSTANZ.."Quest"..b.."_HORDE" ] == 1) then
                     AQQuestfarbe = WHITE;
                   end
                end
                getglobal("AQQuestbutton"..b):Enable();
                getglobal("AQBUTTONTEXT"..b):SetText(AQQuestfarbe..getglobal("Inst"..AQINSTANZ.."Quest"..b.."_HORDE"));
             else
                getglobal("AQQuestbutton"..b):Disable();
                getglobal("AQBUTTONTEXT"..b):SetText();
             end
           end
       end
end


-----------------------------------------------------------------------------
-- Colours quest blue if they are in your questlog
-----------------------------------------------------------------------------
function AQCompareQLtoAQ(Quest)
local TotalQuestEntries
local CurrentQuestnum
local OnlyQuestNameRemovedNumber
local Questisthere
local x
local y
local z
local count

  if (AQCheckQuestlog == nil) then -- Option to turn the check on or off
    if (Quest == nil) then  -- added for use in button text to change the caption dunno whether i add it or not
      Quest = AQSHOWNQUEST;
    end
    if (Quest <= 9) then
      if (Allianceorhorde == 1) then
        OnlyQuestNameRemovedNumber = strsub(getglobal("Inst"..AQINSTANZ.."Quest"..Quest), 4)
      elseif (Allianceorhorde == 2) then
        OnlyQuestNameRemovedNumber = strsub(getglobal("Inst"..AQINSTANZ.."Quest"..Quest.."_HORDE"), 4)
      end
    elseif (Quest > 9) then
      if (Allianceorhorde == 1) then
        OnlyQuestNameRemovedNumber = strsub(getglobal("Inst"..AQINSTANZ.."Quest"..Quest), 5)
      elseif (Allianceorhorde == 2) then
        OnlyQuestNameRemovedNumber = strsub(getglobal("Inst"..AQINSTANZ.."Quest"..Quest.."_HORDE"), 5)
      end
    end
    --this checks should be done everytime when the questupdate event gets executed
    TotalQuestEntries = GetNumQuestLogEntries();
    for CurrentQuestnum=1, TotalQuestEntries do
      x, y, z = GetQuestLogTitle(CurrentQuestnum)
      TotalQuestsTable = {
        [CurrentQuestnum] = x,
      };
      if ((CT_Core) and (CT_Core:getOption("questLevels") == 1)) then
        count = 4;
	 if (y > 10) then
          count = count + 2;
        else
          count = count + 1;
        end
        if ((z == ELITE ) or ( z == RAID ) or ( z == "Dungeon" ) or ( z == "Donjon" )) then
          count = count + 1;
        end
        TotalQuestsTable = {
          [CurrentQuestnum] = strsub(x, count)
         };
      end

      -- Code from Denival to remove parentheses and anything in it so Color Quests blue option works.
      ps, pe = strfind(OnlyQuestNameRemovedNumber," %(.*%)")
      if (ps) then
       OnlyQuestNameRemovedNumber = strsub(OnlyQuestNameRemovedNumber,1,ps-1)
      end

      --expect this
      if (TotalQuestsTable[CurrentQuestnum] == OnlyQuestNameRemovedNumber) then
        Questisthere = 1;
      end
    end
    if (Questisthere == 1) then
      return true;
    else
      return false;
    end
    --
  else
    return false;
  end
end




--******************************************
-- Events: Atlas_OnShow (Hook Atlas function)
--******************************************

-----------------------------------------------------------------------------
-- Shows the AQ panel with atlas
-- function hooked now! thx dan for his help
-----------------------------------------------------------------------------
original_Atlas_OnShow = Atlas_OnShow; -- new line #1
function Atlas_OnShow()
   if ( AQAtlasAuto == 1) then
     ShowUIPanel(AtlasQuestFrame);
    else
     HideUIPanel(AtlasQuestFrame);
    end
    HideUIPanel(AtlasQuestInsideFrame);
   -- AQ_AtlasOrAlphamap();
   if (AQ_ShownSide == "Right") then
       AtlasQuestFrame:ClearAllPoints();
       AtlasQuestFrame:SetPoint("TOP","AtlasFrame", 555, -80);
  end
  original_Atlas_OnShow(); -- new line #2
end




--******************************************
-- Events: OnEnter/OnLeave SHOW ITEM
--******************************************

-----------------------------------------------------------------------------
-- Hide Tooltip
-----------------------------------------------------------------------------

function AtlasQuestItem_OnLeave()
        if(GameTooltip:IsVisible()) then
            GameTooltip:Hide();
            if ( ShoppingTooltip2:IsVisible() or ShoppingTooltip1.IsVisible) then
	       ShoppingTooltip2:Hide();
	       ShoppingTooltip1:Hide();
	    end
        end
        if(AtlasQuestTooltip:IsVisible()) then
            AtlasQuestTooltip:Hide();
            if ( ShoppingTooltip2:IsVisible() or ShoppingTooltip1.IsVisible) then
	       ShoppingTooltip2:Hide();
	       ShoppingTooltip1:Hide();
	    end
        end
end


-----------------------------------------------------------------------------
-- Show Tooltip and automatically query server if option is enabled
-----------------------------------------------------------------------------

function AtlasQuestItem_OnEnter()
local SHOWNID
local name
local nameDATA
local colour
local itemName, itemQuality

     if ( Allianceorhorde == 1) then
       SHOWNID = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN);
       colour = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ITC"..AQTHISISSHOWN);
       nameDATA = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."name"..AQTHISISSHOWN);
     else
       SHOWNID = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE");
       colour = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ITC"..AQTHISISSHOWN.."_HORDE");
       nameDATA = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."name"..AQTHISISSHOWN.."_HORDE");
     end


     if (SHOWNID ~= nil) then
        if(GetItemInfo(SHOWNID) ~= nil) then
              AtlasQuestTooltip:SetOwner(AtlasQuestItemframe1, "ANCHOR_RIGHT", -(AtlasQuestItemframe1:GetWidth() / 2), 24);
              AtlasQuestTooltip:SetHyperlink("item:"..SHOWNID..":0:0:0");
              if(AQCompareTooltip ~= nil) then
                if((EquipCompare_Enabled == nil) or (not EquipCompare_Enabled)) then  -- Only show this if EquipCompare isn't present or not enabled.
                  AtlasQuestItem_ShowCompareItem();  -- Show Comparison Tooltip
                end
              end
              AtlasQuestTooltip:Show();
        else
              AtlasQuestTooltip:SetOwner(AtlasQuestItemframe1, "ANCHOR_RIGHT", -(AtlasQuestItemframe1:GetWidth() / 2), 24);
              AtlasQuestTooltip:ClearLines();
              AtlasQuestTooltip:AddLine(RED..AQERRORNOTSHOWN);
              AtlasQuestTooltip:AddLine(AQERRORASKSERVER);
              AtlasQuestTooltip:Show();
        end
     end


end


-----------------------------------------------------------------------------
-- Ask Server right-click
-- + shift click to send link
-- + ctrl click for dressroom
-- BIG THANKS TO Daviesh and ATLASLOOT for the CODE
-----------------------------------------------------------------------------

function AtlasQuestItem_OnClick(arg1)
local SHOWNID
local name
local nameDATA
local colour
local itemName, itemQuality

   if ( Allianceorhorde == 1) then
     SHOWNID = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN);
     colour = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ITC"..AQTHISISSHOWN);
     nameDATA = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."name"..AQTHISISSHOWN);
   else
     SHOWNID = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE");
     colour = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ITC"..AQTHISISSHOWN.."_HORDE");
     nameDATA = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."name"..AQTHISISSHOWN.."_HORDE");
   end

        if(arg1=="RightButton") then
                   AtlasQuestTooltip:SetOwner(AtlasFrame, "ANCHOR_RIGHT", -(AtlasFrame:GetWidth() / 2), 24);
                   AtlasQuestTooltip:SetHyperlink("item:"..SHOWNID..":0:0:0");
                   AtlasQuestTooltip:Show();
                   if(AQNoQuerySpam == nil) then
                     DEFAULT_CHAT_FRAME:AddMessage(AQSERVERASK.."["..colour..nameDATA..WHITE.."]"..AQSERVERASKInformation);
                   end
        elseif(IsShiftKeyDown()) then
            if (GetItemInfo(SHOWNID)) then
              itemName, itemLink, itemQuality = GetItemInfo(SHOWNID);
              local r, g, b, hex = GetItemQualityColor(itemQuality);
              itemtext = hex..itemName;
		if itemLink then
		  ChatEdit_InsertLink(itemLink);
		else
		  ChatEdit_InsertLink(hex.."|Hitem:"..SHOWNID..":0:0:0:0:0:0:0|h["..itemName.."]|h|r");
		end
		    else
		      DEFAULT_CHAT_FRAME:AddMessage("Item unsafe! Right click to get the item ID")
		      ChatFrame1EditBox:Insert("["..nameDATA.."]");
		    end
		--If control-clicked, use the dressing room
        elseif(IsControlKeyDown() and GetItemInfo(SHOWNID)) then
          DressUpItemLink(SHOWNID);
		end
end


-----------------------------------------------------------------------------
-- Automatically show Horde or Alliance quests 
-- based on player's faction when AtlasQuest is opened.
-----------------------------------------------------------------------------

function AQ_OnShow()
   if ( UnitFactionGroup("player") == "Horde") then
      Allianceorhorde = 2;
      AQHCB:SetChecked(true);
      AQACB:SetChecked(false);
   else
      Allianceorhorde = 1;
      AQHCB:SetChecked(false);
      AQACB:SetChecked(true);
   end
  AtlasQuestSetTextandButtons()
end


-----------------------------------------------------------------------------
-- Comparison Tooltips
-- Huge thanks to Daviesh and AtlasLoot for this code!
-----------------------------------------------------------------------------

function AtlasQuestItem_ShowCompareItem()
   local item,link= AtlasQuestTooltip:GetItem();
    if ( not link ) then
      return;
   end
   
   local item1 = nil;
   local item2 = nil;
   local side = "left";
   if ( ShoppingTooltip1:SetHyperlinkCompareItem(link, 1) ) then
      item1 = true;
   end
   if ( ShoppingTooltip2:SetHyperlinkCompareItem(link, 2) ) then
      item2 = true;
   end
   local rightDist = GetScreenWidth() - AtlasQuestTooltip:GetRight();
   if (rightDist < AtlasQuestTooltip:GetLeft()) then
      side = "left";
   else
      side = "right";
   end
   if ( AtlasQuestTooltip:GetAnchorType() ) then
      local totalWidth = 0;
      if ( item1  ) then
         totalWidth = totalWidth + ShoppingTooltip1:GetWidth();
      end
      if ( item2  ) then
         totalWidth = totalWidth + ShoppingTooltip2:GetWidth();
      end

      if ( (side == "left") and (totalWidth > AtlasQuestTooltip:GetLeft()) ) then
         AtlasQuestTooltip:SetAnchorType(AtlasQuestTooltip:GetAnchorType(), (totalWidth - AtlasQuestTooltip:GetLeft()), 0);
      elseif ( (side == "right") and (AtlasQuestTooltip:GetRight() + totalWidth) >  GetScreenWidth() ) then
         AtlasQuestTooltip:SetAnchorType(AtlasQuestTooltip:GetAnchorType(), -((AtlasQuestTooltip:GetRight() + totalWidth) - GetScreenWidth()), 0);
      end
   end

   -- anchor the compare tooltips
   if ( item1 ) then
      ShoppingTooltip1:SetOwner(AtlasQuestTooltip, "ANCHOR_NONE");
      ShoppingTooltip1:ClearAllPoints();
      if ( side and side == "left" ) then
         ShoppingTooltip1:SetPoint("TOPRIGHT", "AtlasQuestTooltip", "TOPLEFT", 0, -10);
      else
         ShoppingTooltip1:SetPoint("TOPLEFT", "AtlasQuestTooltip", "TOPRIGHT", 0, -10);
      end
      ShoppingTooltip1:SetHyperlinkCompareItem(link, 1);
      ShoppingTooltip1:Show();

      if ( item2 ) then
         ShoppingTooltip2:SetOwner(ShoppingTooltip1, "ANCHOR_NONE");
         ShoppingTooltip2:ClearAllPoints();
         if ( side and side == "left" ) then
            ShoppingTooltip2:SetPoint("TOPRIGHT", "ShoppingTooltip1", "TOPLEFT", 0, 0);
         else
            ShoppingTooltip2:SetPoint("TOPLEFT", "ShoppingTooltip1", "TOPRIGHT", 0, 0);
         end
         ShoppingTooltip2:SetHyperlinkCompareItem(link, 2);
         ShoppingTooltip2:Show();
      end
   end   
end



-----------------------------------------------------------------------------
-- Quest Query stuff (Code written by Natch)
-----------------------------------------------------------------------------
 
function AQClearQuestAndQuery()
	-- remove all completed quests
	local atlasquestlist = AtlasQuest_Options[UnitName("player")]
	for key, value in pairs(atlasquestlist) do
		if string.find(key, "AQFinishedQuest_Inst") == 1 then
			-- entry found, clear it
			atlasquestlist[key] = nil
		end
	end

	AQQuestQuery();
end

function AQQuestQuery()
	ChatFrame1:AddMessage(AQQuestQueryStart);

	local qct, gurka, qcs, ral, rat = {}, false, ":", false, false;
    --	self.stamp = time();
	local ishorde = (UnitFactionGroup("player") == "Horde")
       
  	AQPleaseCheckQuests = GetQuestsCompleted(qct);
  
	for qx in pairs(qct) do
		qcs = qcs .. qx .. ":";
	end

	-- Hide Atlas/AlphaMap while updating
	if((AtlasFrame ~= nil) and (AtlasFrame:IsVisible())) then
		AtlasFrame:Hide();
		rat = true;
	end
	if((AlphaMapFrame ~= nil) and (AlphaMapFrame:IsVisible())) then
		AlphaMapFrame:Hide();
		ral = true;
	end

	-- Update AQ database
	for i = 1, AQMAXINSTANCES do
		for q = 1, AQMAXQUESTS do
  			local a = _G["Inst"..i.."Quest"..q.."_QuestID"];
  			local h = _G["Inst"..i.."Quest"..q.."_HORDE_QuestID"];
  			
 			if(not ishorde and a and string.find(qcs, ":"..a..":")) then
  				AQ["AQFinishedQuest_Inst"..i.."Quest"..q]                              = 1;
  				AtlasQuest_Options[UnitName("player")]["AQFinishedQuest_Inst"..i.."Quest"..q] = 1;
  				gurka = true;
  			end
  
 			if(ishorde and h and string.find(qcs, ":"..h..":")) then
  				AQ["AQFinishedQuest_Inst"..i.."Quest"..q.."_HORDE"]                              = 1;
  				AtlasQuest_Options[UnitName("player")]["AQFinishedQuest_Inst"..i.."Quest"..q.."_HORDE"] = 1;
  				gurka = true;
			end
		end
	end

	-- Show map if hidden
	if(rat == true) then
		AtlasFrame:Show();
	end
	if(ral == true) then
		AlphaMapFrame:Show();
	end

if(gurka == true and AQQueryDONE == nil) then
		ChatFrame1:AddMessage(AQQuestQueryDone);
		local AQQueryDONE = "done"
	end
end


