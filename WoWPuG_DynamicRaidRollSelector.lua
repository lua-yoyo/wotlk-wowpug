
WPug_ListOfClasses = 
	{
	"|cFFFF7D0A".."Druid", --1
	"|cFFF58CBA".."Paladin", --2
	"|cFF2459FF".."Shaman", --3
	"|cFFC79C6E".."Warrior", --4
	"|cFFFFF569".."Rogue", --5
	"|cFFC41F3B".."Death Knight", --6
	"|cFFABD473".."Hunter", --7
	"|cFFFFFFFF".."Priest", --8
	"|cFF69CCF0".."Mage", --9
	"|cFF9482C9".."Warlock" --10
	}
	
WPug_ListOfClasses = 
	{
	"Druid", --1
	"Paladin", --2
	"Shaman", --3
	"Warrior", --4
	"Rogue", --5
	"Death Knight", --6
	"Hunter", --7
	"Priest", --8
	"Mage", --9
	"Warlock" --10
	}

WPug_ClassList = 
	{
	"DRUID", --1
	"PALADIN", --2
	"SHAMAN", --3
	"WARRIOR", --4
	"ROGUE", --5
	"DEATHKNIGHT", --6
	"HUNTER", --7
	"PRIEST", --8
	"MAGE", --9
	"WARLOCK" --10
	}
	
	

function WPuG_DynamicRaidRoleSelector()
	WPuG_DynamicRaidRoleUpdateFrame = CreateFrame("Frame");
	WPuG_DynamicRaidRoleUpdateFrame:Hide()
	WPuG_DynamicRaidRoleUpdateFrame:SetScript("OnUpdate", function()
		if WoWPuG_DB_Temp["DynamicRaidRoleUpdateTime"] == nil or WoWPuG_DB_Temp["DynamicRaidRoleUpdateTime"] < time() then
			WoWPuG_DB_Temp["DynamicRaidRoleUpdateTime"] = time()+2;
		end
		
		if WoWPuG_DB_Temp["DynamicRaidRoleUpdateTime"] == time() then
			WPuG_DynamicRaidRoleUpdateFrame:Hide()
			--print("Updating Raid");
			Wpug_UpdateListOfFrames();
		end
	end)
	
	WPuG_RoleChangedEventFrame=CreateFrame("FRAME");
	WPuG_RoleChangedEventFrame:RegisterEvent("PLAYER_ROLES_ASSIGNED");
	WPuG_RoleChangedEventFrame:SetScript("OnEvent", function() 

		WoWPuG_DB_Temp["CheckRoles"] = true; 

		WPuG_DynamicRaidRoleUpdateFrame:Show()
		WoWPuG_DB_Temp["DynamicRaidRoleUpdateTime"] = time()+2;
	end);


	local backdrop = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",  -- path to the background texture
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",  -- path to the border texture
		tile = false,    -- true to repeat the background texture to fill the frame, false to scale it
		tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
		edgeSize = 9,  -- thickness of edge segments and square size of edge corners (in pixels)
		insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
			left = 2,
			right = 2,
			top = 2,
			bottom = 2
		}
	}

	local backdrop2 = {
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",  -- path to the background texture
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",  -- path to the border texture
		tile = false,    -- true to repeat the background texture to fill the frame, false to scale it
		tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
		edgeSize = 9,  -- thickness of edge segments and square size of edge corners (in pixels)
		insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
			left = 1,
			right = 1,
			top = 1,
			bottom = 1
		}
	}

-- WPuG_SetupGrp_Group_Frame
WPug_DifferentTypes = 
	{
	"Unassigned",
	WPuG_Phrases["tank"], 
	WPuG_Phrases["healer"], 
	WPuG_Phrases["melee"], 
	WPuG_Phrases["ranged"]
	}

local Amounts = { 12, 4, 7, 12, 12 }
	for i=1,5 do
		WPug_DifferentTypes_Frame=CreateFrame("FRAME","WPug_DifferentTypes_Frame:"..i,WPuG_SetupGrp_Group_Frame);
		WPug_DifferentTypes_Frame:SetWidth(115); 
		
		if i == 2 then
			_G["WPug_DifferentTypes_Frame:" .. 2]:SetHeight(65);
		elseif i ==3 then
			WPug_DifferentTypes_Frame:SetHeight(105);
		else
			WPug_DifferentTypes_Frame:SetHeight(180);
		end
		
		WPug_DifferentTypes_Frame:SetBackdrop(backdrop)
		
		WPug_DifferentTypes_Frame_Text=WPug_DifferentTypes_Frame:CreateFontString("WPug_DifferentTypes_Frame_Text","ARTWORK","GameFontNormal");
		WPug_DifferentTypes_Frame_Text:SetPoint("TopLeft",WPug_DifferentTypes_Frame,"TopLeft",0,9);
		WPug_DifferentTypes_Frame_Text:SetJustifyH("Left");
		WPug_DifferentTypes_Frame_Text:SetText(WPug_DifferentTypes[i]);
		WPug_DifferentTypes_Frame_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
	end
	
	WPug_DifferentTypes_Frame:GetFrameStrata() 
	
-- Create the 40 frames needed for 40 people
	for i=1,40 do	
		WPug_DifferentTypes_Individual_Frame=CreateFrame("FRAME","WPug_DifferentTypes_Individual_Frame:" .. i,WPug_DifferentTypes_Frame);
		WPug_DifferentTypes_Individual_Frame:SetWidth(110); 
		WPug_DifferentTypes_Individual_Frame:SetHeight(13);
		WPug_DifferentTypes_Individual_Frame:SetFrameStrata("DIALOG")
		WPug_DifferentTypes_Individual_Frame:SetBackdrop(backdrop2)
		WPug_DifferentTypes_Individual_Frame:SetPoint("Top","WPug_DifferentTypes_Frame:" .. 1,"Top",0,0);
		WPug_DifferentTypes_Individual_Frame:Hide();
		
	--	WPug_DifferentTypes_Individual_Frame:SetPoint("Top","WPug_DifferentTypes_Frame:" .. 1,"Top",0,(-6+14) - (14*i));
		
		WPug_DifferentTypes_Individual_Frame_Text=WPug_DifferentTypes_Individual_Frame:CreateFontString("WPug_DifferentTypes_Individual_Frame:"..i.."_Text","ARTWORK","GameFontNormal");
		WPug_DifferentTypes_Individual_Frame_Text:SetPoint("Center",WPug_DifferentTypes_Individual_Frame,"Center",0,1);
		WPug_DifferentTypes_Individual_Frame_Text:SetJustifyH("Left");
		WPug_DifferentTypes_Individual_Frame_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
		
	-- The icon on the left hand side
		WPug_DifferentTypes_Individual_Frame_Icon = WPug_DifferentTypes_Individual_Frame:CreateTexture("WPug_DifferentTypes_Individual_Frame:"..i.."_Icon")
		WPug_DifferentTypes_Individual_Frame_Icon:SetPoint("Left", WPug_DifferentTypes_Individual_Frame, "Left")
		WPug_DifferentTypes_Individual_Frame_Icon:SetWidth(14); 
		WPug_DifferentTypes_Individual_Frame_Icon:SetHeight(14);
		WPug_DifferentTypes_Individual_Frame_Icon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
		WPug_DifferentTypes_Individual_Frame_Icon:SetTexCoord(0, 	0, 	0, 	0);
		
	-- This allows the frame to be moved
		WPug_DifferentTypes_Individual_Frame:SetMovable(true)
		WPug_DifferentTypes_Individual_Frame:EnableMouse(true)
		WPug_DifferentTypes_Individual_Frame:SetScript("OnMouseDown",function(self)
			self:StartMoving()
		end)
		WPug_DifferentTypes_Individual_Frame:SetScript("OnMouseUp",function(self)
			self:StopMovingOrSizing()
			
			Wpug_WhichFrameAmICloseTo(self)
		end)
	end
	
	_G["WPug_DifferentTypes_Frame:" .. 1]:SetPoint("TOPLEFT",WPuG_SetupGrp_Group_Frame,"TOPLEFT",7, -15);
	_G["WPug_DifferentTypes_Frame:" .. 2]:SetPoint("TOPLEFT",_G["WPug_DifferentTypes_Frame:" .. 1],"TopRight",0, 0);
	_G["WPug_DifferentTypes_Frame:" .. 3]:SetPoint("TOPLEFT",_G["WPug_DifferentTypes_Frame:" .. 2],"BottomLeft",0, -10);
	_G["WPug_DifferentTypes_Frame:" .. 4]:SetPoint("TOPLEFT",_G["WPug_DifferentTypes_Frame:" .. 2],"TopRight",0, 0);
	_G["WPug_DifferentTypes_Frame:" .. 5]:SetPoint("TOPLEFT",_G["WPug_DifferentTypes_Frame:" .. 4],"TopRight",0, 0);
	
	Wpug_UpdateListOfFrames();
end

function Wpug_WhichFrameAmICloseTo(self)
	local x,y = self:GetCenter()
	
	x = floor(x);
	y = floor(y);
	
	
	--print(x .. " " .. y)
	
	local RightWindow = 1;
	for i=1,5 do
		local x1 = _G["WPug_DifferentTypes_Frame:"..i]:GetLeft()
		local x2 = _G["WPug_DifferentTypes_Frame:"..i]:GetRight()
		
		local y1 = _G["WPug_DifferentTypes_Frame:"..i]:GetTop()
		local y2 = _G["WPug_DifferentTypes_Frame:"..i]:GetBottom()
		
		x1 = floor(x1);
		x2 = floor(x2);
		y1 = floor(y1);
		y2 = floor(y2);
		
		if x > x1 then
			if x < x2 then
				if y < y1 then
					if y > y2 then
						RightWindow = i;
					end
				end
			end
		end
		
		--print(x1 .. " " .. x2 .. " " .. y1 .. " " .. y2)
	end
	
	--print(RightWindow)
	--print(self:GetName())
	--print(_G[self:GetName().."_Text"]:GetText())
	
	Name = _G[self:GetName().."_Text"]:GetText()
	
	WoWPuG_DB["CharacterInfo"][Name]["Group"] = RightWindow;
	
	Wpug_UpdateListOfFrames()
end


function Wpug_UpdateListOfFrames()

	--WoWPuG_DB["CharacterInfo"] = {};
	
	Wpug_PopulateUpdateList();

	local Amount = {0,0,0,0,0};
	
	WoWPuG_DB_Temp["ClassesHave"] = {0,0,0,0};
	
	for i=1,40 do
		_G["WPug_DifferentTypes_Individual_Frame:" .. i]:Hide();	-- hide all the character frames
	end
	
	for i=1,#WoWPuG_DB_Temp["ListOfNames"] do 
		local Name = WoWPuG_DB_Temp["ListOfNames"][i];
		
		--print(WoWPuG_DB["CharacterInfo"])
		
		--WoWPuG_DB_Temp["ListOfNames"][1]
		
		--print(WoWPuG_DB["CharacterInfo"][Name]["Group"])
		
		local Group = WoWPuG_DB["CharacterInfo"][Name]["Group"];
		local Class = WoWPuG_DB["CharacterInfo"][Name]["Class"];
		local Role = WoWPuG_DB["CharacterInfo"][Name]["Role"];
		
		if Name == nil then Name =	"nil" end
		if Group == nil then Group = "nil" end
		if Class == nil then Class = "nil" end
		if Role == nil then Role = "nil" end
		
	--	print("Debug 2126: " .. Name .. " - " .. Group .. " - " .. Class .. " - " .. Role)
		
		if Class == nil or Class == "nil" then
			WoWPuG_DB_Temp["HowManyPeopleWereInTheRaid"] = WoWPuG_DB_Temp["HowManyPeopleWereInTheRaid"] - 1;
			WPuG_DynamicRaidRoleUpdateFrame:Show()
		end
		
		if Class ~= nil and Class ~= "nil" then
		
			r = RAID_CLASS_COLORS[Class]["r"];
			g = RAID_CLASS_COLORS[Class]["g"];
			b = RAID_CLASS_COLORS[Class]["b"];
			
			_G["WPug_DifferentTypes_Individual_Frame:" .. i]:Show();
			_G["WPug_DifferentTypes_Individual_Frame:"..i.."_Text"]:SetText(Name);
		--	_G["WPug_DifferentTypes_Individual_Frame:"..i.."_Icon"]:SetTexCoord();
			
			_G["WPug_DifferentTypes_Individual_Frame:" .. i]:SetBackdropColor(		r,	g,	b,	1);
			_G["WPug_DifferentTypes_Individual_Frame:"..i.."_Text"]:SetTextColor(	r, 	g,	b,	1);
			
			Amount[Group] = Amount[Group] + 1;
			
			if Group > 1 then
				WoWPuG_DB_Temp["ClassesHave"][Group-1] = WoWPuG_DB_Temp["ClassesHave"][Group-1] + 1;
			end
			
			_G["WPug_DifferentTypes_Individual_Frame:" .. i]:ClearAllPoints()
			_G["WPug_DifferentTypes_Individual_Frame:" .. i]:SetPoint("Top",_G["WPug_DifferentTypes_Frame:"..Group],"Top",0,8-(14*Amount[Group]))
			
			
			if Role == "TANK" then
				_G["WPug_DifferentTypes_Individual_Frame:" .. i .. "_Icon"]:SetTexCoord(00/64, 	19/64, 	21/64, 	41/64);	-- tank
			elseif Role == "HEALER" then
				_G["WPug_DifferentTypes_Individual_Frame:" .. i .. "_Icon"]:SetTexCoord(20/64, 	39/64, 	00/64, 	20/64);	-- healer
			elseif Role == "DAMAGER" then
				_G["WPug_DifferentTypes_Individual_Frame:" .. i .. "_Icon"]:SetTexCoord(20/64, 	39/64, 	21/64, 	41/64);	-- dps
			else
				_G["WPug_DifferentTypes_Individual_Frame:" .. i .. "_Icon"]:SetTexCoord(0,0,0,0);	-- NONE
			end
			
			--_G["WPug_DifferentTypes_Individual_Frame:"..1.."_Icon"]:SetHeight(20);
			
			if Group == 1 then
				if Amount[Group] > 12 then
					_G["WPug_DifferentTypes_Individual_Frame:" .. i]:Hide();
				end
			end
		end
	end
	
	WPuG_SetupGrp_MessageUpdate();
end


function WPuG_SetupGrp_ImageCreate()	
	WPug_DifferentSpecType=CreateFrame("FRAME","WPug_DifferentSpecType",UIParent);
	WPug_DifferentSpecType:SetWidth(100); 
	WPug_DifferentSpecType:SetHeight(100);
	WPug_DifferentSpecType:SetPoint("Center");
	
	WPug_DifferentSpecType.texture = WPug_DifferentSpecType:CreateTexture()
	WPug_DifferentSpecType.texture:SetPoint(WPug_DifferentSpecType)
	WPug_DifferentSpecType:SetWidth(100); 
	WPug_DifferentSpecType:SetHeight(100);
	WPug_DifferentSpecType.texture:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
	WPug_DifferentSpecType.texture:SetTexCoord(00/64, 	19/64, 	00/64, 	20/64);
	WPug_DifferentSpecType.texture:SetTexCoord(00/64, 	19/64, 	21/64, 	41/64);	-- tank
	WPug_DifferentSpecType.texture:SetTexCoord(20/64, 	39/64, 	00/64, 	20/64);	-- healer
	WPug_DifferentSpecType.texture:SetTexCoord(20/64, 	39/64, 	21/64, 	41/64);	-- dps
	
	WPug_DifferentSpecTypePositions =
	{	-- tank
		{
		00/64,
		19/64,
		21/64,
		41/64
		}
	},
	{	-- healer
		{
		20/64,
		39/64,
		00/64,
		20/64
		}
	},
	{	-- dps
		{
		20/64,
		39/64,
		21/64,
		41/64
		}
	}
end

--WPuG_SetupGrp_ImageCreate();


function Wpug_PopulateUpdateList()
	if WoWPuG_DB["CharacterInfo"] == nil then
		WoWPuG_DB["CharacterInfo"] = {}
	end
	
	local TempCharInfo = {};
	
	wipe(WoWPuG_DB_Temp["ListOfNames"]);
	WoWPuG_DB_Temp["ListOfNames"] = nil;
	WoWPuG_DB_Temp["ListOfNames"] = {};
	
	
--	Get a list of all the characters in the raid	
--	for i=1,#WPug_DebugDB do	-- This will be NumRaidMembers()
--		local Name = WPug_DebugDB[i]["Name"];	--  these will be actual info
--		local Class = WPug_DebugDB[i]["Class"];	--  these will be actual info
	
	local IsInARaid = false;
	local RaidNum = 0;
--	Get a list of all the characters in the raid	
	if GetNumRaidMembers() > 0 then
		IsInARaid = true;
	end
	if IsInARaid then
		RaidNum = GetNumRaidMembers();
		RaidNum = 40;
	else
		RaidNum = GetNumPartyMembers()+1;
	end
	
	local index = 0;
	
	for i=1,RaidNum do
		if IsInARaid then
			Name, _, subgroup, _, _, Class, _, online, _, role, _ = GetRaidRosterInfo(i);
			role = UnitGroupRolesAssigned("Raid"..i)
		else
			if i == 1 then
				Name = UnitName("player");
				_, Class = UnitClass("player");
				role = UnitGroupRolesAssigned("player")
			else
				Name = UnitName("party" .. i-1);
				_, Class = UnitClass("party" .. i-1);
				role = UnitGroupRolesAssigned("party" .. i-1)
			end
		end
		
		if Name ~= nil then
			if role == nil then role = "NONE" end
		--	print("Debug 4177: " .. Name .. " - " .. Class .. " - " .. role)
			
			index = index + 1;
			
			WoWPuG_DB_Temp["ListOfNames"][index] = Name;
			
			if WoWPuG_DB["CharacterInfo"][Name] == nil then	-- if no data exists then create some data (should clear data for a person when they join)
				TempCharInfo[Name] = {}
				TempCharInfo[Name]["Group"] = 1;
				TempCharInfo[Name]["Class"] = Class;
				TempCharInfo[Name]["Role"] = role;
			else
				TempCharInfo[Name] = {}
				TempCharInfo[Name]["Group"] = WoWPuG_DB["CharacterInfo"][Name]["Group"];
				TempCharInfo[Name]["Class"] = WoWPuG_DB["CharacterInfo"][Name]["Class"];
				TempCharInfo[Name]["Role"] = role;
			end
		end
	end
	
	WoWPuG_DB["CharacterInfo"] = TempCharInfo;
end


function Wpug_Debugging_PopulateUpdateList()
WPug_DebugDB = {}
	for i=1,10 do
		local ran = random(10)
		
		WPug_DebugDB[i] = {}
		
		WPug_DebugDB[i]["Name"] = WPug_ListOfClasses[ran]..i;
		WPug_DebugDB[i]["Class"] = WPug_ClassList[ran];
	end
end