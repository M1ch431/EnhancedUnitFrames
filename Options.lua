-- Creates the options panel.

eufOptions = CreateFrame("Frame", "eufOptionsPanel", UIParent)
eufOptions.scaling = CreateFrame("Frame", "eufOptionsPanelScaling", eufOptions)
eufOptions.name = "EnhancedUnitFrames"
eufOptions.scaling.name = "Frame Scaling"
eufOptions.scaling.parent = eufOptions.name

InterfaceOptions_AddCategory(eufOptions)
InterfaceOptions_AddCategory(eufOptions.scaling)
eufOptions:Hide()
eufOptions.scaling:Hide()

-- Static ReloadUI popup.

StaticPopupDialogs["RELOAD_UI"] = {
	text = "One or more of the changes you have made require a ReloadUI.",
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function()
		ReloadUI()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 3,
}

-- Checkbox creation function.

local i = 0

local function createCheckbox(parent, label, description)
	i = i + 1
	local checkbox = CreateFrame("CheckButton", "eufCheckbox" .. i, parent, "InterfaceOptionsCheckButtonTemplate")
	checkbox.label = _G[checkbox:GetName() .. "Text"]

	checkbox.label:SetText(label)
	checkbox.tooltipText = label
	checkbox.tooltipRequirement = description

	return checkbox
end

-- Source: rothUI by zork.
-- Slider creation functions.

local floor = floor
local i = 0

local function round(number, decimals)
	local multiplier = 10^(decimals or 0)

	return math.floor(number * multiplier + 0.5) / multiplier
end

local createSlider = function(parent, title, minVal, maxVal, valStep, label, description)
	i = i + 1
	local slider = CreateFrame("Slider", "eufSlider" .. i, parent, "OptionsSliderTemplate")
	local editbox = CreateFrame("Editbox", "$parentEditbox", slider, "InputBoxTemplate")
	slider.text = _G[slider:GetName() .. "Text"]
	slider.textLow = _G[slider:GetName() .. "Low"]
	slider.textHigh = _G[slider:GetName() .. "High"]
	slider.tooltipText = label
	slider.tooltipRequirement = description

	slider:SetMinMaxValues(minVal, maxVal)
	slider:SetValue(minVal)
	slider:SetValueStep(valStep)
	slider:SetWidth(175)
	slider.text:SetText(title)
	slider.text:SetFontObject(GameFontNormal)
	slider.textLow:SetText(minVal)
	slider.textHigh:SetText(maxVal)
	editbox:SetSize(29, 30)
	editbox:ClearAllPoints()
	editbox:SetPoint("TOP", slider, "BOTTOM", 0, -5)
	editbox:SetText(slider:GetValue())
	editbox:SetAutoFocus(false)

	slider:HookScript("OnMouseUp", function(self, value)
		StaticPopup_Show("RELOAD_UI")
	end)

	slider:SetScript("OnValueChanged", function(self, value)
		self.editbox:SetText(floor(value))
	end)

	editbox:SetScript("OnEnterPressed", function(self)
		local value = self:GetText()

		if tonumber(value) then
			self:GetParent():SetValue(floor(value))
			self:ClearFocus()
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	slider.editbox = editbox

	return slider
end

local createScaleSlider = function(parent, title, minVal, maxVal, valStep, label, description)
	i = i + 1
	local slider = CreateFrame("Slider", "eufScaleSlider" .. i, parent, "OptionsSliderTemplate")
	local editbox = CreateFrame("Editbox", "$parentEditbox", slider, "InputBoxTemplate")
	slider.text = _G[slider:GetName() .. "Text"]
	slider.textLow = _G[slider:GetName() .. "Low"]
	slider.textHigh = _G[slider:GetName() .. "High"]
	slider.tooltipText = label
	slider.tooltipRequirement = description

	slider:SetMinMaxValues(minVal, maxVal)
	slider:SetValue(minVal)
	slider:SetValueStep(valStep)
	slider:SetWidth(175)
	slider.text:SetText(title)
	slider.text:SetFontObject(GameFontNormal)
	slider.textLow:SetText(minVal)
	slider.textHigh:SetText(maxVal)
	editbox:SetSize(30, 30)
	editbox:ClearAllPoints()
	editbox:SetPoint("TOP", slider, "BOTTOM", 0, -5)
	editbox:SetText(slider:GetValue())
	editbox:SetAutoFocus(false)

	slider:SetScript("OnValueChanged", function(self, value)
		self.editbox:SetText(round(value, 2))
	end)

	editbox:SetScript("OnEnterPressed", function(self)
		local value = self:GetText()

		if tonumber(value) then
			self:GetParent():SetValue(round(value, 2))
			self:ClearFocus()
		end
	end)

	slider.editbox = editbox

	return slider
end

-- Draws the option panel elements.

eufOptions:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates checkboxes.

	local bigPlayerHealthBar = createCheckbox(self, "Big Player Health Bar", "Makes the health bar bigger using unimplemented textures made by Blizzard, hidden in the game files.")
	local bigTargetHealthBar = createCheckbox(self, "Big Target Health Bar", "Makes the health bar bigger using unimplemented textures made by Blizzard, hidden in the game files.")

	if isClassic() then
		wideTargetFrame = createCheckbox(self, "Wide Target Frame", "Makes the target frame wider.\nSource: Wide Target by Gello.")
	else
		wideTargetFrame = createCheckbox(self, "Wide Target Frame", "Makes the target and focus frames wider.\nSource: Wide Target by Gello.")
	end

	local mirroredPositioning = createCheckbox(self, "Mirrored Positioning", "Allows the easy mirrored positioning of the player and target frames.\n1. Right-click the player frame.\n2. Hover over \"Move Frame\".\n3. Select \"Unlock Frame\" to begin.\nSource: Focused by haggen.")
	local classHealthBarColor = createCheckbox(self, "Class Color HP", "Changes the unit frame health bar colors to the unit's class color.")
	local reactionHealthBarColor = createCheckbox(self, "Reaction Color HP", "Changes the unit frame health bar colors to the unit's reaction color.")
	local upperCaseAbbreviation = createCheckbox(self, "Uppercase Abbreviation", "Changes whether long status text numbers are abbreviated with a capital letter at the end or not.")
	local classIconPortraits = createCheckbox(self, "Class Icon Portraits", "Changes the unit frame portraits to the unit's class icon.")
	local hideHitIndicators = createCheckbox(self, "Hide Hit Indicators", "Hides the damage/healing spam on player and pet frames.")
	local hidePetStatusText = createCheckbox(self, "Hide Pet Status Text", "Hides the pet frame status bar text.")
	local hideRestingIcon = createCheckbox(self, "Hide Resting Icon", "Hides the resting icon on the player frame.")

	if isClassic() then
		shamanClassColorFix = createCheckbox(self, "Shaman Class Color Fix", "Changes the Shaman class color to reflect live.")
	else
		predictedHealth = createCheckbox(self, "Show Predicted Health", "Shows an animation when you lose health.")
		showBuilderFeedback = createCheckbox(self, "Show Builder Feedback", "Shows an animation when you build your class resource.")
		showSpenderFeedback = createCheckbox(self, "Show Spender Feedback", "Shows an animation when you spend your class resource.")
		threatShowNumeric = createCheckbox(self, "Show Numeric Threat", "Shows a numerical target threat indicator on the player frame.\nRequires \"Threat Warning\" to be enabled to display.")
	end

	-- Positions the checkboxes created.

	bigPlayerHealthBar:SetPoint("TOPLEFT", description, "BOTTOMLEFT", -2, -7)
	bigTargetHealthBar:SetPoint("TOPLEFT", bigPlayerHealthBar, "BOTTOMLEFT", 0, -8)
	wideTargetFrame:SetPoint("TOPLEFT", bigTargetHealthBar, "BOTTOMLEFT", 0, -8)
	mirroredPositioning:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -8)
	classHealthBarColor:SetPoint("TOPLEFT", mirroredPositioning, "BOTTOMLEFT", 0, -8)
	reactionHealthBarColor:SetPoint("TOPLEFT", classHealthBarColor, "BOTTOMLEFT", 0, -8)
	upperCaseAbbreviation:SetPoint("TOPLEFT", reactionHealthBarColor, "BOTTOMLEFT", 0, -8)
	classIconPortraits:SetPoint("TOPLEFT", upperCaseAbbreviation, "BOTTOMLEFT", 0, -8)
	hideHitIndicators:SetPoint("TOPLEFT", classIconPortraits, "BOTTOMLEFT", 0, -8)
	hidePetStatusText:SetPoint("TOPLEFT", hideHitIndicators, "BOTTOMLEFT", 0, -8)
	hideRestingIcon:SetPoint("TOPLEFT", hidePetStatusText, "BOTTOMLEFT", 0, -8)

	if isClassic() then
		shamanClassColorFix:SetPoint("TOPLEFT", hideRestingIcon, "BOTTOMLEFT", 0, -8)
	else
		predictedHealth:SetPoint("TOPLEFT", hideRestingIcon, "BOTTOMLEFT", 0, -8)
		showBuilderFeedback:SetPoint("TOPLEFT", predictedHealth, "BOTTOMLEFT", 0, -8)
		showSpenderFeedback:SetPoint("TOPLEFT", showBuilderFeedback, "BOTTOMLEFT", 0, -8)
		threatShowNumeric:SetPoint("TOPLEFT", showSpenderFeedback, "BOTTOMLEFT", 0, -8)
	end

	-- Applies scripts when the checkboxes are clicked.

	bigPlayerHealthBar:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.bigPlayerHealthBar = true
			PlaySound(856)
		else
			cfg.bigPlayerHealthBar = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	bigTargetHealthBar:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.bigTargetHealthBar = true
			PlaySound(856)
		else
			cfg.bigTargetHealthBar = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	wideTargetFrame:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.wideTargetFrame = true
			PlaySound(856)
		else
			cfg.wideTargetFrame = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	mirroredPositioning:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.mirroredPositioning = true
			PlaySound(856)
		else
			cfg.mirroredPositioning = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classHealthBarColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.classHealthBarColor = true
			PlaySound(856)
		else
			cfg.classHealthBarColor = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	reactionHealthBarColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.reactionHealthBarColor = true
			PlaySound(856)
		else
			cfg.reactionHealthBarColor = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	upperCaseAbbreviation:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.upperCaseAbbreviation = true
			PlaySound(856)
		else
			cfg.upperCaseAbbreviation = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classIconPortraits:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.classIconPortraits = true
			PlaySound(856)
		else
			cfg.classIconPortraits = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideHitIndicators:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.hideHitIndicators = true
			PlaySound(856)
		else
			cfg.hideHitIndicators = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hidePetStatusText:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.hidePetStatusText = true
			PlaySound(856)
		else
			cfg.hidePetStatusText = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideRestingIcon:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.hideRestingIcon = true
			PlaySound(856)
		else
			cfg.hideRestingIcon = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	if isClassic() then
		shamanClassColorFix:SetScript("OnClick", function(self)
			if self:GetChecked() then
				cfg.shamanClassColorFix = true
				PlaySound(856)
			else
				cfg.shamanClassColorFix = false
				PlaySound(857)
			end

			StaticPopup_Show("RELOAD_UI")
		end)
	else
		predictedHealth:SetScript("OnClick", function(self)
			if self:GetChecked() then
				C_CVar.SetCVar("predictedHealth", 1)
				PlaySound(856)
			else
				C_CVar.SetCVar("predictedHealth", 0)
				PlaySound(857)
			end
		end)

		showBuilderFeedback:SetScript("OnClick", function(self)
			if self:GetChecked() then
				C_CVar.SetCVar("showBuilderFeedback", 1)
				PlaySound(856)
			else
				C_CVar.SetCVar("showBuilderFeedback", 0)
				PlaySound(857)
			end
		end)

		showSpenderFeedback:SetScript("OnClick", function(self)
			if self:GetChecked() then
				C_CVar.SetCVar("showSpenderFeedback", 1)
				PlaySound(856)
			else
				C_CVar.SetCVar("showSpenderFeedback", 0)
				PlaySound(857)
			end
		end)

		threatShowNumeric:SetScript("OnClick", function(self)
			if self:GetChecked() then
				C_CVar.SetCVar("threatShowNumeric", 1)
				PlaySound(856)
			else
				C_CVar.SetCVar("threatShowNumeric", 0)
				PlaySound(857)
			end
		end)

	end

	-- Player frame texture dropdown menu.

	local playerFrameDropdown = CreateFrame("Frame", "eufPlayerFrameDropdown", self, "UIDropDownMenuTemplate")
	playerFrameDropdown.title = playerFrameDropdown:CreateFontString("PlayerFrameDropdownLabel", "ARTWORK", "GameFontNormal")

	playerFrameDropdown:SetPoint("TOPLEFT", bigPlayerHealthBar, "BOTTOMLEFT", 273, 8)
	playerFrameDropdown.title:SetPoint("BOTTOMLEFT", playerFrameDropdown, "TOPLEFT", 15, 3)
	playerFrameDropdown.title:SetText("Player Frame Texure")

	playerFrameDropdown:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -17, 1)
		GameTooltip:SetText("Player Frame Texture", nil, nil, nil, 1, true)
		GameTooltip:AddLine("Changes the player frame to use the default, elite, rare, or rare-elite texture.", 1, 1, 1, 1)
		GameTooltip:Show()
	end)

	playerFrameDropdown:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	UIDropDownMenu_SetWidth(playerFrameDropdown, 160)

	if cfg.elitePlayerFrame == true then
		isChecked1 = "Elite Player Frame"
		isCheckedElite = true
	elseif cfg.rarePlayerFrame == true then
		isChecked1 = "Rare Player Frame"
		isCheckedRare = true
	elseif cfg.rareElitePlayerFrame == true then
		isChecked1 = "Rare Elite Player Frame"
		isCheckedRareElite = true
	else
		isChecked1 = "Default Player Frame"
		isCheckedDefault = true
	end

	UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)

	local function PlayerFrameTextureDropdown_OnClick(self, arg1)
		if arg1 == 1 then
			cfg.elitePlayerFrame = false
			cfg.rarePlayerFrame = false
			cfg.rareElitePlayerFrame = false
			isChecked1 = "Default Player Frame"
			isCheckedDefault = true
			isCheckedElite = false
			isCheckedRare = false
			isCheckedRareElite = false

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)
		elseif arg1 == 2 then
			cfg.elitePlayerFrame = true
			cfg.rarePlayerFrame = false
			cfg.rareElitePlayerFrame = false
			isChecked1 = "Elite Player Frame"
			isCheckedDefault = false
			isCheckedElite = true
			isCheckedRare = false
			isCheckedRareElite = false

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)
		elseif arg1 == 3 then
			cfg.elitePlayerFrame = false
			cfg.rarePlayerFrame = true
			cfg.rareElitePlayerFrame = false
			isChecked1 = "Rare Player Frame"
			isCheckedDefault = false
			isCheckedElite = false
			isCheckedRare = true
			isCheckedRareElite = false

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)
		elseif arg1 == 4 then
			cfg.elitePlayerFrame = false
			cfg.rarePlayerFrame = false
			cfg.rareElitePlayerFrame = true
			isChecked1 = "Rare Elite Player Frame"
			isCheckedDefault = false
			isCheckedElite = false
			isCheckedRare = false
			isCheckedRareElite = true

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)
		end
	end

	local function PlayerFrameTextureDropdown_Menu(frame, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = PlayerFrameTextureDropdown_OnClick

		info.text, info.arg1, info.checked = "Default Player Frame", 1, isCheckedDefault
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Elite Player Frame", 2, isCheckedElite
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Rare Player Frame", 3, isCheckedRare
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Rare Elite Player Frame", 4, isCheckedRareElite
		UIDropDownMenu_AddButton(info)
	end

	UIDropDownMenu_Initialize(playerFrameDropdown, PlayerFrameTextureDropdown_Menu)

	-- Threat warning dropdown menu.

	if not isClassic() then
		threatWarningDropdown = CreateFrame("Frame", "eufThreatWarningDropdown", self, "UIDropDownMenuTemplate")
		threatWarningDropdown.title = threatWarningDropdown:CreateFontString("ThreatWarningDropdownLabel", "ARTWORK", "GameFontNormal")

		threatWarningDropdown:SetPoint("TOPLEFT", playerFrameDropdown, "BOTTOMLEFT", 0, -37)
		threatWarningDropdown.title:SetPoint("BOTTOMLEFT", threatWarningDropdown, "TOPLEFT", 15, 3)
		threatWarningDropdown.title:SetText("Threat Warning")

		threatWarningDropdown:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -17, 1)
			GameTooltip:SetText("Threat Warning", nil, nil, nil, 1, true)
			GameTooltip:AddLine("Displays a red glow around the unit frames if you have threat.", 1, 1, 1, 1)
			GameTooltip:Show()
		end)

		threatWarningDropdown:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)

		UIDropDownMenu_SetWidth(threatWarningDropdown, 160)

		if C_CVar.GetCVar("threatWarning") == "0" then
			isChecked2 = "Off"
			isCheckedOff = true
		elseif C_CVar.GetCVar("threatWarning") == "1" then
			isChecked2 = "In Dungeons"
			isCheckedInDungeons = true
		elseif C_CVar.GetCVar("threatWarning") == "2" then
			isChecked2 = "In Party/Raid"
			isCheckedPartyRaid = true
		elseif C_CVar.GetCVar("threatWarning") == "3" then
			isChecked2 = "Always"
			isCheckedAlways = true
		end

		UIDropDownMenu_SetText(threatWarningDropdown, isChecked2)

		local function ThreatWarningDropdown_OnClick(self, arg1)
			if arg1 == 1 then
				C_CVar.SetCVar("threatWarning", 0)
				isChecked2 = "Off"
				isCheckedOff = true
				isCheckedInDungeons = false
				isCheckedPartyRaid = false
				isCheckedAlways = false

				UIDropDownMenu_SetText(threatWarningDropdown, isChecked2)
			elseif arg1 == 2 then
				C_CVar.SetCVar("threatWarning", 1)
				isChecked2 = "In Dungeons"
				isCheckedOff = false
				isCheckedInDungeons = true
				isCheckedPartyRaid = false
				isCheckedAlways = false

				UIDropDownMenu_SetText(threatWarningDropdown, isChecked2)
			elseif arg1 == 3 then
				C_CVar.SetCVar("threatWarning", 2)
				isChecked2 = "In Party/Raid"
				isCheckedOff = false
				isCheckedInDungeons = false
				isCheckedPartyRaid = true
				isCheckedAlways = false

				UIDropDownMenu_SetText(threatWarningDropdown, isChecked2)
			elseif arg1 == 4 then
				C_CVar.SetCVar("threatWarning", 3)
				isChecked2 = "Always"
				isCheckedOff = false
				isCheckedInDungeons = false
				isCheckedPartyRaid = false
				isCheckedAlways = true

				UIDropDownMenu_SetText(threatWarningDropdown, isChecked2)
			end
		end

		local function ThreatWarningDropdown_Menu(frame, level, menuList)
			local info = UIDropDownMenu_CreateInfo()
			info.func = ThreatWarningDropdown_OnClick

			info.text, info.arg1, info.checked = "Off", 1, isCheckedOff
			UIDropDownMenu_AddButton(info)
			info.text, info.arg1, info.checked = "In Dungeons", 2, isCheckedInDungeons
			UIDropDownMenu_AddButton(info)
			info.text, info.arg1, info.checked = "In Party/Raid", 3, isCheckedPartyRaid
			UIDropDownMenu_AddButton(info)
			info.text, info.arg1, info.checked = "Always", 4, isCheckedAlways
			UIDropDownMenu_AddButton(info)
		end

		UIDropDownMenu_Initialize(threatWarningDropdown, ThreatWarningDropdown_Menu)
	end

	-- Creates the target frame width slider.

	if isClassic() then
		wideTargetFrame = createSlider(self, "Target Width", 231, 400, 1, "Wide Target Frame Width", "Changes the target frame width.\nRequires \"Wide Target Frame\" to be checked for changes to take effect.")
		wideTargetFrame:SetPoint("TOPLEFT", playerFrameDropdown, "BOTTOMLEFT", 18, -34)
	else
		wideTargetFrame = createSlider(self, "Target Width", 231, 400, 1, "Wide Target Frame Width", "Changes the target and focus frames width.\nRequires \"Wide Target Frame\" to be checked for changes to take effect.")
		wideTargetFrame:SetPoint("TOPLEFT", threatWarningDropdown, "BOTTOMLEFT", 18, -34)
	end

	eufSlider1:SetValue(cfg.wideTargetFrameWidth)
	eufSlider1Editbox:SetText(cfg.wideTargetFrameWidth)

	wideTargetFrame:HookScript("OnValueChanged", function(self, value)
		value = floor(value)
		cfg.wideTargetFrameWidth = value
	end)

	if isClassic() then
		-- Creates the aura icon size slider.

		auraIconSize = createSlider(self, "Aura Size", 17, 30, 1, "Aura Icon Size", "Changes the aura icon size on the target frame.")

		auraIconSize:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -70)
		eufSlider2:SetValue(cfg.largeAuraIconSize)
		eufSlider2Editbox:SetText(cfg.largeAuraIconSize)

		auraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)
			cfg.largeAuraIconSize = value
		end)
	else
		-- Creates the large aura icon size slider.

		largeAuraIconSize = createSlider(self, "Large Aura", 17, 30, 1, "Large Aura Icon Size", "Changes the large aura icon size on the target and focus frames.")

		largeAuraIconSize:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -70)
		eufSlider2:SetValue(cfg.largeAuraIconSize)
		eufSlider2Editbox:SetText(cfg.largeAuraIconSize)

		largeAuraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)
			cfg.largeAuraIconSize = value
		end)

		-- Creates the small aura icon size slider.

		smallAuraIconSize = createSlider(self, "Small Aura", 17, 30, 1, "Small Aura Icon Size", "Changes the small aura icon size on the target and focus frames.")

		smallAuraIconSize:SetPoint("TOPLEFT", largeAuraIconSize, "BOTTOMLEFT", 0, -70)
		eufSlider3:SetValue(cfg.smallAuraIconSize)
		eufSlider3Editbox:SetText(cfg.smallAuraIconSize)

		smallAuraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)
			cfg.smallAuraIconSize = value
		end)
	end

	-- Initializes the options panel with saved variables.

	if cfg.bigPlayerHealthBar == true then
		eufCheckbox1:SetChecked(true)
	end

	if cfg.bigTargetHealthBar == true then
		eufCheckbox2:SetChecked(true)
	end

	if cfg.wideTargetFrame == true then
		eufCheckbox3:SetChecked(true)
	end

	if cfg.mirroredPositioning == true then
		eufCheckbox4:SetChecked(true)
	end

	if cfg.classHealthBarColor == true then
		eufCheckbox5:SetChecked(true)
	end

	if cfg.reactionHealthBarColor == true then
		eufCheckbox6:SetChecked(true)
	end

	if cfg.upperCaseAbbreviation == true then
		eufCheckbox7:SetChecked(true)
	end

	if cfg.classIconPortraits == true then
		eufCheckbox8:SetChecked(true)
	end

	if cfg.hideHitIndicators == true then
		eufCheckbox9:SetChecked(true)
	end

	if cfg.hidePetStatusText == true then
		eufCheckbox10:SetChecked(true)
	end

	if cfg.hideRestingIcon == true then
		eufCheckbox11:SetChecked(true)
	end

	if isClassic() then
		if cfg.shamanClassColorFix == true then
			eufCheckbox12:SetChecked(true)
		end
	else
		if C_CVar.GetCVar("predictedHealth") == "1" then
			eufCheckbox12:SetChecked(true)
		end

		if C_CVar.GetCVar("showBuilderFeedback") == "1" then
			eufCheckbox13:SetChecked(true)
		end

		if C_CVar.GetCVar("showSpenderFeedback") == "1" then
			eufCheckbox14:SetChecked(true)
		end

		if C_CVar.GetCVar("threatShowNumeric") == "1" then
			eufCheckbox15:SetChecked(true)
		end
	end

	self:SetScript("OnShow", nil)
end)

-- Draws the scaling option panel elements.

eufOptions.scaling:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates the player frame scale slider.

	local playerFrameScale = createScaleSlider(self, "Player Scale", 1, 1.5, 0.01, "Player Frame Scale", "Changes the scale of the player frame.")

	playerFrameScale:SetPoint("TOPLEFT", description, "BOTTOMLEFT", 1, -21)

	playerFrameScale:HookScript("OnValueChanged", function(self, value)
		PlayerFrame:SetScale(round(value, 2))
	end)

	self:SetScript("OnShow", nil)

	-- Creates the target frame scale slider.

	local targetFrameScale = createScaleSlider(self, "Target Scale", 1, 1.5, 0.01, "Target Frame Scale", "Changes the scale of the target frame.")

	targetFrameScale:SetPoint("TOPLEFT", playerFrameScale, "BOTTOMLEFT", 0, -70)

	targetFrameScale:HookScript("OnValueChanged", function(self, value)
		TargetFrame:SetScale(round(value, 2))
	end)

	self:SetScript("OnShow", nil)
end)