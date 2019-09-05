﻿euf = {}
cfg = {}

function eufSetDefaults()
	if cfg.bigPlayerHealthBars == nil then
		cfg.bigPlayerHealthBars = false
	end

	if cfg.bigTargetHealthBars == nil then
		cfg.bigTargetHealthBars = false
	end

	if cfg.classHealthBarColor == nil then
		cfg.classHealthBarColor = true
	end

	if cfg.classIconPortraits == nil then
		cfg.classIconPortraits = false
	end

	if cfg.elitePlayerFrame == nil then
		cfg.elitePlayerFrame = false
	end

	if cfg.hideHitIndicators == nil then
		cfg.hideHitIndicators = false
	end

	if cfg.hidePetStatusText == nil then
		cfg.hidePetStatusText = true
	end

	if cfg.hideRestingIcon == nil then
		cfg.hideRestingIcon = true
	end

	if cfg.largeAuraIconSize == nil then
		cfg.largeAuraIconSize = 25
	end

	if cfg.rarePlayerFrame == nil then
		cfg.rarePlayerFrame = false
	end

	if cfg.rareElitePlayerFrame == nil then
		cfg.rareElitePlayerFrame = false
	end

	if cfg.reactionHealthBarColor == nil then
		cfg.reactionHealthBarColor = true
	end

	if cfg.shamanClassColorFix == nil then
		cfg.shamanClassColorFix = true
	end

	if cfg.smallAuraIconSize == nil then
		cfg.smallAuraIconSize = 20
	end

	if cfg.upperCaseAbbreviation == nil then
		cfg.upperCaseAbbreviation = true
	end

	if cfg.wideTargetFrame == nil then
		cfg.wideTargetFrame = true
	end

	if cfg.wideTargetFrameWidth == nil then
		cfg.wideTargetFrameWidth = 280
	end
end

eufSetDefaults();

function euf:CreateFont(frame, name, text, x, y, font, size)
	if size == nil then
		size = 15
	end

	if font == nil then
		font = STANDARD_TEXT_FONT
	end

	local fontString = frame:CreateFontString(name)

	fontString:SetFont(font, size, "")
	fontString:SetPoint("TOPLEFT", x, y)
	fontString:SetText(text)

	return (fontString)
end

local uniquealyzer = 1;

function createCheckbutton(parent, x_loc, y_loc, displayname)
	uniquealyzer = uniquealyzer + 1;
	local checkbutton = CreateFrame("CheckButton", "eufCheckButton" .. uniquealyzer, parent, "InterfaceOptionsCheckButtonTemplate");

	checkbutton:SetPoint("TOPLEFT", x_loc, y_loc);
	getglobal(checkbutton:GetName() .. "Text"):SetText(displayname);

	return checkbutton;
end

function euf:CreateButton(frame, name, text, width, height, x, y, template)
	if template == nil then
		template = "OptionsButtonTemplate"
	end

	local button = CreateFrame("Button", name, frame, template)

	button:SetHeight(height)
	button:SetText(text)
	button:SetPoint("TOPLEFT", x, y)
	button:SetWidth(width)

	return (button)
end

function euf:CreateUI(frame)
	eufUI = {}
	eufUI.panel = CreateFrame("Frame", "eufUI", UIParent);
	eufUI.panel.name = "EnhancedUnitFrames";

	InterfaceOptions_AddCategory(eufUI.panel);

	local title = euf:CreateFont(eufUI.panel, "title", "EnhancedUnitFrames", 16, -16, font, 16)

	title:SetFontObject(GameFontNormal) 
	title:SetPoint("LEFT", eufUI.panel, "TOPLEFT", 0, 0)

	local xOffset = -48;

	-- Big Player Health Bar.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset, "Big Player Health Bar");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton2:GetChecked() then
			cfg.bigPlayerHealthBars = true;
		else
			cfg.bigPlayerHealthBars = false;
		end

		ReloadUI()
	end);

	-- Big Target Health Bar.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 34, "Big Target Health Bar");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton3:GetChecked() then
			cfg.bigTargetHealthBars = true;
		else
			cfg.bigTargetHealthBars = false;
		end

		ReloadUI()
	end);

	-- Wide Target Frame.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 68, "Wide Target Frame");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton4:GetChecked() then
			cfg.wideTargetFrame = true;
		else
			cfg.wideTargetFrame = false;
		end

		ReloadUI()
	end);

	-- Class Color HP.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 102, "Class Color HP");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton5:GetChecked() then
			cfg.classHealthBarColor = true;
		else
			cfg.classHealthBarColor = false;
		end

		ReloadUI()
	end);

	-- Reaction Color HP. 

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 136, "Reaction Color HP");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton6:GetChecked() then
			cfg.reactionHealthBarColor = true;
		else
			cfg.reactionHealthBarColor = false;
		end

		ReloadUI()
	end);

	-- Elite Player Chain.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 170, "Elite Player Chain");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton7:GetChecked() then
			cfg.elitePlayerFrame = true;
		else
			cfg.elitePlayerFrame = false;
		end

		ReloadUI()
	end);

	-- Rare Player Chain.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 204, "Rare Player Chain");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton8:GetChecked() then
			cfg.rarePlayerFrame = true;
		else
			cfg.rarePlayerFrame = false;
		end

		ReloadUI()
	end);

	-- Rare Elite Player Chain.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 238, "Rare Elite Player Chain");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton9:GetChecked() then
			cfg.rareElitePlayerFrame = true;
		else
			cfg.rareElitePlayerFrame = false;
		end

		ReloadUI()
	end);

	-- Class Icon Portraits.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 272, "Class Icon Portraits");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton10:GetChecked() then
			cfg.classIconPortraits = true;
		else
			cfg.classIconPortraits = false;
		end

		ReloadUI()
	end);

	-- Hide Hit Indicators.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 306, "Hide Hit Indicators");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton11:GetChecked() then
			cfg.hideHitIndicators = true;
		else
			cfg.hideHitIndicators = false;
		end

		ReloadUI()
	end);

	-- Hide Pet Status Text.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 340, "Hide Pet Status Text");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton12:GetChecked() then
			cfg.hidePetStatusText = true;
		else
			cfg.hidePetStatusText = false;
		end

		ReloadUI()
	end);

	-- Hide Resting Icon.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 374, "Hide Resting Icon");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton13:GetChecked() then
			cfg.hideRestingIcon = true;
		else
			cfg.hideRestingIcon = false;
		end

		ReloadUI()
	end);

	-- Shaman Class Color Fix.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 408, "Shaman Class Color Fix");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton14:GetChecked() then
			cfg.shamanClassColorFix = true;
		else
			cfg.shamanClassColorFix = false;
		end

		ReloadUI()
	end);

	-- Uppercase Abbreviation.

	myCheckButton = createCheckbutton(eufUI.panel, 14, xOffset - 442, "Uppercase Abbreviation");

	myCheckButton:SetScript("OnClick", function(self)
		if eufCheckButton15:GetChecked() then
			cfg.upperCaseAbbreviation = true;
		else
			cfg.upperCaseAbbreviation = false;
		end

		ReloadUI()
	end);
end

SlashCmdList.eufUI = function()
	InterfaceOptionsFrame_OpenToCategory(eufUI.panel)
	InterfaceOptionsFrame_OpenToCategory(eufUI.panel)
end

SLASH_eufUI1 = "/euf"

euf:CreateUI()

function euf:Init(event, addon, ...)
	if cfg.bigPlayerHealthBars == true then
		eufCheckButton2:SetChecked(true)
	end

	if cfg.bigTargetHealthBars == true then
		eufCheckButton3:SetChecked(true)
	end

	if cfg.wideTargetFrame == true then
		eufCheckButton4:SetChecked(true)
	end

	if cfg.classHealthBarColor == true then
		eufCheckButton5:SetChecked(true)
	end

	if cfg.reactionHealthBarColor == true then
		eufCheckButton6:SetChecked(true)
	end

	if cfg.elitePlayerFrame == true then
		eufCheckButton7:SetChecked(true)
	end

	if cfg.rarePlayerFrame == true then
		eufCheckButton8:SetChecked(true)
	end

	if cfg.rareElitePlayerFrame == true then
		eufCheckButton9:SetChecked(true)
	end

	if cfg.classIconPortraits == true then
		eufCheckButton10:SetChecked(true)
	end

	if cfg.hideHitIndicators == true then
		eufCheckButton11:SetChecked(true)
	end

	if cfg.hidePetStatusText == true then
		eufCheckButton12:SetChecked(true)
	end

	if cfg.hideRestingIcon == true then
		eufCheckButton13:SetChecked(true)
	end

	if cfg.shamanClassColorFix == true then
		eufCheckButton14:SetChecked(true)
	end

	if cfg.upperCaseAbbreviation == true then
		eufCheckButton15:SetChecked(true)
	end
end

local eufUI = CreateFrame("Frame", "eufUI", UIParent)

eufUI:SetScript("OnEvent", euf.Init)
eufUI:RegisterEvent("ADDON_LOADED")