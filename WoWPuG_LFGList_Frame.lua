WPuGLFGOptions = {"ICC10", "ICC25", "RS10", "RS25", "ToC10", "ToC25", "VoA10", "VoA25", "Other", "All"};
WPuGLFGRaids = {"rs", "icc", "toc", "voa"};
WPuGLFGRaidsNum = {3, 1, 5, 7}; -- the id for the raids

WPuGLFGMaxNum = 50;
WOWPuG_PrefixWords = {"to" , "for"};

WOWPuG_LFMAltWords = {"making" , "makeing", "starting", "hosting", "lf "};

WOWPuG_LFMIgnoreWords = {
"%d%s*vs%s*%d", "%d%s*v%s*%d", "for%s*2s", "for%s*3s", "for%s*5s",
"leatherwork", "enchanter", "alchemist", "scribe", 
"miner", "tailor", "lf%s*jc", "lf%s*lw", "tele", "spam",
"lf%s*guild", "epic%s*jc", "enchantr", "lf%s*bs",
"lf%s*pve%s*guild", "lf%s*port", "lf%s*a%s*port",
"lf%s*ench", "lf%s*jewe", "jewel%s*craft", 
"lf%s*leveling%s*guild", "lf%s*jwc", "lf%s*work",
"girlfriend", "lf%s*encanter", "lvling", "leveling",
"greek%s*guild", "raiding%s*guild", "portal", "lf%s*inscr",
"lf%s*engi", "engineer", "dps%s*lf", "healer%s*lf", "tank%s*lf",
"blacksmith", "arena", "lf%s*echa", "parten", "lockpick",
"boost", "wtb"
};

WOWPuG_LFMOtherRaids = {"togc" , "weekly", "Razorscale"};

WoWPuG_LFGFilter = "All";
WoWPuG_LFGFilterTypes = {"icc10", "icc25", "rs10", "rs25", "toc10", "toc25", "voa10", "voa25", "Other", "All"}
WoWPuG_LFGFilterTypeColor = {"FF7D0A", "ABD473", "69CCF0", "F58CBA", "FFF569", "2459FF", "9482C9", "C79C6E", "C41F3B"} -- im lazy, these are the class colors XD
WPuG_CharColor = "00ff7f"
	
--[[
Starting a grp for Blackwing Lair! need some healers and abit DPS! only Chromaggus and Nefarian left! get your achiv now!
]]
	
function WPuG_LFGList_SortTimestamp(NumMessages)
local Num = {}

	if NumMessages > 1 then
		for i=1,NumMessages do
			Num[i] = i;
		end
		
		--print("---begin----")
		
		for i=1,NumMessages do
			for j=1,NumMessages-1 do
				
				--print("Checking " .. Num[j] .. " and " .. Num[j+1])
				
				--[[
				print("=!=!=begin=!=!=")
				for k=1,NumMessages do
					print(Num[k])
				end
				print("=!=!=end=!=!=")
				]]
				
				local Char1 = WPuG_LFGListMessageArray_FilteredNameList[Num[j]];
				local Char2 = WPuG_LFGListMessageArray_FilteredNameList[Num[j+1]];
				
				--print(Char1)
				--print(Char2)
				
				if WPuG_LFGListMessageArray[Char1]["Timestamp"] < WPuG_LFGListMessageArray[Char2]["Timestamp"] then
					--print(WPuG_LFGListMessageArray[Char1]["Timestamp"])
					--print(WPuG_LFGListMessageArray[Char2]["Timestamp"])
					
					--print("Swapping " .. Num[j] .. " and " .. Num[j+1])
					
					-- Swap the ID's
					local Temp = Num[j];
					Num[j] = Num[j+1];
					Num[j+1] = Temp;
				end
			end
		end
		
		local TempArray = {};
		
		for i=1,NumMessages do
			TempArray[i] = _G["WPuG_LFGMessages_Text:" .. i]:GetText();
		end
		
		for i=1,NumMessages do
			--print(Num[i]);
			
			_G["WPuG_LFGMessages_Text:" .. i]:SetText(TempArray[Num[i]]);
		end
		
		--print("---end----")
	end
	
	WPuG_LFGList_Update()
end
	
WPuG_ShouldBeBlue = 	{0,0,0,0,0,0,0,0,0,0};
WPuG_ShouldBeRed = 		{0,0,0,0,0,0,0,0,0,0};
WPuG_ShouldBePurpleID = 10;

function WPug_ButtonColorUpdate()	
	for i=1,10 do
		if WPuG_ShouldBeBlue[i] == 1 then
			--print("Blue"..i)
			_G["WPuG_LFGFilterButton:"..i]:SetNormalTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Up-Blue");
			_G["WPuG_LFGFilterButton:"..i]:SetPushedTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Down-Blue");
		elseif WPuG_ShouldBePurpleID == i then
			--print("Purple"..i)
			_G["WPuG_LFGFilterButton:"..i]:SetNormalTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Up-Purple");
			_G["WPuG_LFGFilterButton:"..i]:SetPushedTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Down-Purple");
		elseif WPuG_ShouldBeRed[i] == 1 then
			--print("Red"..i)
			_G["WPuG_LFGFilterButton:"..i]:SetNormalTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Up-Red");
			_G["WPuG_LFGFilterButton:"..i]:SetPushedTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Down-Red");
		else
			--print("Grey"..i)
			_G["WPuG_LFGFilterButton:"..i]:SetNormalTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Up-Grey");
			_G["WPuG_LFGFilterButton:"..i]:SetPushedTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Down-Grey");
		end
	end
end
	
function WPuG_FilterButtons_Update()
local WPuG_AmtLFGRaid = {0,0,0,0,0,0,0,0,0};
local Total = 0;

	if WPuG_LastAmtLFGRaid == nil then
		WPuG_LastAmtLFGRaid = 	{0,0,0,0,0,0,0,0,0};
	end

	for i=1,WPuG_LFGAmtOfNames do
		Char = WPuG_LFGNamesArray[i];
		
		for i=1,9 do
			if WoWPuG_LFGFilterTypes[i] == WPuG_LFGListMessageArray[Char]["InstanceName"] then
				WPuG_AmtLFGRaid[i] = WPuG_AmtLFGRaid[i] + 1;
			end
		end
	end	
	
	for i=1,9 do
		--print("Raid " .. i .. ": " .. WPuG_AmtLFGRaid[i]);
		_G["WPuG_LFGFilterButton:"..i]:SetText(WPuGLFGOptions[i].." (" .. WPuG_AmtLFGRaid[i] .. ")")
		
		if WPuG_AmtLFGRaid[i] > 0 then
			WPuG_ShouldBeRed[i] = 1;
		else
			WPuG_ShouldBeRed[i] = 0;
			WPuG_ShouldBeBlue[i] = 0;
		end
		
		if WPuG_LastAmtLFGRaid[i] < WPuG_AmtLFGRaid[i] then			
			WPuG_ShouldBeBlue[i] = 1;
		end
		Total = Total + WPuG_AmtLFGRaid[i];
	end
	
	WPuG_LastAmtLFGRaid = WPuG_AmtLFGRaid;
	
	if Total > 0 then
		WPuG_ShouldBeRed[10] = 1;
	end
	--print("Total: " .. Total);
	_G["WPuG_LFGFilterButton:" .. 10]:SetText(WPuGLFGOptions[10].." (" .. Total .. ")")
	
	WPug_ButtonColorUpdate()
end
	
function WPuG_LFGList_Update()
	
	local Height = 0
	for i=1,WPuGLFGMaxNum do
		Height = Height + _G["WPuG_LFGMessages_Text:"..i]:GetHeight();
		if i > 1 then
			Height = Height + 5;
		end
		
		if Height > WPuG_LFGList_MainFrame:GetHeight() - 10 then
			_G["WPuG_LFGMessages_Text:"..i]:Hide()
			_G["WPuG_LFGMessages_Button:"..i]:Hide();
		end
	end
	
	WPuG_FilterButtons_Update();
	
	--[[
	local NumHidden = 0
	for i=1,WPuGLFGMaxNum do
		if not _G["WPuG_LFGMessages_Text:"..i]:IsShown() then
			NumHidden = NumHidden + 1;
		end
	end
	]]
	
	--print(NumHidden .. " hidden")
end

WPuG_LFGListMessageArray = {};
WPuG_LFGAmtOfNames = 0;
WPuG_LFGNamesArray = {};

WPuG_LFGListMessageArray_FilteredNameList = {};

function WPuG_CheckIfNewMessage(Char, InstanceName, Timestamp, Message)
	--print(Char)
	--print(InstanceName)
	--print(Timestamp)
	--print(Message)
	
	if InstanceName ~= nil then
		local ValidInstanceName = false;
		
		-- look for known raid  names and flkag them as known
		for i=1,8 do
			if InstanceName == WoWPuG_LFGFilterTypes[i] then
				ValidInstanceName = true;
			end
		end
		
		-- look for known "other" raids and flag them
		if ValidInstanceName == false then
			for i=1,#(WOWPuG_LFMOtherRaids) do
				if string.find(str_lower, WOWPuG_LFMOtherRaids[i]) then
					--str_start,str_end = string.find(str_lower, WOWPuG_LFMOtherRaids[i])
					InstanceName = "Other";
				end
			end
		end
		
		-- double check 
		if ValidInstanceName ~= true and InstanceName ~= "Other" and InstanceName ~= "Blocked" then
			for i=1,4 do
				if i == 1 then	-- RS checking (try make sure it doesnt conflickt with "healeRS")
					if string.find(string.lower(Message), "rs") then
						if (string.find(string.lower(Message), "ers") == nil) or (string.find(string.lower(Message), "ers") ~= string.find(string.lower(Message), "rs" )-1) then
							--print(string.find(string.lower(Message), "ers"))
							--print(string.find(string.lower(Message), "rs"))
							
							
							--ChatFrame1:AddMessage(string.find(string.lower(Message), "ers"))
							--ChatFrame1:AddMessage(string.find(string.lower(Message), "rs" )+1)
							
							if string.find(Message, "25") then
								ValidInstanceName = true;
								InstanceName = WoWPuG_LFGFilterTypes[WPuGLFGRaidsNum[i]+1];
								--print(WoWPuG_LFGFilterTypes[WPuGLFGRaidsNum[i]+1])
							else
								ValidInstanceName = true;
								InstanceName = WoWPuG_LFGFilterTypes[WPuGLFGRaidsNum[i]];
								--print(WoWPuG_LFGFilterTypes[WPuGLFGRaidsNum[i]])
							end
						end
					end
				else
					if string.find(string.lower(Message), WPuGLFGRaids[i]) then
						if string.find(Message, "25") then
							ValidInstanceName = true;
							InstanceName = WoWPuG_LFGFilterTypes[WPuGLFGRaidsNum[i]+1];
							--print(WoWPuG_LFGFilterTypes[WPuGLFGRaidsNum[i]+1])
						else
							ValidInstanceName = true;
							InstanceName = WoWPuG_LFGFilterTypes[WPuGLFGRaidsNum[i]];
							--print(WoWPuG_LFGFilterTypes[WPuGLFGRaidsNum[i]])
						end
					end
				end
			end
		end
		
		if ValidInstanceName ~= true and InstanceName ~= "Blocked" then
			InstanceName = "Other";
		end
	end
	
	if WPuG_LFGListMessageArray[Char] == nil then	-- this is when the message was found for the 1st time
		WPuG_LFGListMessageArray[Char] = {};
		WPuG_LFGAmtOfNames = WPuG_LFGAmtOfNames + 1;
		WPuG_LFGNamesArray[WPuG_LFGAmtOfNames] = Char;
		WPuG_CatchNextMessages(Char);
		--print(WPuG_LFGAmtOfNames);
		WPuG_AddNewMessage(Char, InstanceName, Timestamp, Message);
	elseif WPuG_LFGListMessageArray[Char]["InstanceName"] ~= InstanceName then	-- If they are now looking for a new instance
		--print("InstanceNameUpdated " .. WPuG_LFGListMessageArray[Char]["InstanceName"] .. " - " .. InstanceName)
		WPuG_AddNewMessage(Char, InstanceName, Timestamp, Message);
		WPuG_CatchNextMessages(Char);
	elseif WPuG_LFGListMessageArray[Char]["Message"] ~= Message then	-- if they changed their message
		--print("MessageUpdated " .. WPuG_LFGListMessageArray[Char]["Message"] .. " - " .. Message)
		WPuG_AddNewMessage(Char, InstanceName, Timestamp, Message);
		WPuG_CatchNextMessages(Char);
	elseif WPuG_LFGListMessageArray[Char]["Timestamp"] < time() - 60 then	-- if they pass the time threshold (60 sec?)
		--print("TimeUpdated " .. WPuG_LFGListMessageArray[Char]["Timestamp"] .. " - " .. time())
		WPuG_AddNewMessage(Char, InstanceName, Timestamp, Message);
		WPuG_CatchNextMessages(Char);
	end
end

--WPuG_CatchNextMessageNames = {};
WPuG_CatchNextMessageTime = {};
--WPuG_CatchNextMessageNamesAmount = 0;
function WPuG_CatchNextMessages(Char)
	WPuG_CatchNextMessageTime[Char] = time();
end



function WPuG_AddNewMessage(Char, InstanceName, Timestamp, Message)
local ValidInstanceName = false
	
	WPuG_LFGListMessageArray[Char]["InstanceName"] = InstanceName;
	WPuG_LFGListMessageArray[Char]["Timestamp"] = Timestamp;
	WPuG_LFGListMessageArray[Char]["Message"] = Message;
	
	WPuG_LFGCreateList(WoWPuG_LFGFilter)
end

function WPuG_RemovePerson(Char)
local CharFound = false;
	
	for i=1,WPuG_LFGAmtOfNames do
		if Char == WPuG_LFGNamesArray[i] then
			CharFound = true;
			WPuG_LFGListMessageArray[Char] = nil;
		end
		if CharFound then
			--[[
			if WPuG_LFGNamesArray[i+1] ~= nil then
				print("replacing " .. WPuG_LFGNamesArray[i] .. " with " .. WPuG_LFGNamesArray[i+1])
			else
				print("replacing " .. WPuG_LFGNamesArray[i] .. " with " .. "nil")
			end
			]]
			WPuG_LFGNamesArray[i] = WPuG_LFGNamesArray[i+1]
		end
	end	
	
	if CharFound then
		WPuG_LFGAmtOfNames = WPuG_LFGAmtOfNames - 1;
	end
end

function WPuG_LFGCreateList(FilterInstanceName)
local NumMessages = 0;
local Char;
local WPuG_NumMessagesOffset = 0;

	for i=1,WPuGLFGMaxNum do
		_G["WPuG_LFGMessages_Text:"..i]:Hide();		-- hide all messages and buttons
		_G["WPuG_LFGMessages_Button:"..i]:Hide();
	end

	if WPuG_LFGAmtOfNames > 0 then
		-- Check for ppl who are gone beyond 10 min
		for i=1,WPuG_LFGAmtOfNames do
			Char = WPuG_LFGNamesArray[i];
			
			if Char ~= nil then
				Timestamp    = WPuG_LFGListMessageArray[Char]["Timestamp"];
				
				TimeMinutes = time() - Timestamp;
				TimeMinutes = TimeMinutes / 60;
				TimeMinutes = floor(TimeMinutes);
				
				if TimeMinutes >= 10 then				
					WPuG_RemovePerson(Char);
				end
			end
		end
		
		for i=1,WPuG_LFGAmtOfNames do
			Char = WPuG_LFGNamesArray[i];
			--print(Char)
			
			if (FilterInstanceName == "All" and WPuG_LFGListMessageArray[Char]["InstanceName"] ~= "Blocked") or (FilterInstanceName == WPuG_LFGListMessageArray[Char]["InstanceName"]) then
				NumMessages = NumMessages + 1;
				
				--print(i)
				
				WPuG_LFGListMessageArray_FilteredNameList[NumMessages] = Char;
				--print(Char);
				
				InstanceName = WPuG_LFGListMessageArray[Char]["InstanceName"];
				Timestamp    = WPuG_LFGListMessageArray[Char]["Timestamp"];
				Message      = WPuG_LFGListMessageArray[Char]["Message"];
				
				TimeMinutes = time() - Timestamp;
				TimeMinutes = TimeMinutes / 60;
				TimeMinutes = floor(TimeMinutes);
				
				if TimeMinutes < 10 then
					if TimeMinutes == 0 then
						TimeMinutes = "<1";
					end
					
					TimeMinutes = TimeMinutes .. " minute(s) ago"
					
					--print(NumMessages-WPuG_NumMessagesOffset)
					
					--_G["WPuG_LFGMessages_Text:"..NumMessages-WPuG_NumMessagesOffset]:Show();
					--_G["WPuG_LFGMessages_Button:"..NumMessages-WPuG_NumMessagesOffset]:Show();
					
					_G["WPuG_LFGMessages_Text:"..NumMessages]:Show();
					_G["WPuG_LFGMessages_Button:"..NumMessages]:Show();
					
					local ValidInstanceName = false
	
					for i=1,9 do
						if InstanceName == WoWPuG_LFGFilterTypes[i] then
							InstanceName = "|cff" .. WoWPuG_LFGFilterTypeColor[i] .. InstanceName .. "|r"
						end
					end
					
					local Char_Color = "|cff" .. WPuG_CharColor .. Char .. "|r"
					
					if  WPuG_LFGListMessageArray[Char]["Hidden"] ~= true then
						Message_OP = "\n    " .. Message;
					else
						Message_OP = " -|cffff2233 Hidden|r";
					end
					
					_G["WPuG_LFGMessages_Text:"..NumMessages]:SetText(
																		Char_Color .. " - " .. 
																		InstanceName .. " - " .. 
																		TimeMinutes .. 
																		Message_OP
																	 )
				end
			end
		end
	end
	
	WPuG_LFGList_SortTimestamp(NumMessages)
end
	
function x_WPuG_LFGList_FrameSetup()

WPuG_ComingSoon_Text=WPuG_LFGListTab:CreateFontString("WPuG_ComingSoon_Text","ARTWORK","GameFontNormal");
WPuG_ComingSoon_Text:SetText("LFG List: Coming Soon")
WPuG_ComingSoon_Text:SetPoint("Center",WPuG_LFGListTab)

--[[
PlayerNames
Amt of Names
]]

--[[
PlayerName
Timerstamp
Instance
Message
]]


end

function WPuG_LFGList_FrameSetup()

	local backdrop = {
	  bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",  -- path to the background texture
	  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",  -- path to the border texture
	  
	  tile = false,    -- true to repeat the background texture to fill the frame, false to scale it
	  tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
	  edgeSize = 20,  -- thickness of edge segments and square size of edge corners (in pixels)
	  insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
	    left = 4,
	    right = 4,
	    top = 4,
	    bottom = 4
	  }
	}
	
	

	WPuG_LFGList_MainFrame=CreateFrame("FRAME","WPuG_LFGList_MainFrame",WPuG_LFGListTab);
	WPuG_LFGList_MainFrame:SetWidth(WPuG_MainFrame:GetWidth()-20); 
	WPuG_LFGList_MainFrame:SetHeight(WPuG_MainFrame:GetHeight()-80);
	WPuG_LFGList_MainFrame:SetPoint("Bottom",WPuG_LFGListTab,"Bottom",0, 10);
	WPuG_LFGList_MainFrame:SetBackdrop(backdrop)
	WPuG_LFGList_MainFrame:SetScript("OnUpdate", 	function()
														if time() ~= WPug_UpdateTempTime then
															WPug_UpdateTempTime = time();
															WPuG_LFGCreateList(WoWPuG_LFGFilter);
														end
													end)
	
	for i=1,10 do
		WPuG_LFGFilterButton = CreateFrame("Button", "WPuG_LFGFilterButton:"..i, WPuG_LFGList_MainFrame, "UIPanelButtonTemplate");
		if i == 1 then
			WPuG_LFGFilterButton:SetPoint("BottomLeft",WPuG_LFGList_MainFrame,"TopLeft",0,20);
		elseif (i/2 - floor(i/2)) == 0 then	-- even numbers
			WPuG_LFGFilterButton:SetPoint("TopLeft",_G["WPuG_LFGFilterButton:"..i-1],"BottomLeft",0,0);
		else	-- odd numbers
			WPuG_LFGFilterButton:SetPoint("TopLeft",_G["WPuG_LFGFilterButton:"..i-2],"TopRight",0,0);
		end
		WPuG_LFGFilterButton:SetWidth(WPuG_LFGList_MainFrame:GetWidth()/5);
		WPuG_LFGFilterButton:SetHeight(20);
		WPuG_LFGFilterButton:SetText(WPuGLFGOptions[i] .. " (99)");
		WPuG_LFGFilterButton:SetScript("OnClick",	function(self) 
														_,ID = strsplit(":",self:GetName())
														ID = tonumber(ID);
														
														--print(ID);
														--print(WoWPuG_LFGFilterTypes[ID]);
														
														WPuG_ShouldBeBlue[ID] = 0;
														WPuG_ShouldBePurpleID = ID;
														
														WoWPuG_LFGFilter = WoWPuG_LFGFilterTypes[ID];
														WPuG_LFGCreateList(WoWPuG_LFGFilter);
														
														WPug_ButtonColorUpdate()
													end);
		if i == 10 then
			WPuG_LFGFilterButton:SetScript("OnEnter",	function() 
															if IsAltKeyDown() then
																WoWPuG_LFGFilter = "Blocked";
																WPuG_LFGCreateList(WoWPuG_LFGFilter);
																print("Showing Blocked Messages")
															end
														end);
		end
	end
	
	for i=1,WPuGLFGMaxNum do
		WPuG_LFGMessages_Text=WPuG_LFGList_MainFrame:CreateFontString("WPuG_LFGMessages_Text:"..i,"ARTWORK","GameFontNormal");
		if i ==1 then
			WPuG_LFGMessages_Text:SetPoint("TopLeft",WPuG_LFGList_MainFrame,"TopLeft",5,-5);
		else
			WPuG_LFGMessages_Text:SetPoint("TopLeft",_G["WPuG_LFGMessages_Text:"..i-1],"BottomLeft",0,-5);
		end
		WPuG_LFGMessages_Text:SetJustifyH("Left")
		WPuG_LFGMessages_Text:SetWidth(WPuG_LFGList_MainFrame:GetWidth()-20)
		WPuG_LFGMessages_Text:SetTextColor(1,1,1,1)
		WPuG_LFGMessages_Text:SetText("")
		--WPuG_LFGMessages_Text:SetText("|cff11ff11" .. i .. "|r" .. " X")
		
		WPuG_LFGMessages_Button = CreateFrame("Button", "WPuG_LFGMessages_Button:"..i, WPuG_LFGList_MainFrame, "UIPanelButtonTemplate");
		WPuG_LFGMessages_Button:SetPoint("Top", WPuG_LFGMessages_Text, "Top")
		WPuG_LFGMessages_Button:SetPoint("Bottom", WPuG_LFGMessages_Text, "Bottom")
		WPuG_LFGMessages_Button:SetPoint("Left", WPuG_LFGMessages_Text, "Left")
		WPuG_LFGMessages_Button:SetPoint("Right", WPuG_LFGMessages_Text, "Right")
		WPuG_LFGMessages_Button:SetNormalTexture( "" )
		WPuG_LFGMessages_Button:SetPushedTexture( "" )
		WPuG_LFGMessages_Button:SetScript("OnClick",function(self, button) 
														_,ID = strsplit(":",self:GetName())
														ID = tonumber(ID);
														
														if button == "LeftButton" then
															local Char = _G["WPuG_LFGMessages_Text:" .. ID]:GetText(); 
															Char = strsub(Char, 11)
															Char = string.match(Char, "%a+")
															
															if WPuG_LFGListMessageArray[Char]["Hidden"] == true then
																WPuG_LFGListMessageArray[Char]["Hidden"] = false;
															else
																WPuG_LFGListMessageArray[Char]["Hidden"] = true;
															end
															
															WPuG_LFGCreateList(WoWPuG_LFGFilter)
														else
															print(_G["WPuG_LFGMessages_Text:" .. ID]:GetText())
														end
													end);
	end
	
	WPuG_LFGList_MessageHandlerFrame=CreateFrame("FRAME");
	WPuG_LFGList_MessageHandlerFrame:RegisterEvent("CHAT_MSG_CHANNEL")
	WPuG_LFGList_MessageHandlerFrame:RegisterEvent("CHAT_MSG_SAY")
	WPuG_LFGList_MessageHandlerFrame:SetScript("OnEvent", WPuG_LFGList_MessageHandler)  
end



--[[
	WPuG_LFGList_MessageHandlerFrame=CreateFrame("FRAME");
	WPuG_LFGList_MessageHandlerFrame:RegisterEvent("CHAT_MSG_ADDON")
	WPuG_LFGList_MessageHandlerFrame:SetScript("OnEvent", function(self, event, ...) 	print("|cff00ff00Recieved");	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...;print(arg1);print(arg2);print(arg3);print(arg4);end)  

	local Intercepted_SendAddonMessage = SendAddonMessage
	
	
function SendAddonMessage(prefix, text, mtype, target)
	
	print("|cffff0000Intercepted")	
	print(prefix);
	print(text);
	print(mtype);
	print(target);
	
	print(#text)
	
	Intercepted_SendAddonMessage(prefix, text, mtype, target)
end
	]]

--arg1
 --   prefix 
--arg2
 --   message 
--arg3
 --   distribution type ("PARTY", "RAID", "GUILD", "BATTLEGROUND" or "WHISPER") 
--arg4
--    sender 
	
	

function WPuG_LFGList_MessageHandler(self, event, ...)
local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...;

local InstanceName = nil;
local Char = nil;
local Timestamp = nil;
local Message = nil;

	if arg1 ~= nil then
		if arg2 ~= nil then
			if WPuG_CatchNextMessageTime[arg2] ~= nil then
				local PassedTime = time() - WPuG_CatchNextMessageTime[arg2];
				--print(arg2 .. " sent a message " .. PassedTime .. " seconds later.")
				if PassedTime < 2 then	-- they have 2 seconds to send the additional details
					if arg1 == WPuG_LFGListMessageArray[arg2]["Message"] then
						--print("|cff00ff00It was the same as their original message")
					else
						--print("|cffff0000It was a new message. Adding...")
						WPuG_LFGListMessageArray[arg2]["Message"] = WPuG_LFGListMessageArray[arg2]["Message"] .. " " .. arg1
					end
				else
					--print("|cffff00ffClearing "..arg2)
					WPuG_CatchNextMessageTime[arg2] = nil;
				end
			end
		end
		
		str_lower = string.lower(arg1)
		
		local str_start,str_end
		
		local LFG_FoundMessage = false;
		if string.find(str_lower, "lf%d*m") then
			LFG_FoundMessage = true;
			str_start,str_end = string.find(str_lower, "lf%d*m")
		elseif string.find(str_lower, "lfm") then
			LFG_FoundMessage = true;
			str_start,str_end = string.find(str_lower, "lfm")
		end
		
		-- check for other terms
		if LFG_FoundMessage == false then
			for i=1,#(WOWPuG_LFMAltWords) do
				if string.find(str_lower, WOWPuG_LFMAltWords[i]) then
					str_start,str_end = string.find(str_lower, WOWPuG_LFMAltWords[i])
					LFG_FoundMessage = true;
				end
			end
		end
		
		-- look for terms to ignore e.g. lf x for my 3v3 team
		if LFG_FoundMessage == true then
			--print("Checking " .. str_lower)
			for i=1,#(WOWPuG_LFMIgnoreWords) do -- #(WOWPuG_LFMIgnoreWords) = the num of values in WOWPuG_LFMIgnoreWords
				if string.find(str_lower, WOWPuG_LFMIgnoreWords[i]) then
					--print("|cffff3355Blocked|r |cff33ff55(ID#" .. i .. ")|r: " .. arg1)
					--str_end = nil;
					arg1 = "|cffff3355Blocked|r |cff33ff55(ID#" .. i .. ")|r: " .. arg1;
					InstanceName = "Blocked";
				end
			end
		end
		
		--print(str_start)
		--print(str_end)
		
		if str_end ~= nil then
			local sub_string = string.sub(str_lower, str_end+1)		-- remove the "LFM" tag and anything before it (the name of the instance should come next)
			sub_string = strtrim(sub_string)		-- remove all leading and trailing spaces
			--print(sub_string)
			
			
			local WoWPuG_PrefixCheck = false
			for i=1,#(WOWPuG_PrefixWords) do
				if strsplit(" ",sub_string) == WOWPuG_PrefixWords[i] then
					WoWPuG_PrefixCheck = true;
				end
			end
			
			--print(sub_string)
			
			local Instance, Size = "" , ""
			
			if WoWPuG_PrefixCheck == true then
				_, Instance, Size = strsplit(" ",sub_string)
			else
				Instance, Size = strsplit(" ",sub_string)
			end
			
			if Instance == nil then Instance = "" end
			if Size == nil then Size = "" end
			
			--print("---" .. Instance .. "---" )--.. strlen(Instance))
			--print("---" .. Size .. "---" )--.. strlen(Size))
			
			-- Search the instance name for a number e.g. ICC25
			local NumFound = false
			for i=1,strlen(Instance) do
				local Check = tonumber(string.sub(Instance, i,i))
				--print(Check)
				
				if Check ~= nil then
					NumFound = true
					Size = ""
				end
			end
			
			-- If we found numbers then remove all letters after the numbers
			local InitialDelay = false
			if NumFound == true then
				for i=1,strlen(Instance) do
					--print("----------")
					local Check = tonumber(string.sub(Instance, i,i))
					--print(Check)
					
					--print(string.sub(Instance, 0,i-1))
					--print(string.sub(Instance, i+1))
					
					if Check ~= nil then	-- thi
						InitialDelay = true
					end
					
					if Check == nil and InitialDelay == true then -- we found a letter after the numbers
						--print("xxx")
						Instance = string.sub(Instance, 0,i-1) .. " " .. string.sub(Instance, i+1)
					end
				end
				Instance = string.gsub(Instance, " ", "")	-- remove the spaces
			end
			
			-- If there were no numbers found then remove all the letters from the 2nd string
			if NumFound ~= true then
				for i=1,strlen(Size) do
					--print("----------")
					local Check = tonumber(string.sub(Size, i,i))
					--print(Check)
					
					--print(string.sub(Size, 0,i-1))
					--print(string.sub(Size, i+1))
					
					if Check == nil then
						--print("xxx")
						Size = string.sub(Size, 0,i-1) .. " " .. string.sub(Size, i+1)
					end
				end
				Size = string.gsub(Size, " ", "")	-- remove the spaces
			end
			
			if InstanceName == nil then
				InstanceName = Instance .. Size;
			end
			Char = arg2;
			Timestamp = time();
			Message = arg1;
			
			--print(Instance .. Size .. " - " .. arg1)
			
			-- Check if there was a new message or an older one
			WPuG_CheckIfNewMessage(Char, InstanceName, Timestamp, Message)
			
			--[[
			local FoundMessage = false;
			for i=1,WPuGLFGMaxNum do
				if _G["WPuG_LFGMessages_Text:" ..i]:IsShown() then
					if _G["WPuG_LFGMessages_Text:" ..i]:GetText() then
						if string.find(_G["WPuG_LFGMessages_Text:" ..i]:GetText(), arg1) then
							FoundMessage = true;
						end
					end
				end
			end
			
			if FoundMessage == false then
				for i=1,WPuGLFGMaxNum-1 do
					_G["WPuG_LFGMessages_Text:" .. WPuGLFGMaxNum+1-i]:SetText(_G["WPuG_LFGMessages_Text:"..WPuGLFGMaxNum-i]:GetText())
				end
				
				Char = arg2;
				
				_G["WPuG_LFGMessages_Text:" .. 1]:SetText("|cff11ff11" .. Instance .. Size .. "|r" 
															.. " - " .. "|cff11617f" .. Char .. "|r" 
															.. " - " .. "|cff6f11ff" .. time() .. "|r" 
															.. " \n   " .. arg1)
				
				WPuG_LFGList_Update()
			end
			]]
		end
	end
end 