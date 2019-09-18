﻿-- Function that determines which client the addon is running on.

function isClassic()
	return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

-- Loads the addon's components and loads the options panel when the interface options is shown.

local euf = CreateFrame("Frame")
local eufOptionsLoad = CreateFrame("Frame", nil, InterfaceOptionsFrame)

euf:RegisterEvent("ADDON_LOADED")
euf:RegisterEvent("PLAYER_ENTERING_WORLD")

local function isLoaded(self, event, addon)
	if event == "ADDON_LOADED" then
		SetDefaults()
		AuraStyling()
		ClassIconPortraits()
		MirroredPositioning()
		PlayerFrameStyling()
		StatusBarStyling()
		StatusTextStyling()
		PowerBar()
		TargetFrameStyling()

		if isClassic() then
			ShamanClassColorFix()
		else
			BossFrameStyling()
		end

		euf:UnregisterEvent("ADDON_LOADED")
	elseif event == "PLAYER_ENTERING_WORLD" then
		hooksecurefunc("TextStatusBar_OnEvent", function(self, event, ...)
			TextStatusBar_UpdateTextString(self)
		end)

		euf:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end

euf:SetScript("OnEvent", isLoaded)

eufOptionsLoad:SetScript("OnShow", function(self)
	LoadAddOn("EnhancedUnitFrames_Options")

	self:SetScript("OnShow", nil)
end)

-- Creates the addon's slash command.

SlashCmdList.euf = function()
	if not IsAddOnLoaded("EnhancedUnitFrames_Options") then
		LoadAddOn("EnhancedUnitFrames_Options")
	end

	InterfaceOptionsFrame_OpenToCategory(eufOptions.general)
	InterfaceOptionsFrame_OpenToCategory(eufOptions.general)
	PlaySound(852)
end

SLASH_euf1 = "/euf"
