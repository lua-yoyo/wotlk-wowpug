local KBT_DataObj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("WoWPuG", {
	text = "WoW PuG",
	type = "data source",
	icon = "Interface\\Icons\\Spell_Misc_HellifrePVPThrallmarFavor",
	OnClick = function(clickedframe, button)
		if button == "LeftButton" then
			WoWPuG_LoadTheWindowIfItHasntAlready()
			if WPuG_MainFrame:IsShown() and WPuG_SetupGrpTab2:IsShown() then
				WPuG_MainFrame:Hide();
			else
				WPuG_MainFrame:Show();
				PanelTemplates_SetTab(WPuG_MainFrame, 1);
				WPuG_UpdateFrames(1);
			end
		elseif button == "RightButton" then
			WoWPuG_LoadTheWindowIfItHasntAlready()
			if WPuG_MainFrame:IsShown() and WPuG_LFGListTab:IsShown() then
				WPuG_MainFrame:Hide();
			else
				WPuG_MainFrame:Show();
				PanelTemplates_SetTab(WPuG_MainFrame, 2);
				WPuG_UpdateFrames(2);
			end
		end
	end,
})

if KBT_DataObj ~= nil then

	function KBT_DataObj:OnTooltipShow()
		self:AddLine(	"|cffffff00" .. "WoW PuG Builder\n\n" .. 
						"|cff00ff00" .. "Left Click: " .. "|cffffffff" .. "Toggle Main Window\n" .. 
						"|cff00ff00" .. "Right Click: " .. "|cffffffff" .. "Toggle LFG Window")
	end

	function KBT_DataObj:OnEnter()
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
		GameTooltip:ClearLines()
		KBT_DataObj.OnTooltipShow(GameTooltip)
		GameTooltip:Show()
	end

	function KBT_DataObj:OnLeave()
		GameTooltip:Hide()
	end
end


WoWPuG_DB_Temp = {}
WPuG_AdvertiseChannels = {4, 5, 6};

WPuG_DelayOnStartup = CreateFrame("Frame")
WPuG_DelayOnStartup:SetScript("OnUpdate",	function()
												if WPuG_HasLoadedCheck == true then
													WPuG_DelayOnStartup:SetScript("OnUpdate", function() end);
													WPuG_DelayOnStartup:Hide();
												end
												if time() > WPuG_DelayTime and WPuG_HasLoadedCheck == false then
													WPuG_HasLoadedCheck = true;
													WoWPuG_OnLoad();
												end;
											end)


function WPuG_GetMySpecInfo()
	local MainTree = ""
	local PointString = ""
	local LastPoints = 0
	
	for i=1,3 do
		local TreeName, _, pointsSpent = GetTalentTabInfo(i,false,false,GetActiveTalentGroup())
		
		PointString = PointString .. pointsSpent
		if i < 3 then PointString = PointString .. "/" end
		
		if MainTree == "" or LastPoints < pointsSpent then
			MainTree = TreeName
		end
		
		LastPoints = pointsSpent
	end
	
	return PointString,MainTree
end

WPuG_DelayTime = time()+30;
WPuG_HasLoadedCheck = false;

RaidFrameRaidInfoButton:SetScript("OnShow",	function()
												if WPuG_HasLoadedCheck == false then
													WPuG_HasLoadedCheck = true;
													WoWPuG_OnLoad();
												end;
											end)
											
function WoWPuG_LoadTheWindowIfItHasntAlready()
	if WPuG_HasLoadedCheck == false then
		WPuG_HasLoadedCheck = true;
		WoWPuG_OnLoad();
	end;
end
	
function WoWPuG_OnLoad()


ChatFrame1:AddMessage("\124cff5f2f9fWoW PuG Builder\124r - \124cff1fff3fLoaded\124r")


--[[
/run
 message = "Test Message";
 len = strlen(message);
 for i=1, len-1 do
 message = strsub(message, 0, -len+i-1) .. "\124cff".. string.format("%x%x%x",random(,256),random(17,256),random(17,256)) .. "" .. strsub(message, -len+i)
 end;
 print(message)


ChatFrame1:AddMessage("\124cff" .. string.format("%x6.0",random(12345)) .."WoW PuG Builder\124r - \124cff1fff3fLoaded\124r")

string.format("%x",rand(16777216))
]]

WpuG_LastAdvertiseTime = time() - 9999
 
	--self:RegisterEvent("VARIABLES_LOADED")
	
	--self:RegisterEvent("CHAT_MSG_SYSTEM")
	
	WPug_SetupVariables()
	WoWPuG_SetupQuestGrabber()
end

WPuGDefaultNeeded = {}
WPuGDefaultNeeded[1] = {3,5,7,10}	-- default 25 man
WPuGDefaultNeeded[2] = {2,3,2,3}	-- default 10 man


function WoWPuG_SlashSetup()
 SLASH_WPG1 = "/wpg";
 SLASH_WPG2 = "/wowpug";
 SLASH_WPG3 = "/wowpugbuilder";
 SlashCmdList["WPG"] =  WPuG_Command;
end


function WPuG_Command(cmd)
	if cmd ~= nil then
		local cmd1, cmd2, cmd3, _ = strsplit(" ", cmd, 4)
		
		-- Make sure we have 3 arguments 
		if cmd3 ~= nil and cmd2 ~= nil and WPuG_Phrases[cmd2] ~= nil then
			cmd1 = string.lower(cmd1)
			cmd2 = string.lower(cmd2)
			
			
			
			if cmd1 == "phrase" then
				print("Setting phrase ''|cff00009f" .. cmd2 .. "|r'': |cffff0000" .. WPuG_Phrases[cmd2] .. "|r >> |cff00ff00" .. cmd3 .. "|r")
				print("You may have to reload UI (or log out) to see changes.")
				WPuG_Phrases[cmd2] = cmd3;
			end
		elseif cmd1 == "achi" and string.find(cmd, "achievement%:%d*%:") then
			local Start, End = string.find(cmd, "achievement%:%d*%:")
			local ID = string.sub(cmd, Start+12, End-1)
			
			Start,End = string.find(cmd, "%|cffffff00%|Hachievement%:.*%]%|h%|r")
			local Name = string.sub(cmd, Start, End)
			
			print(Name .. ": ID#" .. ID)
		elseif cmd1 == "show" then
			WoWPuG_LoadTheWindowIfItHasntAlready()
			WPuG_MainFrame:Show();
		else
			print("WoWPuG Commands:");
			
			print("|cffffff001.|r |cff7fff7fshow|r");
			print(" >> Show the main window");
			
			print("|cffffff002.|r |cff7fff7fphrase|r |cffff0000<Original Phrase>|r |cff00ff00<New Phrase>|r");
			print(" >> e.g ''/wpg phrase Rogue Schurke'' (German phrase)");
			print(" >> Possible phrases: lfm, need, any, tank, healer, melee, ranged, paladin, rogue, warrior, hunter, druid, warlock, priest, deathknight, mage, shaman");
			
			print("|cffffff003.|r |cff7fff7fachi|r |cffff0000<Achievement Link>|r");
			print(" >> e.g ''/wpg achi \124cffffff00\124Hachievement:2076:"..UnitGUID("player")..":0:0:0:0:0:0:0:0\124h[Armored Brown Bear]\124h\124r''");
		end
	end
end

function WPug_SetupVariables()
	--local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...;

	---------LFM PHRASES
	if WPuG_Phrases == nil then
		WPuG_Phrases = 	{
						["lfm"] = "LFM",
						["need"] = "Need",
						
						["tank"] = "Tank",
						["healer"] = "Healer",
						["ranged"] = "Ranged",
						["melee"] = "Melee",
						
						["any"] = "Any",
						["paladin"] = "Paladin",
						["rogue"] = "Rogue",
						["warrior"] = "Warrior",
						["hunter"] = "Hunter",
						["druid"] = "Druid",
						["warlock"] = "Warlock",
						["priest"] = "Priest",
						["deathknight"] = "Death Knight",
						["mage"] = "Mage",
						["shaman"] = "Shaman"
						}
	end

-- Temp DB holding info that resets on reload UI
	WoWPuG_DB_Temp["ClassesCheckbox"] = {}
	for i=1,4 do
		WoWPuG_DB_Temp["ClassesCheckbox"][i] = {}
		for j=1,6 do
			WoWPuG_DB_Temp["ClassesCheckbox"][i][j] = 0;
		end
	end
	WoWPuG_DB_Temp["ClassesHave"] = {};
	WoWPuG_DB_Temp["Offset"] = {};
	for i=1,4 do
		WoWPuG_DB_Temp["ClassesHave"][i] = 0;
		WoWPuG_DB_Temp["Offset"][i] = 0;
	end
	WoWPuG_DB_Temp["SpecSelected"] = 1;
	WoWPuG_DB_Temp["ListOfNames"] = {};
	
	Wpug_Debugging_PopulateUpdateList();

-- DB saved between sessions
	if WoWPuG_DB == nil then 
		WoWPuG_DB={} 
		WPug_SetupDefaultSaveFile()
	elseif WoWPuG_DB["RaidSetupSelection"] ~= nil then
		WPug_ConvertOldSaveFile()
	end
	
	WPuG_MainFrameSetup()
	
	
	--[[
	" has joined the raid group."
	" has left the raid group."
	]]
	
	--[[
-- This is used to see the various arguments passed to the event handler
	ChatFrame1:AddMessage(event)
	ChatFrame1:AddMessage(arg1)
	ChatFrame1:AddMessage(arg2)
	ChatFrame1:AddMessage(arg3)
	ChatFrame1:AddMessage(arg4)
	ChatFrame1:AddMessage(arg5)
	ChatFrame1:AddMessage(arg6)
	ChatFrame1:AddMessage(arg7)
	ChatFrame1:AddMessage(arg8)
	ChatFrame1:AddMessage(arg9)
]]

end



WoWPuG_OnAddonLoadCatcher = CreateFrame("Frame");
WoWPuG_OnAddonLoadCatcher:SetScript("OnEvent", function(self, event, ...) 
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...;
	
	if arg1 == "Blizzard_AchievementUI" then
		WoWPuG_SetupAchievementGrabber();
	end
end)
WoWPuG_OnAddonLoadCatcher:RegisterEvent("ADDON_LOADED");


function WoWPuG_SetupQuestGrabber()
	local function QuestLinkGrabber(self, button, down, ignoreModifiers)
		local questLink = GetQuestLink(self:GetID())
		WoWPuG_AddLinkToMessage(questLink)
	end

	hooksecurefunc("QuestLogTitleButton_OnClick", QuestLinkGrabber)
end

function WoWPuG_SetupAchievementGrabber()
	local function AchievementLinkGrabber(self, button, down, ignoreModifiers)
		local achLink = GetAchievementLink(self.id)
		WoWPuG_AddLinkToMessage(achLink)
	end
	
	hooksecurefunc("AchievementButton_OnClick", AchievementLinkGrabber)
end

function WoWPuG_AddLinkToMessage(Link)
	if WPuG_SetupGrp_MessageBox then	-- if the edit box has loaded
		if IsModifiedClick() then	-- if we are holding a modifier	(alt/ctrl/shift)
			if WPuG_SetupGrp_MessageBox:HasFocus() then	-- if the editbox has focus
				WPuG_SetupGrp_MessageBox:Insert(Link)	-- then add the link to the message
			end
		end
	end
end

function WPug_SetupDefaultSaveFile()
	WoWPuG_DB["RaidSelected"] = 1;

    for i = 1,#WPuG_AdvertiseChannels do
        WoWPuG_DB["WPuG_Channel_CheckButton:" .. WPuG_AdvertiseChannels[i]] = 1;
    end
--	WoWPuG_DB["WPuG_Channel_CheckButton:" .. 1] = 1;
--	WoWPuG_DB["WPuG_Channel_CheckButton:" .. 2] = 0;
--	WoWPuG_DB["WPuG_Channel_CheckButton:" .. 3] = 0;
--	WoWPuG_DB["WPuG_Channel_CheckButton:" .. 4] = 0;
--    WoWPuG_DB["WPuG_Channel_CheckButton:" .. 5] = 0;
--    WoWPuG_DB["WPuG_Channel_CheckButton:" .. 6] = 1;
	
	WoWPuG_DB["Raid"] = {
		{
			["Name"] = "ICC 10",
			["Tanks"] = 2,
			["Healers"] = 3,
			["Melee"] = 2,
			["Ranged"] = 3,
			["Message"] = "Enter Message Here...",
		},
		{
			["Name"] = "ICC 25",
			["Tanks"] = 3,
			["Healers"] = 5,
			["Melee"] = 8,
			["Ranged"] = 9,
			["Message"] = "Enter Message Here...",
		},
		{
			["Name"] = "RS 10",
			["Tanks"] = 2,
			["Healers"] = 3,
			["Melee"] = 2,
			["Ranged"] = 3,
			["Message"] = "Enter Message Here...",
		},
		{
			["Name"] = "RS 25",
			["Tanks"] = 3,
			["Healers"] = 5,
			["Melee"] = 8,
			["Ranged"] = 9,
			["Message"] = "Enter Message Here...",
		},
		{
			["Name"] = "VoA 10",
			["Tanks"] = 2,
			["Healers"] = 3,
			["Melee"] = 2,
			["Ranged"] = 3,
			["Message"] = "Enter Message Here...",
		},
		{
			["Name"] = "VoA 25",
			["Tanks"] = 2,
			["Healers"] = 5,
			["Melee"] = 9,
			["Ranged"] = 9,
			["Message"] = "Enter Message Here...",
		},
		{
			["Name"] = "ToC 10",
			["Tanks"] = 2,
			["Healers"] = 3,
			["Melee"] = 2,
			["Ranged"] = 3,
			["Message"] = "Enter Message Here...",
		},
		{
			["Name"] = "ToC 25",
			["Tanks"] = 3,
			["Healers"] = 5,
			["Melee"] = 8,
			["Ranged"] = 9,
			["Message"] = "Enter Message Here...",
		},
		{
			["Name"] = "OS 10 + 3D",
			["Tanks"] = 1,
			["Healers"] = 1,
			["Melee"] = 4,
			["Ranged"] = 4,
			["Message"] = "Enter Message Here...",
		},
		{
			["Name"] = "OS 25 + 3D",
			["Tanks"] = 2,
			["Healers"] = 3,
			["Melee"] = 10,
			["Ranged"] = 10,
			["Message"] = "Enter Message Here...",
		}
	}
end

function WPug_ConvertOldSaveFile()
local NeedTypes = 
	{
	"Tanks",
	"Healers",
	"Melee",
	"Ranged"
	}
	
	for i=1,10 do
		if WoWPuG_DB["RaidSetupSelection"]["Raid"..i] ~= nil then
			if WoWPuG_DB["Raid"] == nil then WoWPuG_DB["Raid"] = {} end
			if WoWPuG_DB["Raid"][i] == nil then WoWPuG_DB["Raid"][i] = {} end
			
			WoWPuG_DB["Raid"][i]["Name"] = WoWPuG_DB["WPuG_SetupGrp_DungeonList_CheckButton:" .. i .. "Edit"];
			WoWPuG_DB["Raid"][i]["Message"] = WoWPuG_DB["RaidSetupSelection"]["Raid"..i]["Message"];
			
			for j=1,4 do
				WoWPuG_DB["Raid"][i][NeedTypes[j]] = WoWPuG_DB["RaidSetupSelection"]["Raid"..i][j]
			end
		end
	end
	
	local temp = WoWPuG_DB["Raid"];
	
	wipe(WoWPuG_DB);
	
	WoWPuG_DB = {};
	
	WoWPuG_DB["Raid"] = temp;
	
	WoWPuG_DB["RaidSelected"] = 1;

    WoWPuG_DB["WPuG_Channel_CheckButton:" .. 1] = 0;
    WoWPuG_DB["WPuG_Channel_CheckButton:" .. 2] = 0;
    WoWPuG_DB["WPuG_Channel_CheckButton:" .. 3] = 0;
    WoWPuG_DB["WPuG_Channel_CheckButton:" .. 4] = 0;
    WoWPuG_DB["WPuG_Channel_CheckButton:" .. 5] = 0;
    WoWPuG_DB["WPuG_Channel_CheckButton:" .. 6] = 1;
end

function WPuG_MessageOutput(WhichWindow)
	SendChatMessage(WPuG_SendChatMessage ,"CHANNEL" ,nil ,WhichWindow); -- default message output
end
