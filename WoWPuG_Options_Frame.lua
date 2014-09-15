function WPuG_Options_FrameSetup()

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
	
	--------------------SCALE SLIDER BAR----------DOESNT WORK, I MAY COME BACK TO THIS---------------------
--	 WPuG_ScaleBar = CreateFrame("Slider", "WPuG_ScaleBar", WPuG_OptionsTab, "OptionsSliderTemplate")
--	 WPuG_ScaleBar:SetWidth(150)
--	 WPuG_ScaleBar:SetHeight(10)
--	 WPuG_ScaleBar:SetPoint("TopLeft",WPuG_OptionsTab,"TopLeft", 20, -230)
--	 WPuG_ScaleBar:SetOrientation('Horizontal')
--	 
--	 _G[WPuG_ScaleBar:GetName() .. 'Low']:SetText('50%');
--	 _G[WPuG_ScaleBar:GetName() .. 'High']:SetText('150%'); 
--	 _G[WPuG_ScaleBar:GetName() .. 'Text']:SetText('');
--	 
--	 WPuG_ScaleBar:SetMinMaxValues(50, 150)
--	 WPuG_ScaleBar:SetValueStep(1)
--	 if WoWPuG_DB["Scale"] == nil then
--		WoWPuG_DB["Scale"] = 100;
--	 end
--	
--	 WPuG_ScaleBar:SetValue(WoWPuG_DB["Scale"]);
--	 WPuG_MainFrame:SetScale(WoWPuG_DB["Scale"]/100);
--	 
--	  WPuG_ScaleBar:SetScript("OnValueChanged",function(self)
--		local Scale = self:GetValue();
--		if Scale ~= 50 and Scale ~= 150 then	-- weird bug where it calls the function2x and the 2nd time it calls it it is 50
--			WoWPuG_DB["Scale"] = Scale;
--			print("___*")
--			print(self:GetValue())
--			print(Scale)
--			WPuG_MainFrame:SetScale(WoWPuG_DB["Scale"]/100);	
--		end
--	  end)
	----------------------------------------------------
	
	
	KjutExtra = CreateFrame("CheckButton", "KjutExtra", WPuG_OptionsTab, "UICheckButtonTemplate")
	KjutExtra:SetChecked(WoWPuG_DB["KjutExtra"])
	KjutExtra:SetWidth(20)
	KjutExtra:SetHeight(20)
	KjutExtra:SetPoint("TopLeft",WPuG_OptionsTab,"TopLeft",12,-200);
	KjutExtra:SetScript("OnClick",function(self)
										WoWPuG_DB[self:GetName()] = self:GetChecked()
										WPuG_SetupGrp_MessageUpdate();
									end)	
	_G["KjutExtra".."Text"]:SetText("|cffffffff" .. "Use LF{x}M Format")
	
	WoWPuG_DB["WPuG_WhisperTrackerCheckbox"] = WoWPuG_DB["WPuG_WhisperTrackerCheckbox"] or 1;
	
	WPuG_WhisperTrackerCheckbox = CreateFrame("CheckButton", "WPuG_WhisperTrackerCheckbox", WPuG_OptionsTab, "UICheckButtonTemplate")
	WPuG_WhisperTrackerCheckbox:SetChecked(WoWPuG_DB["WPuG_WhisperTrackerCheckbox"])
	WPuG_WhisperTrackerCheckbox:SetWidth(20)
	WPuG_WhisperTrackerCheckbox:SetHeight(20)
	WPuG_WhisperTrackerCheckbox:SetPoint("TopLeft",WPuG_OptionsTab,"TopLeft",12,-220);
	WPuG_WhisperTrackerCheckbox:SetScript("OnClick",function(self)
										WoWPuG_DB[self:GetName()] = self:GetChecked()
										WPuG_Update_WhisperCatcher();
									end)	
	_G["WPuG_WhisperTrackerCheckbox".."Text"]:SetText("|cffffffff" .. "Use Whisper tracker")
	
	
	
	

--	WPuG_AlternateMessage_SampleFrame=CreateFrame("FRAME","WPuG_AlternateMessage_SampleFrame",WPuG_OptionsTab);
--	WPuG_AlternateMessage_SampleFrame:SetWidth(WPuG_OptionsTab:GetWidth()-20); 
--	WPuG_AlternateMessage_SampleFrame:SetHeight(125);
--	WPuG_AlternateMessage_SampleFrame:SetPoint("BottomRight",WPuG_OptionsTab,"BottomRight",-10, 10);
--	WPuG_AlternateMessage_SampleFrame:SetBackdrop(backdrop);
--	
--	WPuG_AlternateMessage = CreateFrame("CheckButton", "WPuG_AlternateMessage", WPuG_AlternateMessage_SampleFrame, "UICheckButtonTemplate")
--	WPuG_AlternateMessage:SetChecked(WoWPuG_DB["WPuG_AlternateMessage"])
--	WPuG_AlternateMessage:SetWidth(20)
--	WPuG_AlternateMessage:SetHeight(20)
--	WPuG_AlternateMessage:SetPoint("TopLeft",WPuG_AlternateMessage_SampleFrame,"TopLeft",10,-5);
--	WPuG_AlternateMessage:SetScript("OnClick",function(self)
--										WoWPuG_DB[self:GetName()] = self:GetChecked()
--									end)	
--	_G["WPuG_AlternateMessage".."Text"]:SetText("|cffffffff" .. "Use Alternate Message Format")
--	
--	WPuG_AlternateMessage_SampleMessage=WPuG_AlternateMessage_SampleFrame:CreateFontString("WPuG_AlternateMessage_SampleMessage","ARTWORK","GameFontNormal");
--	WPuG_AlternateMessage_SampleMessage:SetPoint("TopLeft",WPuG_AlternateMessage_SampleFrame,"TopLeft",10,-20);
--	WPuG_AlternateMessage_SampleMessage:SetWidth(WPuG_AlternateMessage_SampleFrame:GetWidth()-20)
--	WPuG_AlternateMessage_SampleMessage:SetJustifyH("Left");
--	WPuG_AlternateMessage_SampleMessage:SetTextColor(1,1,1,1)
--	WPuG_AlternateMessage_SampleMessage:SetText("================" .. "\n" .. 
--												"LFM {Raid Instance}" .. "\n" ..
--												"{x} Tanks {Classes}" .. "\n" ..
--												"{x} Healers {Classes}" .. "\n" ..
--												"{x} Melee {Classes}" .. "\n" ..
--												"{x} Ranged {Classes}" .. "\n" ..
--												"{Custom Message}" .. "\n" ..
--												"================"
--												);
--
--	WPuG_SetupGrp_AlternateMessageUpdate()
	
	WPuG_SetupLocaleOptionsTab()
end

function WPuG_SetupLocaleOptionsTab()
	WPuG_LocaleTabButton = CreateFrame("Button", "WPuG_LocaleTabButton", WPuG_OptionsTab, "UIPanelButtonTemplate");
	WPuG_LocaleTabButton:SetPoint("TopRight",WPuG_OptionsTab,"TopRight",-10,-30);
	WPuG_LocaleTabButton:SetWidth(100);
	WPuG_LocaleTabButton:SetHeight(25);
	WPuG_LocaleTabButton:SetText("Setup Phrases");
	WPuG_LocaleTabButton:SetScript("OnClick", 	function()
													print("Type |cff2fff7f/wpg|r for more information on how to setup phrases")
												end)
end
