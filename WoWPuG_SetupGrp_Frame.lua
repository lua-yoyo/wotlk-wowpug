WPuG_IncrementValue = 1;
WPuG_JoinOrLeaveQue = {};

local WPuG_SpecTypeNames = {	"tank",
								"healer/s",
								"melee",
								"ranged",
								"unknown"
							}
							
function WPuG_SetupGrp2_FrameSetup()
	WPuG_JoinedOrLeft_MessageHandlerFrame=CreateFrame("FRAME");
	WPuG_JoinedOrLeft_MessageHandlerFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
	WPuG_JoinedOrLeft_MessageHandlerFrame:SetScript("OnEvent", WPuG_DidSomeoneJoin)
	WPuG_SomeoneJoinedOrLeft_SetupFrame()
	
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
	
-- Setup the frame boxes (begin) ------------------------------------------------------------------------------------------------------
	WPuG_SetupGrp_DungeonList_Frame=CreateFrame("FRAME","WPuG_SetupGrp_DungeonList_Frame",WPuG_SetupGrpTab2);
	WPuG_SetupGrp_DungeonList_Frame:SetWidth(100); 
	WPuG_SetupGrp_DungeonList_Frame:SetHeight(70);
	WPuG_SetupGrp_DungeonList_Frame:SetPoint("TOPLEFT",WPuG_SetupGrpTab2,"TOPLEFT",12, -30);
	WPuG_SetupGrp_DungeonList_Frame:SetBackdrop(backdrop)
	
	WPuG_SetupGrp_DungeonList_Name_Frame=CreateFrame("FRAME","WPuG_SetupGrp_DungeonList_Name_Frame",WPuG_SetupGrp_DungeonList_Frame);
	WPuG_SetupGrp_DungeonList_Name_Frame:SetWidth(90); 
	WPuG_SetupGrp_DungeonList_Name_Frame:SetHeight(25);
	WPuG_SetupGrp_DungeonList_Name_Frame:SetPoint("TOPLEFT",WPuG_SetupGrp_DungeonList_Frame,"TOPLEFT",5, -18);
	WPuG_SetupGrp_DungeonList_Name_Frame:SetBackdrop(backdrop)
	
	WPuG_SetupGrp_ClassInfo_Frame=CreateFrame("FRAME","WPuG_SetupGrp_ClassInfo_Frame",WPuG_SetupGrpTab2);
	WPuG_SetupGrp_ClassInfo_Frame:SetWidth(270); 
	WPuG_SetupGrp_ClassInfo_Frame:SetHeight(WPuG_SetupGrp_DungeonList_Frame:GetHeight());
	WPuG_SetupGrp_ClassInfo_Frame:SetPoint("LEFT",WPuG_SetupGrp_DungeonList_Frame,"RIGHT",0, 0);
	WPuG_SetupGrp_ClassInfo_Frame:SetBackdrop(backdrop)
	
	WPuG_SetupGrp_AdvertiseEvery_Frame=CreateFrame("FRAME","WPuG_SetupGrp_AdvertiseEvery_Frame",WPuG_SetupGrpTab2);
	WPuG_SetupGrp_AdvertiseEvery_Frame:SetWidth(105); 
	WPuG_SetupGrp_AdvertiseEvery_Frame:SetHeight(WPuG_SetupGrp_DungeonList_Frame:GetHeight());
	WPuG_SetupGrp_AdvertiseEvery_Frame:SetPoint("LEFT",WPuG_SetupGrp_ClassInfo_Frame,"RIGHT",0, 0);
	WPuG_SetupGrp_AdvertiseEvery_Frame:SetBackdrop(backdrop)
	
	WPuG_SetupGrp_Group_Frame=CreateFrame("FRAME","WPuG_SetupGrp_Group_Frame",WPuG_SetupGrpTab2);
	WPuG_SetupGrp_Group_Frame:SetWidth(WPuG_SetupGrpTab2:GetWidth()-25); 
	WPuG_SetupGrp_Group_Frame:SetHeight(200);
	WPuG_SetupGrp_Group_Frame:SetPoint("TopLEFT",WPuG_SetupGrp_DungeonList_Frame,"BottomLeft",0, 0);
	WPuG_SetupGrp_Group_Frame:SetBackdrop(backdrop)
	
	WPuG_SetupGrp_Message_Frame=CreateFrame("FRAME","WPuG_SetupGrp_Message_Frame",WPuG_SetupGrpTab2);
	WPuG_SetupGrp_Message_Frame:SetWidth(WPuG_SetupGrpTab2:GetWidth()-25); 
	WPuG_SetupGrp_Message_Frame:SetHeight(30);
	WPuG_SetupGrp_Message_Frame:SetPoint("TopLEFT",WPuG_SetupGrp_Group_Frame,"BottomLeft",0, 0);
	WPuG_SetupGrp_Message_Frame:SetBackdrop(backdrop)
	
	WPuG_SetupGrp_SampleOutput_Frame=CreateFrame("FRAME","WPuG_SetupGrp_SampleOutput_Frame",WPuG_SetupGrpTab2);
	WPuG_SetupGrp_SampleOutput_Frame:SetWidth(WPuG_SetupGrpTab2:GetWidth()-25); 
	WPuG_SetupGrp_SampleOutput_Frame:SetHeight(60);
	WPuG_SetupGrp_SampleOutput_Frame:SetPoint("TopLEFT",WPuG_SetupGrp_Message_Frame,"BottomLeft",0, 0);
	WPuG_SetupGrp_SampleOutput_Frame:SetBackdrop(backdrop)
-- Setup the frame boxes (end) ------------------------------------------------------------------------------------------------------

	
-- Raid Select Box (begin) ------------------------------------------------------------------------------------------------------
	WPuG_SetupGrp_RaidName_Text=WPuG_SetupGrp_DungeonList_Frame:CreateFontString("WPuG_SetupGrp_RaidName_Text","ARTWORK","GameFontNormal");
	WPuG_SetupGrp_RaidName_Text:SetPoint("TopLeft",WPuG_SetupGrp_DungeonList_Frame,"TopLeft",8,-8);
	WPuG_SetupGrp_RaidName_Text:SetJustifyH("Left");
	WPuG_SetupGrp_RaidName_Text:SetText("Name:");
	
	
	function WPuG_SetupGrp_SelectRaid_Dropdown_Initialize(self,level)
		level = 1;
		
		for i=1,#WoWPuG_DB["Raid"]+1 do
			local info = UIDropDownMenu_CreateInfo();
			info.hasArrow = false;
			info.notCheckable = true;
			if i <= #WoWPuG_DB["Raid"] then
				info.text = WoWPuG_DB["Raid"][i]["Name"];
				info.func       = function(self)
					--print(self:GetID());
					WoWPuG_DB["RaidSelected"] = tonumber(self:GetID());
					WPuG_SetupGrp_MessageBox:SetText(WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]]["Message"])
					WPuG_SetupGrp_MessageUpdate();
				end; 
			else
				info.text = "|cffff7799".."Create";
				info.func       = function(self)	print(self:GetID()); print("(^_^) Not Yet Implemented (^_^)"); end; 
			end
			
			UIDropDownMenu_AddButton(info, level);
		end
	end
	
	WPuG_SetupGrp_SelectRaid_Dropdown = CreateFrame("Frame", "WPuG_SetupGrp_SelectRaid_Dropdown", WPuG_SetupGrp_DungeonList_Frame, "UIDropDownMenuTemplate");
	WPuG_SetupGrp_SelectRaid_Dropdown:SetPoint("TopLeft",WPuG_SetupGrpTab2,"TopLeft",-8,-5);
	WPuG_SetupGrp_SelectRaid_Dropdown:SetWidth(100);
	
	_G["WPuG_SetupGrp_SelectRaid_Dropdown".."Text"]:SetText("Select Raid")
	local ID = WoWPuG_DB["RaidSelected"]
	if ID == nil then ID = 1 end;
	
	if WoWPuG_DB["Raid"][ID]["Name"] == nil then
		WoWPuG_DB["Raid"][ID]["Name"] = ">Name not found<"
	end
	local name = WoWPuG_DB["Raid"][ID]["Name"];
	
	if #name > 12 then
		name = string.sub(name, 0, 11) .. "..";
	end
	_G["WPuG_SetupGrp_SelectRaid_Dropdown".."Text"]:SetText(name);
	
	UIDropDownMenu_Initialize(WPuG_SetupGrp_SelectRaid_Dropdown, WPuG_SetupGrp_SelectRaid_Dropdown_Initialize);
-- Raid Select Box (end) ------------------------------------------------------------------------------------------------------	
	
	
-- Raid Name Input (begin) ------------------------------------------------------------------------------------------------------		
	WPuG_SetupGrp_RaidName_Input = CreateFrame("EditBox", "WPuG_SetupGrp_RaidName_Input", WPuG_SetupGrp_DungeonList_Name_Frame, InputBoxTemplate )
	WPuG_SetupGrp_RaidName_Input:SetFont("Fonts\\FRIZQT__.TTF", 11)
	WPuG_SetupGrp_RaidName_Input:SetAutoFocus(false)
	WPuG_SetupGrp_RaidName_Input:SetWidth(77)
	WPuG_SetupGrp_RaidName_Input:SetHeight(12) -- Set these to whatever height/width is needed 
	WPuG_SetupGrp_RaidName_Input:SetPoint("Left", WPuG_SetupGrp_DungeonList_Name_Frame, "Left", 7, 0)
	WPuG_SetupGrp_RaidName_Input:SetText(WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]]["Name"])
	WPuG_SetupGrp_RaidName_Input:SetCursorPosition(0);
	WPuG_SetupGrp_RaidName_Input:SetScript("OnTextChanged",	function(self)
											WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]]["Name"] = self:GetText()
											WPuG_SetupGrp_MessageUpdate()
										end)
	WPuG_SetupGrp_RaidName_Input:SetScript("OnEnterPressed",	function(self) self:ClearFocus() 	end)
	WPuG_SetupGrp_RaidName_Input:SetScript("OnEscapePressed",	function(self) self:ClearFocus()	end)
-- Raid Name Input (end) ------------------------------------------------------------------------------------------------------	
	
	
-- Raid Delete Button (begin) ------------------------------------------------------------------------------------------------------		
	-- COME BACK TO THIS
-- Raid Delete Button (end) ------------------------------------------------------------------------------------------------------		

	
-- Different spec types (begin) ------------------------------------------------------------------------------------------------------
local WPug_SpecTypes =	
	{	
	"|cffC79C6E".."Tank", 
	"|cffF58CBA".."Heal", 
	"|cffFFF569".."Melee", 
	"|cff2459FF".."Range"
	}
	
	for i=1,4 do
		WPuG_SpecType_Button = CreateFrame("Button", "WPuG_SpecType_Button:"..i, WPuG_SetupGrp_ClassInfo_Frame, "UIPanelButtonTemplate")
		if i == 1 then
			WPuG_SpecType_Button:SetPoint("TopLeft",WPuG_SetupGrp_ClassInfo_Frame,"TopLeft",3,-3);
		else
			WPuG_SpecType_Button:SetPoint("TopLeft",_G["WPuG_SpecType_Button:"..i-1],"BottomLeft",0,2);
		end
		WPuG_SpecType_Button:SetWidth(80)
		WPuG_SpecType_Button:SetHeight(17)
		WPuG_SpecType_Button:SetText(WPug_SpecTypes[i])
		WPuG_SpecType_Button:SetScript("OnClick",	function(self) 
			_,ID = strsplit(":",self:GetName())
			ID = tonumber(ID)
			
			WPG_ChangeToSpec(ID);
		end)
	end
-- Different spec types (end) ------------------------------------------------------------------------------------------------------	

function WPG_ChangeToSpec(ID)
local NeedTypes = 
	{
	"Tanks",
	"Healers",
	"Melee",
	"Ranged"
	}
	
	for i=4,7 do
		_G["WPug_ClassSelect_CheckButton:" .. i]:Hide();
	end
	
	for i=1,#WPuG_Classes[ID] do
		_G["WPug_ClassSelect_CheckButton:" .. i]:Show();
		_G["WPug_ClassSelect_CheckButton:" .. i .. "Text"]:SetText(WPuG_Classes[ID][i]);
		_G["WPug_ClassSelect_CheckButton:" .. i]:SetChecked(WoWPuG_DB_Temp["ClassesCheckbox"][ID][i])
	end
	
	WoWPuG_DB_Temp["SpecSelected"] = ID;
	
	WPuG_SetupGrp_Need_Input:SetText(WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]][NeedTypes[WoWPuG_DB_Temp["SpecSelected"]]])
	
	WPuG_SetupGrp_MessageUpdate()
end

-- Need Input (begin) ------------------------------------------------------------------------------------------------------
	WPuG_SetupGrp_Need_InputText=WPuG_SetupGrp_ClassInfo_Frame:CreateFontString("WPuG_SetupGrp_Need_InputText","ARTWORK","GameFontNormal");
	WPuG_SetupGrp_Need_InputText:SetPoint("TopLeft",WPuG_SetupGrp_ClassInfo_Frame,"TopLeft",90,-8);
	WPuG_SetupGrp_Need_InputText:SetJustifyH("Left")
	WPuG_SetupGrp_Need_InputText:SetText("Need:")
	
	WPuG_SetupGrp_Need_Input = CreateFrame("EditBox", "WPuG_SetupGrp_Need_Input", WPuG_SetupGrp_ClassInfo_Frame, InputBoxTemplate )
	WPuG_SetupGrp_Need_Input:SetFont("Fonts\\FRIZQT__.TTF", 12)
	WPuG_SetupGrp_Need_Input:SetAutoFocus(false)
	WPuG_SetupGrp_Need_Input:SetWidth(30)
	WPuG_SetupGrp_Need_Input:SetHeight(12) -- Set these to whatever height/width is needed 
	WPuG_SetupGrp_Need_Input:SetPoint("Left", WPuG_SetupGrp_Need_InputText, "Right", 0, 0)
	
	--if WoWPuG_DB["RaidSetupSelection"]["Raid"..RaidID][i] == nil then
	--	WoWPuG_DB["RaidSetupSelection"]["Raid"..RaidID][i] = 0;
	--end
	
	--WPuG_SetupGrp_Need_Input:SetText(12)
	
	WPuG_SetupGrp_Need_Input:SetScript("OnEditFocusGained",	function(self) self:ClearFocus()	end)
	WPuG_SetupGrp_Need_Input:SetScript("OnMouseDown",	function(self,button) WPuG_SetupGrp_Need(self,button); self:ClearFocus()	end)

	function WPuG_SetupGrp_Need(self,button)
		if button == "LeftButton" then
			self:SetText(tonumber(self:GetText()) + 1)
		elseif button == "RightButton" then
			self:SetText(tonumber(self:GetText()) - 1)
		end
		
		local NeedTypes = 
			{
			"Tanks",
			"Healers",
			"Melee",
			"Ranged"
			}
		
		WoWPuG_DB["Raid"][ WoWPuG_DB["RaidSelected"] ][ NeedTypes[ WoWPuG_DB_Temp["SpecSelected"] ] ] = tonumber(self:GetText());
		
		WPuG_SetupGrp_MessageUpdate()
	end
-- Need Input (end) ------------------------------------------------------------------------------------------------------


-- Offset (begin) ------------------------------------------------------------------------------------------------------
	WPuG_SetupGrp_OffsetText=WPuG_SetupGrp_ClassInfo_Frame:CreateFontString("WPuG_SetupGrp_OffsetText","ARTWORK","GameFontNormal");
	WPuG_SetupGrp_OffsetText:SetPoint("TopLeft",WPuG_SetupGrp_ClassInfo_Frame,"TopLeft",145,-8);
	WPuG_SetupGrp_OffsetText:SetJustifyH("Left")
	WPuG_SetupGrp_OffsetText:SetText("Offset:")
	
	WPuG_SetupGrp_OffsetNumber = CreateFrame("EditBox", "WPuG_SetupGrp_OffsetNumber", WPuG_SetupGrp_ClassInfo_Frame, InputBoxTemplate )
	WPuG_SetupGrp_OffsetNumber:SetFont("Fonts\\FRIZQT__.TTF", 12)
	WPuG_SetupGrp_OffsetNumber:SetAutoFocus(false)
	WPuG_SetupGrp_OffsetNumber:SetWidth(18)
	WPuG_SetupGrp_OffsetNumber:SetHeight(12) -- Set these to whatever height/width is needed 
	WPuG_SetupGrp_OffsetNumber:SetText(0);
	WPuG_SetupGrp_OffsetNumber:SetPoint("Left", WPuG_SetupGrp_OffsetText, "Right", 0, 0)
	WPuG_SetupGrp_OffsetNumber:SetScript("OnEditFocusGained",	function(self) self:ClearFocus()	end)
	WPuG_SetupGrp_OffsetNumber:SetScript("OnMouseDown",	function(self,button) WPuG_SetupGrp_Offset(self,button); self:ClearFocus()	end)

	function WPuG_SetupGrp_Offset(self,button)
		if button == "LeftButton" then
			WPuG_SetupGrp_OffsetNumber:SetText(tonumber(WPuG_SetupGrp_OffsetNumber:GetText()) + 1)
		elseif button == "RightButton" then
			WPuG_SetupGrp_OffsetNumber:SetText(tonumber(WPuG_SetupGrp_OffsetNumber:GetText()) - 1)
		end
		
		local ID = WoWPuG_DB_Temp["SpecSelected"];
		
		WoWPuG_DB_Temp["Offset"][ID] = tonumber(WPuG_SetupGrp_OffsetNumber:GetText());
		
		WPuG_SetupGrp_MessageUpdate()
	end
-- Offset (end) ------------------------------------------------------------------------------------------------------


-- Classes Tick Boxes (begin) ------------------------------------------------------------------------------------------------------
	WPuG_Classes_Amount = { 5,5,7,7 }
	
	WPuG_Classes = {	
		{
		"|cFFFFFFFF".."Any",
		"|cFFFF7D0A".."Druid", --1
		"|cFFF58CBA".."Paladin", --2
		"|cFFC79C6E".."Warrior", --3
		"|cFFC41F3B".."D. Knight" --4
		},
		{
		"|cFFFFFFFF".."Any",
		"|cFFFF7D0A".."Druid", --1
		"|cFFF58CBA".."Paladin", --2
		"|cFF2459FF".."Shaman", --3
		"|cFFFFFFFF".."Priest" --4
		},
		{
		"|cFFFFFFFF".."Any",
		"|cFFFF7D0A".."Druid", --1
		"|cFFF58CBA".."Paladin", --2
		"|cFF2459FF".."Shaman", --3
		"|cFFC79C6E".."Warrior", --4
		"|cFFFFF569".."Rogue", --5
		"|cFFC41F3B".."D. Knight" --6
		},
		{
		"|cFFFFFFFF".."Any",
		"|cFFFF7D0A".."Druid", --1
		"|cFFABD473".."Hunter", --2
		"|cFF2459FF".."Shaman", --3
		"|cFFFFFFFF".."Priest", --4
		"|cFF69CCF0".."Mage", --5
		"|cFF9482C9".."Warlock" --6
		}
	}
	
	for i=1,7 do
		WPug_ClassSelect_CheckButton = CreateFrame("CheckButton", "WPug_ClassSelect_CheckButton:"..i, WPuG_SetupGrp_ClassInfo_Frame, "UICheckButtonTemplate");
		WPug_ClassSelect_CheckButton:SetWidth(20);
		WPug_ClassSelect_CheckButton:SetHeight(20);
		if i == 1 then
			WPug_ClassSelect_CheckButton:SetPoint("BottomLeft", WPuG_SetupGrp_ClassInfo_Frame, "BottomLeft",  200, 45);
		elseif i == 2 then
			WPug_ClassSelect_CheckButton:SetPoint("BottomLeft", WPuG_SetupGrp_ClassInfo_Frame, "BottomLeft",  90, 25);
		elseif i < 5 then
			WPug_ClassSelect_CheckButton:SetPoint("Left", _G["WPug_ClassSelect_CheckButton:" .. i-1], "Right",  35, 0);
		elseif i == 5 then
			WPug_ClassSelect_CheckButton:SetPoint("TopLeft", _G["WPug_ClassSelect_CheckButton:" .. 2], "BottomLeft",  0, 0);
		else
			WPug_ClassSelect_CheckButton:SetPoint("Left", _G["WPug_ClassSelect_CheckButton:" .. i-1], "Right",  35, 0);
		end
		_G["WPug_ClassSelect_CheckButton:" .. i .. "Text"]:SetText(WPuG_Classes[3][i]);
		
		WPug_ClassSelect_CheckButton:SetScript("OnClick", function(self)
			_,ID = strsplit(":",self:GetName())
			ID = tonumber(ID);
			
			WoWPuG_DB_Temp["ClassesCheckbox"][WoWPuG_DB_Temp["SpecSelected"]][ID] = self:GetChecked() or 0;
			
			if ID == 1 then
				if _G["WPug_ClassSelect_CheckButton:" .. 1]:GetChecked() then
					--print("check them all")
					for i=1,#WPuG_Classes[WoWPuG_DB_Temp["SpecSelected"]] do
						WoWPuG_DB_Temp["ClassesCheckbox"][WoWPuG_DB_Temp["SpecSelected"]][i] = 1;
						_G["WPug_ClassSelect_CheckButton:" .. i]:SetChecked(1);
					end
				else
					--print("uncheck them all")
					for i=1,#WPuG_Classes[WoWPuG_DB_Temp["SpecSelected"]] do
						WoWPuG_DB_Temp["ClassesCheckbox"][WoWPuG_DB_Temp["SpecSelected"]][i] = 0;
						_G["WPug_ClassSelect_CheckButton:" .. i]:SetChecked(0);
					end
				end
			else
				WoWPuG_DB_Temp["ClassesCheckbox"][WoWPuG_DB_Temp["SpecSelected"]][1] = 0;
				_G["WPug_ClassSelect_CheckButton:" .. 1]:SetChecked(0);
			end
			
			--print(self:GetChecked())
			--print(WoWPuG_DB_Temp["SpecSelected"])
			--print(ID)
			--print(WPuG_Classes[WoWPuG_DB_Temp["SpecSelected"]][ID])
			
			WPuG_SetupGrp_MessageUpdate();
		end)
	end
-- Classes Tick Boxes (end) ------------------------------------------------------------------------------------------------------


-- advertise every x seconds (begin) ------------------------------------------------------------------------------------------------------
	WPuG_AdvertiseEvery_Text=WPuG_SetupGrp_AdvertiseEvery_Frame:CreateFontString("WPuG_AdvertiseEvery_Text","ARTWORK","GameFontNormal");
	WPuG_AdvertiseEvery_Text:SetPoint("TopLeft",WPuG_SetupGrp_AdvertiseEvery_Frame,"TopLeft",10,-10);
	WPuG_AdvertiseEvery_Text:SetJustifyH("Left")
	WPuG_AdvertiseEvery_Text:SetText("Advertise every")
	WPuG_AdvertiseEvery_Text:SetFont("Fonts\\FRIZQT__.TTF", 11)
	
	WPuG_AdvertiseEvery_Text2=WPuG_SetupGrp_AdvertiseEvery_Frame:CreateFontString("WPuG_AdvertiseEvery_Text2","ARTWORK","GameFontNormal");
	WPuG_AdvertiseEvery_Text2:SetPoint("TopLeft",WPuG_SetupGrp_AdvertiseEvery_Frame,"TopLeft",26,-25);
	WPuG_AdvertiseEvery_Text2:SetJustifyH("Left")
	WPuG_AdvertiseEvery_Text2:SetText("seconds")
	WPuG_AdvertiseEvery_Text2:SetFont("Fonts\\FRIZQT__.TTF", 11)
	
	WPuG_NextUpdateIn=WPuG_SetupGrp_AdvertiseEvery_Frame:CreateFontString("WPuG_NextUpdateIn","ARTWORK","GameFontNormal");
	WPuG_NextUpdateIn:SetPoint("TopLeft",WPuG_AdvertiseEvery_Text2,"BottomLeft",-17,-7);
	WPuG_NextUpdateIn:SetJustifyH("Left")
	WPuG_NextUpdateIn:SetText("")
	
	WPuG_AdvertiseEvery_Input = CreateFrame("EditBox", "WPuG_AdvertiseEvery_Input", WPuG_SetupGrp_AdvertiseEvery_Frame, InputBoxTemplate )
	WPuG_AdvertiseEvery_Input:SetFont("Fonts\\FRIZQT__.TTF", 11)
	WPuG_AdvertiseEvery_Input:SetAutoFocus(false)
	WPuG_AdvertiseEvery_Input:SetWidth(60)
	WPuG_AdvertiseEvery_Input:SetHeight(12) -- Set these to whatever height/width is needed 
	WPuG_AdvertiseEvery_Input:SetMaxLetters(4)
	WPuG_AdvertiseEvery_Input:SetPoint("TopLeft", WPuG_AdvertiseEvery_Text, "TopLeft", 0, -14)
	WPuG_AdvertiseEvery_Input:SetText("60")
	WPuG_AdvertiseEvery_Input:SetScript("OnEditFocusGained",	function(self)
													if self:GetText() == "" then
														self:SetText("")
													end
												end)
	WPuG_AdvertiseEvery_Input:SetScript("OnEditFocusLost",	function(self)
													if self:GetText() == "" or tonumber(self:GetText()) < 10 then
														self:SetText("60")
													end
													WPuG_TimerInterval=tonumber(self:GetText())
												end)
	WPuG_AdvertiseEvery_Input:SetScript("OnTextChanged",	function(self)
											if self:GetText() ~= "" then
												if tonumber(self:GetText()) == nil then
													self:SetText(WPuG_LastInput[self])
												else
													self:SetText(tonumber(self:GetText()))
												end
											end
											WPuG_LastInput[self]=self:GetText()
										end)
	WPuG_AdvertiseEvery_Input:SetScript("OnEnterPressed",	function(self) self:ClearFocus() 	end)
	WPuG_AdvertiseEvery_Input:SetScript("OnEscapePressed",	function(self) self:ClearFocus()	end)
	WPuG_AdvertiseEvery_Input:SetNumeric(1)
	
	WPuG_AdvertiseEvery_Button = CreateFrame("Button", "WPuG_AdvertiseEvery_Button", WPuG_SetupGrp_AdvertiseEvery_Frame, "UIPanelButtonTemplate")
	WPuG_AdvertiseEvery_Button:SetPoint("BottomRight",WPuG_SetupGrp_AdvertiseEvery_Frame,"BottomRight",-10,10);
	WPuG_AdvertiseEvery_Button:SetWidth(60)
	WPuG_AdvertiseEvery_Button:SetHeight(20)
	WPuG_AdvertiseEvery_Button:SetText("Begin")
	WPuG_AdvertiseEvery_Button:SetScript("OnClick",	function(self) 
													if self:GetText() == "Begin" then
														self:SetText("Stop")
														WPuG_AutoAnnounce("Begin")
													else
														self:SetText("Begin")
														WPuG_AutoAnnounce("Stop")
													end
												end)
-- advertise every x seconds (end) ------------------------------------------------------------------------------------------------------


-- Input Message (begin) ------------------------------------------------------------------------------------------------------
	WPuG_SetupGrp_MessageBox = CreateFrame("EditBox", "WPuG_SetupGrp_MessageBox", WPuG_SetupGrp_Message_Frame, InputBoxTemplate )
	WPuG_SetupGrp_MessageBox:SetFont("Fonts\\FRIZQT__.TTF", 11)
	WPuG_SetupGrp_MessageBox:SetAutoFocus(false)
	WPuG_SetupGrp_MessageBox:SetWidth(460)
	WPuG_SetupGrp_MessageBox:SetHeight(12) -- Set these to whatever height/width is needed 
	WPuG_SetupGrp_MessageBox:SetPoint("Left", WPuG_SetupGrp_Message_Frame, "Left", 8, 0)
	
	WPuG_SetupGrp_MessageBox:SetText(WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]]["Message"])
	WPuG_SetupGrp_MessageBox:SetScript("OnEditFocusGained",	function(self)
													if self:GetText() == "Enter Message Here..." then
														self:SetText("")
													end
												end)
	WPuG_SetupGrp_MessageBox:SetScript("OnEditFocusLost",	function(self)
													if self:GetText() == "" then
														self:SetText("Enter Message Here...")
													end
												end)
	WPuG_SetupGrp_MessageBox:SetScript("OnTextChanged",	function(self)
											WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]]["Message"] = self:GetText()
											WPuG_SetupGrp_MessageUpdate()
										end)
	WPuG_SetupGrp_MessageBox:SetScript("OnEnterPressed",	function(self) self:ClearFocus() 	end)
	WPuG_SetupGrp_MessageBox:SetScript("OnEscapePressed",	function(self) self:ClearFocus()	end)
-- Input Message (end) ------------------------------------------------------------------------------------------------------


-- Test Message (begin) ------------------------------------------------------------------------------------------------------
	WPuG_SetupGrp_TestString=WPuG_SetupGrp_SampleOutput_Frame:CreateFontString("WPuG_SetupGrp_TestString","ARTWORK","GameFontNormal");
	WPuG_SetupGrp_TestString:SetPoint("TopLeft",WPuG_SetupGrp_SampleOutput_Frame,"TopLeft",8,-22);
	WPuG_SetupGrp_TestString:SetFont("Fonts\\FRIZQT__.TTF", 10)
	WPuG_SetupGrp_TestString:SetJustifyH("Left")
	WPuG_SetupGrp_TestString:SetWidth(460)
	WPuG_SetupGrp_TestString:SetText("")
	WPuG_SetupGrp_TestString:SetTextColor(1,1,1,1)
	
	WPuG_SetupGrp_UsedString=WPuG_SetupGrp_SampleOutput_Frame:CreateFontString("WPuG_SetupGrp_UsedString","ARTWORK","GameFontNormal");
	WPuG_SetupGrp_UsedString:SetPoint("TopLeft",WPuG_SetupGrp_SampleOutput_Frame,"TopLeft",15,-8);
	WPuG_SetupGrp_UsedString:SetJustifyH("Left")
	WPuG_SetupGrp_UsedString:SetFont("Fonts\\FRIZQT__.TTF", 10)
	WPuG_SetupGrp_UsedString:SetText("Used: 0/255")
-- Test Message (end) ------------------------------------------------------------------------------------------------------

-- Channel 1-6 (begin) ------------------------------------------------------------------------------------------------------
	WPuG_Channel_WhichChannel=WPuG_SetupGrp_SampleOutput_Frame:CreateFontString("WPuG_Channel_WhichChannel","ARTWORK","GameFontNormal");
	WPuG_Channel_WhichChannel:SetPoint("TopRight",WPuG_SetupGrp_SampleOutput_Frame,"TopRight",-125,-5);
	WPuG_Channel_WhichChannel:SetJustifyH("Left")
	WPuG_Channel_WhichChannel:SetText("|cffffffff" .. "Channels: ")
	
	for i=1,#WPuG_AdvertiseChannels do
		WPuG_Channel_CheckButton = CreateFrame("CheckButton", "WPuG_Channel_CheckButton:"..WPuG_AdvertiseChannels[i], WPuG_SetupGrp_SampleOutput_Frame, "UICheckButtonTemplate")
		_G["WPuG_Channel_CheckButton:"..WPuG_AdvertiseChannels[i]]:SetChecked(WoWPuG_DB["WPuG_Channel_CheckButton:"..WPuG_AdvertiseChannels[i]])
		
		WPuG_Channel_CheckButton:SetWidth(20)
		WPuG_Channel_CheckButton:SetHeight(20)
		if WPuG_AdvertiseChannels[i] == 1 then
			WPuG_Channel_CheckButton:SetPoint("Left",WPuG_Channel_WhichChannel,"Right",0,-2);
		else 
			WPuG_Channel_CheckButton:SetPoint("Left",_G["WPuG_Channel_CheckButton:".. WPuG_AdvertiseChannels[i-1]],"Right",10,0);
		end
		WPuG_Channel_CheckButton:SetScript("OnClick",function(self)
													WoWPuG_DB[self:GetName()] = self:GetChecked()
												end)	
		_G["WPuG_Channel_CheckButton:"..WPuG_AdvertiseChannels[i].."Text"]:SetText("|cffffffff" .. WPuG_AdvertiseChannels[i])
	end
-- Channel 1-6 (end) ------------------------------------------------------------------------------------------------------
	
	WPuG_DynamicRaidRoleSelector()
	WoWPuG_WhisperCatcher_FrameSetup()
	
-- Set it to spec 1
	WPG_ChangeToSpec(1)
end


-- fired when a player may have joined or left the group
function WPuG_DidSomeoneJoin(self, event, ...)

	--	print("event")
	--	print(WoWPuG_DB_Temp["HowManyPeopleWereInTheRaid"])
	
	local IsInARaid = false;
	if GetNumRaidMembers() > 0 then
		IsInARaid = true;
	end
	if IsInARaid then
		RaidNum = GetNumRaidMembers();
	else
		RaidNum = GetNumPartyMembers()+1;
	end
	
	if WoWPuG_DB_Temp["HowManyPeopleWereInTheRaid"] == nil or WoWPuG_DB_Temp["CheckRoles"] == true then
		WoWPuG_DB_Temp["CheckRoles"] = false;
		WoWPuG_DB_Temp["HowManyPeopleWereInTheRaid"] = RaidNum;
		
		Wpug_UpdateListOfFrames()
	else		
		if RaidNum ~= WoWPuG_DB_Temp["HowManyPeopleWereInTheRaid"] then
			--print(RaidNum)
			--print(WoWPuG_DB_Temp["HowManyPeopleWereInTheRaid"])
			--print("New Members Found or A player left")
			WoWPuG_DB_Temp["HowManyPeopleWereInTheRaid"] = RaidNum;
			Wpug_UpdateListOfFrames()
		end
	end

end


function WPuG_SomeoneJoinedOrLeftQue(Name, State)

	if State == "Joined" then
		WPuG_IncrementValue = 1;
	else
		WPuG_IncrementValue = -1;
	end
	
	WPuG_Phrases["JoinedOrLeft"] = "|cff22aaff%s |cffffffffhas |cffaa22aa%s|cffffffff.\nWhat spec are they?\n(Previous Spec: |cff76ff00%s|cffffffff)";
	
	WPuG_SomeoneJoinedOrLeft_Frame_Text:SetText(string.format(WPuG_Phrases["JoinedOrLeft"],Name, State,"xxx"))
	_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..1]:SetText(WPuG_Phrases["tank"])
	_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..2]:SetText(WPuG_Phrases["healer"])
	_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..3]:SetText(WPuG_Phrases["melee"])
	_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..4]:SetText(WPuG_Phrases["ranged"])
	_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..5]:SetText("Ignore")
	
	WPuG_SomeoneJoinedOrLeft_Frame:Show();
end

function WPuG_JoinOrLeftNextInQue()
	local Num = #(WPuG_JoinOrLeaveQue) - 1;
	
	WPuG_JoinOrLeaveQueTemp = WPuG_JoinOrLeaveQue;
	WPuG_JoinOrLeaveQue = {};
	
	for i=1,Num do
		WPuG_JoinOrLeaveQue[i] = WPuG_JoinOrLeaveQueTemp[i+1];
	end
	
	if #(WPuG_JoinOrLeaveQue) > 0 then
		WPuG_SomeoneJoinedOrLeftQue(WPuG_JoinOrLeaveQue[1]["Name"], WPuG_JoinOrLeaveQue[1]["State"])
	else
		WPuG_SomeoneJoinedOrLeft_Frame:Hide();
	end
end

function WPuG_SomeoneJoinedOrLeft_SetupFrame()
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


	WPuG_SomeoneJoinedOrLeft_Frame=CreateFrame("FRAME","WPuG_SomeoneJoinedOrLeft_Frame",UIParent);
	WPuG_SomeoneJoinedOrLeft_Frame:SetFrameStrata("TOOLTIP")
	WPuG_SomeoneJoinedOrLeft_Frame:SetWidth(210); 
	WPuG_SomeoneJoinedOrLeft_Frame:SetHeight(120);
	WPuG_SomeoneJoinedOrLeft_Frame:SetPoint("Center"); --",UIParent,"TOP",0, -100);
	WPuG_SomeoneJoinedOrLeft_Frame:SetBackdrop(backdrop);
	WPuG_SomeoneJoinedOrLeft_Frame:SetMovable(true);
	WPuG_SomeoneJoinedOrLeft_Frame:EnableMouse(true);
	WPuG_SomeoneJoinedOrLeft_Frame:SetScript("OnMouseDown",function()
		WPuG_SomeoneJoinedOrLeft_Frame:StartMoving();
	end)
	WPuG_SomeoneJoinedOrLeft_Frame:SetScript("OnMouseUp",function()
		WPuG_SomeoneJoinedOrLeft_Frame:StopMovingOrSizing();
	end)
	WPuG_SomeoneJoinedOrLeft_Frame:Hide();
	
	WPuG_SomeoneJoinedOrLeft_Frame_Text=WPuG_SomeoneJoinedOrLeft_Frame:CreateFontString("WPuG_SomeoneJoinedOrLeft_Frame_Text","ARTWORK","GameFontNormal");
	WPuG_SomeoneJoinedOrLeft_Frame_Text:SetPoint("Top",WPuG_SomeoneJoinedOrLeft_Frame,"Top",0,-5);
	WPuG_SomeoneJoinedOrLeft_Frame_Text:SetJustifyH("Center")
	WPuG_SomeoneJoinedOrLeft_Frame_Text:SetText("No Text Set")
	
	WPuG_SomeoneJoinedOrLeft_Bottom_Text=WPuG_SomeoneJoinedOrLeft_Frame:CreateFontString("WPuG_SomeoneJoinedOrLeft_Bottom_Text","ARTWORK","GameFontNormal");
	WPuG_SomeoneJoinedOrLeft_Bottom_Text:SetPoint("Bottom",WPuG_SomeoneJoinedOrLeft_Frame,"Bottom",0,10);
	WPuG_SomeoneJoinedOrLeft_Bottom_Text:SetJustifyH("Center");
	WPuG_SomeoneJoinedOrLeft_Bottom_Text:SetText("No Text Set");
	WPuG_SomeoneJoinedOrLeft_Frame:SetScript("OnUpdate", function()
		WPuG_SomeoneJoinedOrLeft_Bottom_Text:SetText(string.format("|cffffffffT:%d/%d  H:%d/%d  M:%d/%d  R:%d/%d", 
			_G["WPuG_SetupGrp_SpecHave:"..1]:GetValue(),_G["WPuG_SetupGrp_Need_Input:"..1]:GetText(),
			_G["WPuG_SetupGrp_SpecHave:"..2]:GetValue(),_G["WPuG_SetupGrp_Need_Input:"..2]:GetText(),
			_G["WPuG_SetupGrp_SpecHave:"..3]:GetValue(),_G["WPuG_SetupGrp_Need_Input:"..3]:GetText(),
			_G["WPuG_SetupGrp_SpecHave:"..4]:GetValue(),_G["WPuG_SetupGrp_Need_Input:"..4]:GetText()))
	end)
	
	for i=1,5 do
		WPuG_SomeoneJoinedOrLeft_FrameButton = CreateFrame("Button", "WPuG_SomeoneJoinedOrLeft_FrameButton:"..i, WPuG_SomeoneJoinedOrLeft_Frame, "UIPanelButtonTemplate")
		WPuG_SomeoneJoinedOrLeft_FrameButton:SetWidth(60)
		WPuG_SomeoneJoinedOrLeft_FrameButton:SetHeight(20)
		WPuG_SomeoneJoinedOrLeft_FrameButton:SetText("Begin")
		WPuG_SomeoneJoinedOrLeft_FrameButton:SetScript("OnClick",	function(self) 
			_,ID = strsplit(":",self:GetName())
			ID = tonumber(ID)
			
			if ID < 5 then
				local num = _G["WPuG_SetupGrp_SpecHave:"..ID]:GetValue()
				_G["WPuG_SetupGrp_SpecHave:"..ID]:SetValue(num + WPuG_IncrementValue);
				
				--print(num)
				--print(WPuG_IncrementValue)
			end
			
			WPuG_JoinOrLeftNextInQue()
			--print(ID)
		end)
	end
	
	-- Organise the positions of the buttons
	_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..1]:SetPoint("TopLeft",WPuG_SomeoneJoinedOrLeft_Frame,"TopLeft",10,-50);
	_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..2]:SetPoint("Left",_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..1],"Right",5,0);
	_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..3]:SetPoint("Top",_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..1],"Bottom",0,-5);
	_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..4]:SetPoint("Top",_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..2],"Bottom",0,-5);
	_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..5]:SetPoint("Left",_G["WPuG_SomeoneJoinedOrLeft_FrameButton:"..2],"Right",5,-12);
end

-- formats the {number} strings to {achievement} strings
function WPuG_AchiFormat(Input)
	local Output = Input;
	
	if Input ~= nil then
		if string.find(Input,"%{%d*%}") then	-- look for {number} strings
			local Str_B, Str_E = string.find(Input,"%{%d*%}")
			
			--print(Str_B)
			--print(Str_E)
			
			local Achi_ID = string.sub(Input, Str_B+1,Str_E-1)
			
			if Achi_ID == nil or Achi_ID == "" or GetAchievementLink(Achi_ID) == nil then
				Achi_Link = "["..Achi_ID.."]";
			else
				Achi_Link = GetAchievementLink(Achi_ID);
			end
			
			Output = string.sub(Input, 0,Str_B-1) .. Achi_Link .. string.sub(Input, Str_E+1)
		end
	end
	
	--print(Output)
	
	return Output;
end


function WPuG_SetupGrp_MessageUpdate()
local WPuG_ClassList = 
	{	
		{	-- 1
		WPuG_Phrases["any"],
		WPuG_Phrases["druid"], --1
		WPuG_Phrases["paladin"], --2
		WPuG_Phrases["warrior"], --3
		WPuG_Phrases["deathknight"] --4
		},
		{	-- 2
		WPuG_Phrases["any"],
		WPuG_Phrases["druid"], --1
		WPuG_Phrases["paladin"], --2
		WPuG_Phrases["shaman"], --3
		WPuG_Phrases["priest"] --4
		},
		{	-- 3
		WPuG_Phrases["any"],
		WPuG_Phrases["druid"], --1
		WPuG_Phrases["paladin"], --2
		WPuG_Phrases["shaman"], --3
		WPuG_Phrases["warrior"], --4
		WPuG_Phrases["rogue"], --5
		WPuG_Phrases["deathknight"] --6
		},
		{	-- 4
		WPuG_Phrases["any"],
		WPuG_Phrases["druid"], --1
		WPuG_Phrases["hunter"], --2
		WPuG_Phrases["shaman"], --3
		WPuG_Phrases["priest"], --4
		WPuG_Phrases["mage"], --5
		WPuG_Phrases["warlock"] --6
		}
	}
	
	
	
	if WPuG_SetupGrp_SelectRaid_Dropdown then
		if WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]]["Name"] == nil then
			WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]]["Name"] = ">Name not found<"
		end
		local name = WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]]["Name"];
		if #name > 12 then
			name = string.sub(name, 0, 11) .. "..";
		end
		_G["WPuG_SetupGrp_SelectRaid_Dropdown".."Text"]:SetText(name);
		
		WPuG_SetupGrp_RaidName_Input:SetText(WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]]["Name"])
		WPuG_SetupGrp_OffsetNumber:SetText(WoWPuG_DB_Temp["Offset"][WoWPuG_DB_Temp["SpecSelected"]])
		
		--WoWPuG_DB_Temp["Offset"][ID] = tonumber(WPuG_SetupGrp_OffsetNumber:GetText());
		
		for i = 1,4 do
			_G["WPuG_SpecType_Button:"..i]:SetNormalTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Up-Grey");
			_G["WPuG_SpecType_Button:"..i]:SetPushedTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Down-Grey");
		end
		
		_G["WPuG_SpecType_Button:"..WoWPuG_DB_Temp["SpecSelected"]]:SetNormalTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Up-Blue");
		_G["WPuG_SpecType_Button:"..WoWPuG_DB_Temp["SpecSelected"]]:SetPushedTexture("interface\\addons\\WoWPuG\\Images\\UI-Panel-Button-Down-Blue");
	end


local Spec = 	
	{
	WPuG_Phrases["tank"],
	WPuG_Phrases["healer"],
	WPuG_Phrases["melee"],
	WPuG_Phrases["ranged"]
	}
	
local WPug_SpecTypes =	
	{	
	"|cffC79C6E".."Tank", 
	"|cffF58CBA".."Heal", 
	"|cffFFF569".."Melee", 
	"|cff2459FF".."Range"
	}

OP_string = WPuG_Phrases["lfm"] .. " "

--WoWPuG_DB["KjutExtra"] = true;
if  WoWPuG_DB["KjutExtra"] ~= nil and WoWPuG_DB["KjutExtra"] == 1 then	--KjutExtra == true then
	local Total = 0;
	
	for i=1,4 do
		local NeedTypes = 
			{
			"Tanks",
			"Healers",
			"Melee",
			"Ranged"
			}
			
		local Max = WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]][NeedTypes[i]];
		local Have = WoWPuG_DB_Temp["ClassesHave"][i] + WoWPuG_DB_Temp["Offset"][i];
		
		if tonumber(Max) == nil then
			Max = 0;
		end
		
		if tonumber(Have) == nil then
			Have = 0;
		end
		
		Need = Max - Have;
		
		if Need < 0 then
			Need = 0;
		end
		
		Total = Total + Need;
	end
	
	OP_string = "{star}{star}LF" .. Total .. "M "
end




	place = WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]]["Name"]
	
	--print(i)
	--print(place)
	
	place = WPuG_AchiFormat(place)
	
	OP_string = OP_string .. place
	
	OP_string = OP_string .. " - " .. WPuG_Phrases["need"] .. " "
	
	local FirstTime = true;	-- make it so that you dont use excessive commas
	
	for i=1,4 do
		local NeedTypes = 
			{
			"Tanks",
			"Healers",
			"Melee",
			"Ranged"
			}
			
		local Max = WoWPuG_DB["Raid"][WoWPuG_DB["RaidSelected"]][NeedTypes[i]];
		local Have = WoWPuG_DB_Temp["ClassesHave"][i] + WoWPuG_DB_Temp["Offset"][i];
		
		if tonumber(Max) == nil then
			Max = 0;
		end
		
		if tonumber(Have) == nil then
			Have = 0;
		end
		
		Need = Max - Have;
		
		local color = "";
		
		if Need > 0 then
			color = "|cFFFFFFFF"
		elseif Need < 0 then
			color = "|cFFFF2233"
		else
			color = "|cFF44FF44"
		end
		
		if Need < 0 then
			Need = 0;
		end
		
		if WPuG_SpecType_Button then
			_G["WPuG_SpecType_Button:"..i]:SetText(WPug_SpecTypes[i] .. " " .. color .. Have .. "/" .. Max)
		end
		
		--	WoWPuG_DB_Temp["ClassesCheckbox"][1-4][1-6]	-- the different types and classes (tank, healer... and warr, pally...)
		
		if Need > 0 then
			if FirstTime == false then
				OP_string = OP_string .. ", ";
			else
				FirstTime = false;
			end
			
			OP_string = OP_string .. Need .. " " .. Spec[i]	--	7 Tanks, 4 Healers ..
			
			local HasFoundClass = false;
			local AnyClass = false;
			
			for j=1,#WoWPuG_DB_Temp["ClassesCheckbox"][i] do
				if WoWPuG_DB_Temp["ClassesCheckbox"][i][1] == 1 then
					if j == 1 then
						OP_string = OP_string .. " (" .. WPuG_ClassList[i][1] .. ")"
					end
				else
					if WoWPuG_DB_Temp["ClassesCheckbox"][i][j] == 1 then
						if HasFoundClass == false then
							OP_string = OP_string .. " (" 
						else
							OP_string = OP_string .. ", " 
						end
						
						HasFoundClass = true;
						
						class = WPuG_ClassList[i][j];
						
						OP_string = OP_string .. class
					end
				end
			end
			
			if HasFoundClass == true then	
				OP_string = OP_string .. ")"
			end
		end
	end	
	
	if WPuG_SetupGrp_MessageBox:GetText() ~= "Enter Message Here..." then
		OP_string = OP_string .. " - " .. WPuG_AchiFormat(WPuG_SetupGrp_MessageBox:GetText())
	end
	
	WPuG_SetupGrp_TestString:SetText("|cffffffff" .. OP_string)
	
	OP_string	= string.gsub(OP_string, "|cFFFFFFFF", "")	--remove the coloring formatting
	StringUsed = strlen(OP_string)
	if StringUsed < 256 then
		StringUsed_Col = "ffffff"
	else
		StringUsed_Col = "ff0000"
	end
	WPuG_SetupGrp_UsedString:SetText("Used: |cff" .. StringUsed_Col ..StringUsed.."/255")
	
	WPuG_SendChatMessage = OP_string.."{star}{star}"
	
	--print(strlen(OP_string))
	
	--SendChatMessage(OP_string)	
	--if WPuG_AlternateMessage_SampleMessage then
	--	WPuG_SetupGrp_AlternateMessageUpdate()
	--end
end

function WPuG_AutoAnnounce(State)
	if WPuG_AutoAnnounceFrame == nil then
		WPuG_AutoAnnounceFrame=CreateFrame("FRAME","WPuG_AutoAnnounceFrame",UIParent);
	end

	if State == "Begin" then
		WPuG_TimerInterval=tonumber(WPuG_AdvertiseEvery_Input:GetText())
		WPuG_AutoAnnounceFrame:SetScript("OnUpdate",function()
														timepassed = time()-WpuG_LastAdvertiseTime
														
														if timepassed >= WPuG_TimerInterval then
															--print(WPuG_SendChatMessage);
															WpuG_LastAdvertiseTime = time()
															for i=1,#WPuG_AdvertiseChannels do
																if _G["WPuG_Channel_CheckButton:"..WPuG_AdvertiseChannels[i]]:GetChecked() then
																	WPuG_MessageOutput(WPuG_AdvertiseChannels[i])
																end
															end
														end
														
														--print(time()-WpuG_LastAdvertiseTime)
														
														local timeleft = WPuG_TimerInterval-timepassed
														
														WPuG_NextUpdateIn:SetText("|cFFFFFFFF("..timeleft..")")
														--print(WPuG_TimerInterval)
													end)
	elseif State == "Stop" then
		WPuG_NextUpdateIn:SetText("")
		WPuG_AutoAnnounceFrame:SetScript("OnUpdate",function()
														-- do nothing
													end)
	end
end


function WPuG_SomeoneJoinedOrLeft(Name, State)	
	ID = #(WPuG_JoinOrLeaveQue) + 1
	
	WPuG_JoinOrLeaveQue[ID] = {};
	WPuG_JoinOrLeaveQue[ID]["Name"] = Name;
	WPuG_JoinOrLeaveQue[ID]["State"] = State;
	
	if #(WPuG_JoinOrLeaveQue) == 1 then
		WPuG_SomeoneJoinedOrLeftQue(Name, State)
	else
		print(Name .. ": Added to que at id " .. #(WPuG_JoinOrLeaveQue));
	end
	--[[
	for i=1,#(WPuG_JoinOrLeaveQue) do
		if string.find(str_lower, WPuG_JoinOrLeaveQue[i]) then
			--str_start,str_end = string.find(str_lower, WOWPuG_LFMOtherRaids[i])
			InstanceName = "Other";
		end
	end
	]]
end