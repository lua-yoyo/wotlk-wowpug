WoWPuG_DB_Temp["WhisperCatcher"] = {};
WoWPuG_DB_Temp["WhisperCatcherNames"] = {};

function WoWPuG_WhisperCatcher_FrameSetup()
	local backdrop = {
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",  -- path to the background texture
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",  -- path to the border texture
		tile = false,    -- true to repeat the background texture to fill the frame, false to scale it
		tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
		edgeSize = 10,  -- thickness of edge segments and square size of edge corners (in pixels)
		insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
			left = 2,
			right = 2,
			top = 2,
			bottom = 2
		}
	}
	
-- Setup the frame boxes (begin) ------------------------------------------------------------------------------------------------------
	for i=1,15 do
		WoWPuG_WhisperCatcher_Frame=CreateFrame("FRAME","WoWPuG_WhisperCatcher_Frame:"..i,WPuG_SetupGrpTab2);
		WoWPuG_WhisperCatcher_Frame:SetWidth(170); 
		WoWPuG_WhisperCatcher_Frame:SetHeight(10);
		
		if i == 1 then
			WoWPuG_WhisperCatcher_Frame:SetPoint("TOPLEFT",WPuG_SetupGrpTab2,"TOPRight",0, 0);
		else
			WoWPuG_WhisperCatcher_Frame:SetPoint("TOPLEFT",_G["WoWPuG_WhisperCatcher_Frame:"..i-1],"BottomLeft",0, 0);
		end
		WoWPuG_WhisperCatcher_Frame:SetBackdrop(backdrop)
		WoWPuG_WhisperCatcher_Frame:SetScript("OnMouseDown", function(self, button) WoWPuG_WhisperCatcher_ButtonPressed(self, button); end)
		WoWPuG_WhisperCatcher_Frame:SetScript("OnEnter", function() WoWPuG_WhisperCatcher_Help:Show(); end)
		WoWPuG_WhisperCatcher_Frame:SetScript("OnLeave", function() WoWPuG_WhisperCatcher_Help:Hide(); end)
		
		WoWPuG_WhisperCatcher_Name=WoWPuG_WhisperCatcher_Frame:CreateFontString("WoWPuG_WhisperCatcher_Name:"..i,"ARTWORK","GameFontNormal");
		WoWPuG_WhisperCatcher_Name:SetPoint("TopLeft",WoWPuG_WhisperCatcher_Frame,"TopLeft",5,-5);
		WoWPuG_WhisperCatcher_Name:SetFont("Fonts\\FRIZQT__.TTF", 11)
		WoWPuG_WhisperCatcher_Name:SetJustifyH("Left")
		WoWPuG_WhisperCatcher_Name:SetText("LoremIpsum")
		WoWPuG_WhisperCatcher_Name:SetWidth(80); 
		WoWPuG_WhisperCatcher_Name:SetHeight(11);
		Color = RAID_CLASS_COLORS["WARLOCK"]
		WoWPuG_WhisperCatcher_Name:SetTextColor(Color.r,Color.g,Color.b,1)
		
		WoWPuG_WhisperCatcher_Class=WoWPuG_WhisperCatcher_Frame:CreateFontString("WoWPuG_WhisperCatcher_Class:"..i,"ARTWORK","GameFontNormal");
		WoWPuG_WhisperCatcher_Class:SetPoint("TopRight",WoWPuG_WhisperCatcher_Frame,"TopRight",-5,-5);
		WoWPuG_WhisperCatcher_Class:SetFont("Fonts\\FRIZQT__.TTF", 11)
		WoWPuG_WhisperCatcher_Class:SetJustifyH("Right")
		WoWPuG_WhisperCatcher_Class:SetText("Warlock")
		WoWPuG_WhisperCatcher_Class:SetWidth(80);
		WoWPuG_WhisperCatcher_Class:SetHeight(11);		
		Color = RAID_CLASS_COLORS["WARLOCK"]
		WoWPuG_WhisperCatcher_Class:SetTextColor(Color.r,Color.g,Color.b,1)
		
		WoWPuG_WhisperCatcher_Messages=WoWPuG_WhisperCatcher_Frame:CreateFontString("WoWPuG_WhisperCatcher_Messages:"..i,"ARTWORK","GameFontNormal");
		WoWPuG_WhisperCatcher_Messages:SetPoint("TopLeft",WoWPuG_WhisperCatcher_Frame,"TopLeft",5,-17);
		WoWPuG_WhisperCatcher_Messages:SetFont("Fonts\\FRIZQT__.TTF", 10)
		WoWPuG_WhisperCatcher_Messages:SetJustifyH("Left")
		WoWPuG_WhisperCatcher_Messages:SetWidth(WoWPuG_WhisperCatcher_Frame:GetWidth()-10)
		WoWPuG_WhisperCatcher_Messages:SetText("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non mi tellus. Suspendisse potenti.")
		WoWPuG_WhisperCatcher_Messages:SetTextColor(1,1,1,1)
		
		WoWPuG_WhisperCatcher_Frame:SetHeight(WoWPuG_WhisperCatcher_Name:GetHeight() + WoWPuG_WhisperCatcher_Messages:GetHeight()+10);
	end
	
	WoWPuG_WhisperCatcher_Help=CreateFrame("FRAME","WoWPuG_WhisperCatcher_Help",_G["WoWPuG_WhisperCatcher_Frame:1"]);
	WoWPuG_WhisperCatcher_Help:SetWidth(170); 
	WoWPuG_WhisperCatcher_Help:SetHeight(30);
	WoWPuG_WhisperCatcher_Help:SetPoint("BottomLeft",_G["WoWPuG_WhisperCatcher_Frame:1"],"TopLeft",0, 0);
	WoWPuG_WhisperCatcher_Help:SetBackdrop(backdrop);
	WoWPuG_WhisperCatcher_Help:Hide();
	WoWPuG_WhisperCatcher_Help:SetBackdropColor(0,0,0,1);
	
	WoWPuG_WhisperCatcher_Help_Text=WoWPuG_WhisperCatcher_Help:CreateFontString("WoWPuG_WhisperCatcher_Help_Text","ARTWORK","GameFontNormal");
	WoWPuG_WhisperCatcher_Help_Text:SetPoint("TopLeft",WoWPuG_WhisperCatcher_Help,"TopLeft",5,-5);
	WoWPuG_WhisperCatcher_Help_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
	WoWPuG_WhisperCatcher_Help_Text:SetJustifyH("Left")
	WoWPuG_WhisperCatcher_Help_Text:SetWidth(WoWPuG_WhisperCatcher_Help:GetWidth()-10)
	WoWPuG_WhisperCatcher_Help_Text:SetText("Shift+Click = Invite Player\nCtrl+Click = Remove from list")
	WoWPuG_WhisperCatcher_Help_Text:SetTextColor(1,1,1,1)
end

function WoWPuG_WhisperCatcher_ButtonPressed(self, button)
	_,ID = strsplit(":",self:GetName())
	ID = tonumber(ID);
	
	if IsShiftKeyDown() then
		print("Inviting: "..WoWPuG_DB_Temp["WhisperCatcherNames"][ID]);
		
		InviteUnit(WoWPuG_DB_Temp["WhisperCatcherNames"][ID]);
	end
	
	if IsControlKeyDown() then
		print("Removing: " .. WoWPuG_DB_Temp["WhisperCatcherNames"][ID]);
		
		WoWPuG_WhisperCatcher_Remove(ID);
	end
	
	if IsAltKeyDown() then
		print("We would whisper #"..ID);
		print(WoWPuG_DB_Temp["WhisperCatcherNames"][ID])
	end
	
	WPuG_Update_WhisperCatcher()
end

function WoWPuG_WhisperCatcher_Remove(ID)
	local Temp = {};
	local Num = #WoWPuG_DB_Temp["WhisperCatcherNames"];
	
	for i=1,Num do
		--print("i " .. i);
		--print("Num " .. Num);
		if i < ID then
			Temp[i] = WoWPuG_DB_Temp["WhisperCatcherNames"][i];
		elseif i > ID then
			Temp[i-1] = WoWPuG_DB_Temp["WhisperCatcherNames"][i];
		end
		--print(Temp[i]);
		--print("X "..#Temp)
	end
	
	wipe(WoWPuG_DB_Temp["WhisperCatcherNames"]);
	WoWPuG_DB_Temp["WhisperCatcherNames"] = {};
	WoWPuG_DB_Temp["WhisperCatcherNames"] = Temp;
	
	--print("Amount " .. #WoWPuG_DB_Temp["WhisperCatcherNames"])
	
	--for i=1,#WoWPuG_DB_Temp["WhisperCatcherNames"] do
	--	print(i .. " " .. WoWPuG_DB_Temp["WhisperCatcherNames"][i])
	--end
end


WoWPuG_WhisperCatcher_OnLoadFunction = CreateFrame("Frame");
WoWPuG_WhisperCatcher_OnLoadFunction:SetScript("OnEvent", function() 
	--print("setup1")
	WoWPuG_WhisperCatcherFrame=CreateFrame("FRAME");
	WoWPuG_WhisperCatcherFrame:SetScript("OnEvent", WoWPuG_WhisperCatcherFn) 
	WoWPuG_WhisperCatcherFrame:RegisterEvent("CHAT_MSG_WHISPER");
	WoWPuG_WhisperCatcherFrame:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
end)
WoWPuG_WhisperCatcher_OnLoadFunction:RegisterEvent("VARIABLES_LOADED");

	
function WoWPuG_WhisperCatcherFn(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = ...;
	--print(...)
	
	--print(arg1)
	--print(arg2)
	
	--print(arg12)
	--print(GetPlayerInfoByGUID(arg12))


	
	local msg = ""
	if event == "CHAT_MSG_WHISPER_INFORM" then
		msg = "|cff00ff00>>|r "
	end
	msg = msg .. arg1
	
	if WoWPuG_DB_Temp["WhisperCatcher"][arg2] == nil then
		WoWPuG_DB_Temp["WhisperCatcher"][arg2] = {};
		WoWPuG_DB_Temp["WhisperCatcher"][arg2]["Message"] = {};
		WoWPuG_DB_Temp["WhisperCatcher"][arg2]["Message"][1] = msg;
		
		local Class, ClassFileName, locRace, engRace, gender = GetPlayerInfoByGUID(arg12);
		--print (ClassFileName)
		local Color = RAID_CLASS_COLORS[ClassFileName]
		if Color == nil then
			Color = RAID_CLASS_COLORS["PRIEST"]
		end
		--print(ClassColor);
		WoWPuG_DB_Temp["WhisperCatcher"][arg2]["Class"] = Class;
		WoWPuG_DB_Temp["WhisperCatcher"][arg2]["Color"] = Color;
	else
		for i = 1,4 do
			WoWPuG_DB_Temp["WhisperCatcher"][arg2]["Message"][6-i] = WoWPuG_DB_Temp["WhisperCatcher"][arg2]["Message"][5-i];
		end
		WoWPuG_DB_Temp["WhisperCatcher"][arg2]["Message"][1] = msg;
	end
	
	--for i=1,#WoWPuG_DB_Temp["WhisperCatcher"][arg2]["Message"] do
	--	print(WoWPuG_DB_Temp["WhisperCatcher"][arg2]["Message"][i])
	--end
	
	local maxnum = #WoWPuG_DB_Temp["WhisperCatcherNames"];
	local found = false;
	for i=1,maxnum do
		if WoWPuG_DB_Temp["WhisperCatcherNames"][i] == arg2 then
			found = true;
		end
	end
	if found == false then
		WoWPuG_DB_Temp["WhisperCatcherNames"][maxnum+1] = arg2;
	end
	
	WPuG_Update_WhisperCatcher()
end


function WPuG_DEBUG_Populate_WhisperCatcher()

	WoWPuG_DB_Temp["WhisperCatcherNames"] = {
		"John",
		"Bob",
		"Timmy",
		"Phil",
		"Pete",
		"Joebob",
		"Alice",
		"Peter",
		"Doug",
		"Philis",
		"Mike",
		"Al",
		"George"
	}
	
	local CList_L = {"DRUID","ROGUE", "WARRIOR", "HUNTER", "SHAMAN","MAGE","PALADIN","PRIEST","WARLOCK","DEATHKNIGHT"};
	local CList = {"Druid","Rogue", "Warrior", "Hunter", "Shaman","Mage","Paladin","Priest","Warlock","Death Knight"};
	
	for i=1,#WoWPuG_DB_Temp["WhisperCatcherNames"] do
		local Ran = random(10)
		Class = CList[Ran];
		Color = RAID_CLASS_COLORS[CList_L[Ran]];
		
		local Name = WoWPuG_DB_Temp["WhisperCatcherNames"][i];
		
		--print(Name);
		--print(Class);
		--print(Color);
		
		WoWPuG_DB_Temp["WhisperCatcher"][Name] = {};
		
		WoWPuG_DB_Temp["WhisperCatcher"][Name]["Class"] = Class;
		WoWPuG_DB_Temp["WhisperCatcher"][Name]["Color"] = Color;
		
		WoWPuG_DB_Temp["WhisperCatcher"][Name]["Message"] = {"Test 11 22", "Test 34 5 677 8 111 ", "Test blah blah blah blah"};
	end
	
	WPuG_Update_WhisperCatcher()
end

function WPuG_Update_WhisperCatcher()
	if WPuG_SetupGrpTab2 ~= nil then
		if WPuG_SetupGrpTab2:IsShown() then
			local Height = 0;
			
			for i=1,15 do
				_G["WoWPuG_WhisperCatcher_Frame:"..i]:Hide()
			end
			
			if WPuG_WhisperTrackerCheckbox:GetChecked() then
				
				local Maxnum = #WoWPuG_DB_Temp["WhisperCatcherNames"]
				
				for i=1,15 do
					local msg = "";
					if i <= Maxnum then
						--print(i);
						_G["WoWPuG_WhisperCatcher_Frame:"..	i]:Show();
						
						local Name = WoWPuG_DB_Temp["WhisperCatcherNames"][i];
						local Class = WoWPuG_DB_Temp["WhisperCatcher"][Name]["Class"];
						local Color = WoWPuG_DB_Temp["WhisperCatcher"][Name]["Color"];
						
						--print(Name)
						--print(Class)
						--print(Color)
						
						local MsgMax = #WoWPuG_DB_Temp["WhisperCatcher"][Name]["Message"];
						
						for j=1,MsgMax do
							if j ~= 1 then
								msg = msg .. "\n";
							end
							msg = msg .. WoWPuG_DB_Temp["WhisperCatcher"][Name]["Message"][MsgMax + 1 - j];
						end
						
						--print(msg)
						
						_G["WoWPuG_WhisperCatcher_Frame:"..	i]:SetBackdropColor(Color.r,Color.g,Color.b,0.8)
						_G["WoWPuG_WhisperCatcher_Name:"..	i]:SetText(Name);
						_G["WoWPuG_WhisperCatcher_Name:"..	i]:SetTextColor(Color.r,Color.g,Color.b,1)
						_G["WoWPuG_WhisperCatcher_Class:"..	i]:SetText(Class);
						_G["WoWPuG_WhisperCatcher_Class:"..	i]:SetTextColor(Color.r,Color.g,Color.b,1)
						_G["WoWPuG_WhisperCatcher_Messages:"..i]:SetText(msg);
						
						_G["WoWPuG_WhisperCatcher_Frame:" .. i]:SetHeight(_G["WoWPuG_WhisperCatcher_Name:" .. i]:GetHeight() + _G["WoWPuG_WhisperCatcher_Messages:" .. i]:GetHeight() + 10)
					end
				end
			end
		end
	end
end

--[[
"CHAT_MSG_WHISPER"
Fired when a whisper is received from another player.

arg1
    Message received 
arg2
    Author 
arg3
    Language (or nil if universal, like messages from GM) (always seems to be an empty string; argument may have been kicked because whispering in non-standard language doesn't seem to be possible [any more?]) 
arg6
    status (like "DND" or "GM") 
arg7
    (number) message id (for reporting spam purposes?) (default: 0) 
arg8
    (number) unknown (default: 0) 
arg11
    Chat lineID used for reporting the chat message. 
arg12
    Sender GUID 
	
	
"CHAT_MSG_WHISPER_INFORM"
Fired when the player sends a whisper to another player

arg1
    Message sent 
arg2
    Player who was sent the whisper 
arg3
    Language 
arg11
    Chat lineID 
arg12
    Receiver GUID 
	]]