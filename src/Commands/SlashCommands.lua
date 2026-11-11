
local addonName, FF = ...

--------------------------------------------------
-- Slash Commands
--------------------------------------------------

SLASH_FOREVERFRIENDS1 = "/ff"
SLASH_FOREVERFRIENDS2 = "/foreverfriends"

SlashCmdList["FOREVERFRIENDS"] = function()

    local frame = FF.UI.frame

    if frame:IsShown() then
        frame:Hide()
    else
        FF.Database:LoadFriends()
        frame:Show()
    end

end
