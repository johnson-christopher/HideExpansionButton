-- Used to store a backup of the original "Show" method to restore it later if needed.
local originalShowFunction = nil

local frame = CreateFrame("FRAME", "HideExpansionButtonFrame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "HideExpansionButton" and ExpansionButtonVisible == nil then
            ExpansionButtonVisible = false
            frame:UnregisterEvent("ADDON_LOADED")
        end
    else
        SetButtonState()
    end
end)

SLASH_HIDEEXPANSIONBUTTON1 = "/heb"
function SlashCmdList.HIDEEXPANSIONBUTTON(msg, editbox)
    ExpansionButtonVisible = not ExpansionButtonVisible
    SetButtonState()
end

function SetButtonState()
    -- Before we hide the button we save its `Show` method and then override it.
    -- Otherwise everytime you zone to a new expansion WoW will just turn it back on.
    -- When we need to show it again we just restore the method before calling it.
    if ExpansionButtonVisible then
        if originalShowFunction ~= nil then
            ExpansionLandingPageMinimapButton.Show = originalShowFunction
        end
        ExpansionLandingPageMinimapButton:Show()
    else
        ExpansionLandingPageMinimapButton:Hide()
        if originalShowFunction == nil then
            originalShowFunction = ExpansionLandingPageMinimapButton.Show
        end
        ExpansionLandingPageMinimapButton.Show = function() end
    end
end
