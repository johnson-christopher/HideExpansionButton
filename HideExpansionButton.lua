local frame = CreateFrame("FRAME", "HideExpansionButtonFrame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("COVENANT_CALLINGS_UPDATED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "HideExpansionButton" and ExpansionButtonVisible == nil then
            ExpansionButtonVisible = false
            SetButtonState()
            frame:UnregisterEvent("ADDON_LOADED")
        end
    elseif event == "COVENANT_CALLINGS_UPDATED" then
        -- Something fires this event and then turns the button back on after.
        -- Since it doesn't seem to fire another event when it's done we just
        -- have to wait an arbitrary amount of time.
        C_Timer.After(5, SetButtonState)
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
    if ExpansionButtonVisible then
        ExpansionLandingPageMinimapButton:Show()
    else
        ExpansionLandingPageMinimapButton:Hide()
    end
end
