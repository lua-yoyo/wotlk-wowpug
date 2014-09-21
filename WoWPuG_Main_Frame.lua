WPuG_LastInput = {}


function WPuG_MainFrameSetup()
	--WPuG_TempTime = time();
	
	WPuG_MainFrame=CreateFrame("FRAME","WPuG_MainFrame",UIParent);
	--WPuG_MainFrame=CreateFrame("FRAME","WPuG_MainFrame",RaidFrame);
	
	WPuG_MainFrame:SetPoint("TopLeft",RaidInfoFrame,"TopLeft",0,15)
	
	--WPuG_MainFrame:SetPoint("CENTER");
	--WPuG_MainFrame:SetMovable(true)
	WPuG_MainFrame:EnableMouse(true)
	--WPuG_MainFrame:SetScript("OnMouseDown",function()
	--  WPuG_MainFrame:StartMoving()
	--end)
	--WPuG_MainFrame:SetScript("OnMouseUp",function()
	--  WPuG_MainFrame:StopMovingOrSizing()
	--end)

	--WPuG_MainFrame:Show()	-- debugging, remove later
	WPuG_MainFrame:Hide()
	
	WPuG_MainFrame:SetWidth(500)
	WPuG_MainFrame:SetHeight(400)
    WPuG_MainFrame:SetScale(0.9)
	WPuG_MainFrame:SetFrameStrata("High")
	
	
	local backdrop = {
           bgFile="Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
           edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",
	  
	  tile = false,    -- true to repeat the background texture to fill the frame, false to scale it
	  tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
	  edgeSize = 30,  -- thickness of edge segments and square size of edge corners (in pixels)
	  insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
	    left = 4,
	    right = 4,
	    top = 4,
	    bottom = 4
	  }
	}
	
	local Titlebackdrop = {
           bgFile="Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
           edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",
	  
	  tile = false,    -- true to repeat the background texture to fill the frame, false to scale it
	  tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
	  edgeSize = 20,  -- thickness of edge segments and square size of edge corners (in pixels)
	  insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
	    left = 2,
	    right = 2,
	    top = 2,
	    bottom = 2
	  }
	}
	
	WPuG_MainFrame:SetBackdrop(backdrop)
	
	WPuG_TitleFrame=CreateFrame("FRAME","WPuG_TitleFrame",WPuG_MainFrame);
	WPuG_TitleFrame:SetWidth(200)
	WPuG_TitleFrame:SetHeight(30)
	WPuG_TitleFrame:SetPoint("CENTER",WPuG_MainFrame,"Top",0,-5);
	WPuG_TitleFrame:SetBackdrop(Titlebackdrop)
	
-- This allows the frame to be moved
	WPuG_MainFrame:SetMovable(true)
	WPuG_TitleFrame:EnableMouse(true)
	WPuG_TitleFrame:SetScript("OnMouseDown",function()
		WPuG_MainFrame:StartMoving()
	end)
	WPuG_TitleFrame:SetScript("OnMouseUp",function()
		WPuG_MainFrame:StopMovingOrSizing()
	end)
	
	WPuG_Name_TitleFrame=WPuG_TitleFrame:CreateFontString("WPuG_Name_TitleFrame","ARTWORK","GameFontNormal");
	WPuG_Name_TitleFrame:SetPoint("Center",WPuG_TitleFrame,"Center");
	WPuG_Name_TitleFrame:SetText("WoW PuG Builder")
	
	WPuG_ShowHideButton = CreateFrame("Button", "WPuG_ShowHideButton:", RaidFrame, "UIPanelButtonTemplate")
	WPuG_ShowHideButton:SetPoint("TopRight",RaidFrame,"TopRight",-150,-13);
	WPuG_ShowHideButton:SetWidth(80)
	WPuG_ShowHideButton:SetHeight(RaidFrameRaidInfoButton:GetHeight())
	
	--RaidFrameConvertToRaidButton:SetWidth(100);
	--RaidFrameRaidInfoButton:SetPoint("TopLeft",WPuG_ShowHideButton,"TopRight",0,0);
	
	WPuG_ShowHideButton:SetText("WoWPuG")
	WPuG_ShowHideButton:SetScript("OnClick",	function() 
													if WPuG_MainFrame:IsShown() then
														WPuG_MainFrame:Hide()
													else
														WPuG_MainFrame:Show()
													end
												end)
	
	for i=1,3 do	-- FOUR TABS
		WPuG_MainFrameTab=CreateFrame("Button","WPuG_MainFrameTab"..i,WPuG_MainFrame,"CharacterFrameTabButtonTemplate");
		WPuG_MainFrameTab:SetID(i)
		
		WPuG_MainFrameTab:SetText("No Text Set")
		
		if i==1 then
			WPuG_MainFrameTab:SetPoint("TOPLEFT",WPuG_MainFrame,"BOTTOMLEFT",0,5);
		else
			WPuG_MainFrameTab:SetPoint("TOPLEFT","WPuG_MainFrameTab"..i-1,"TOPRIGHT",-15,0);
		end
		
		WPuG_MainFrameTab:SetScript("OnClick",function(self) 	PanelTemplates_SetTab(WPuG_MainFrame, self:GetID()); WPuG_UpdateFrames(self:GetID())	end)
		
		PanelTemplates_TabResize(WPuG_MainFrameTab, 0, 100);
	end
	
	--_G["WPuG_MainFrameTab"..1]:SetText("My Stats")
	--_G["WPuG_MainFrameTab"..1]:SetText("Setup Grp")
	_G["WPuG_MainFrameTab"..1]:SetText("Setup Grp")	-- FOUR TABS
	_G["WPuG_MainFrameTab"..2]:SetText("LFG List")
	_G["WPuG_MainFrameTab"..3]:SetText("Options")
	
	PanelTemplates_SetNumTabs(WPuG_MainFrame, 3)	-- FOUR TABS
	PanelTemplates_SetTab(WPuG_MainFrame, 1);
	
	

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
	
----------------------------------------------------MyStats TAB
	
	--WPuG_MyStatsTab=CreateFrame("FRAME","WPuG_MyStatsTab",WPuG_MainFrame);
	--WPuG_MyStatsTab:SetWidth(WPuG_MainFrame:GetWidth()); 
	--WPuG_MyStatsTab:SetHeight(WPuG_MainFrame:GetHeight());
	--WPuG_MyStatsTab:SetPoint("CENTER",WPuG_MainFrame);

	
	--WPuG_MyStats_FrameSetup()
	
----------------------------------------------------SetupGrp TAB
	
	--WPuG_SetupGrpTab=CreateFrame("FRAME","WPuG_SetupGrpTab",WPuG_MainFrame);
	--WPuG_SetupGrpTab:SetWidth(WPuG_MainFrame:GetWidth()); 
	--WPuG_SetupGrpTab:SetHeight(WPuG_MainFrame:GetHeight());
	--WPuG_SetupGrpTab:SetPoint("CENTER",WPuG_MainFrame);
	
	--WPuG_SetupGrp_FrameSetup()
	
----------------------------------------------------SetupGrp2 TAB (The new one)
	
	WPuG_SetupGrpTab2=CreateFrame("FRAME","WPuG_SetupGrpTab2",WPuG_MainFrame);
	WPuG_SetupGrpTab2:SetWidth(WPuG_MainFrame:GetWidth()); 
	WPuG_SetupGrpTab2:SetHeight(WPuG_MainFrame:GetHeight());
	WPuG_SetupGrpTab2:SetPoint("CENTER",WPuG_MainFrame);
	WPuG_SetupGrpTab2:SetScript("OnShow", WPuG_Update_WhisperCatcher);
	
	WPuG_SetupGrp2_FrameSetup()
	
----------------------------------------------------LFGList TAB
	WPuG_LFGListTab=CreateFrame("FRAME","WPuG_LFGListTab",WPuG_MainFrame);
	WPuG_LFGListTab:SetWidth(WPuG_MainFrame:GetWidth()); 
	WPuG_LFGListTab:SetHeight(WPuG_MainFrame:GetHeight());
	WPuG_LFGListTab:SetPoint("CENTER",WPuG_MainFrame);
	
	WPuG_LFGList_FrameSetup()
	
----------------------------------------------------Options TAB
	
	WPuG_OptionsTab=CreateFrame("FRAME","WPuG_OptionsTab",WPuG_MainFrame);
	WPuG_OptionsTab:SetWidth(WPuG_MainFrame:GetWidth()); 
	WPuG_OptionsTab:SetHeight(WPuG_MainFrame:GetHeight());
	WPuG_OptionsTab:SetPoint("CENTER",WPuG_MainFrame);
	
	WPuG_Options_FrameSetup()
	
----------------------------------------------------Gear window
	--WPuG_GearWindow_FrameSetup()
	
-----------------------CLOSE BUTTON
	WPuG_Close_Button = CreateFrame("Button", "WPuG_Close_Button", WPuG_MainFrame, "UIPanelCloseButton")
	WPuG_Close_Button:SetWidth(30)
	WPuG_Close_Button:SetHeight(30)
	WPuG_Close_Button:SetPoint("TOPRIGHT", WPuG_MainFrame, "TOPRIGHT", -5, -5)
	
	WPuG_UpdateFrames(1)
end

Max_wid = 200

function WPuG_UpdateFrames(WPuG_TabID)

	--WPuG_SetupGrpTab:Hide()
	WPuG_SetupGrpTab2:Hide()	-- FOUR TABS
	WPuG_LFGListTab:Hide()
	WPuG_OptionsTab:Hide()

	--if WPuG_TabID == 1 then	WPuG_SetupGrpTab:Show() end
	if WPuG_TabID == 1 then	WPuG_SetupGrpTab2:Show() end	-- FOUR TABS
	if WPuG_TabID == 2 then	WPuG_LFGListTab:Show() end
	if WPuG_TabID == 3 then	WPuG_OptionsTab:Show() end
end 