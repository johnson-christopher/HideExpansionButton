local frame = CreateFrame("FRAME", "HideExpansionButtonFrame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, addon, ...)
    if event == "ADDON_LOADED" and addon == "HideExpansionButton" then
        if ExpansionButtonVisible == nil then
            ExpansionButtonVisible = false
        end
    elseif event == "PLAYER_LOGIN" then
        SetButtonState()
    end
end)

SLASH_HIDEEXPANSIONBUTTON1 = "/heb"
function SlashCmdList.HIDEEXPANSIONBUTTON(msg, editbox)
    ExpansionButtonVisible = not ExpansionButtonVisible
    SetButtonState()
end

function SetButtonState()
    if ExpansionButtonVisible then
        ExpansionLandingPageMinimapButton:Show()
    else
        ExpansionLandingPageMinimapButton:Hide()
    end
end
