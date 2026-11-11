
local addonName, FF = ...

--------------------------------------------------
-- Slash Commands
--------------------------------------------------

SLASH_FOREVERFRIENDS1 = "/ff"
SLASH_FOREVERFRIENDS2 = "/foreverfriends"

SlashCmdList["FOREVERFRIENDS"] = function(message)

    message = message:lower():trim()

    if message == "reset" then

        ForeverFriendsDB.friends = {}

        FF.Database:LoadCache()
        FF.Database:LoadFriends()

        local changed = FF.Discovery:Scan()

        if changed then
            FF.Database:LoadFriends()
        end

        print("|cff00ff00ForeverFriends database reset and discovery completed.|r")

        return
    
    elseif message == "help" then

        print("|cff00ccffForeverFriends Commands:|r")
        print("|cffffff00/ff|r - Toggle the friend list")
        print("|cffffff00/ff reset|r - Clear database and rediscover characters")
        print("|cffffff00/ff help|r - Show available commands")

        return
        
    end

    local frame = FF.UI.frame

    if frame:IsShown() then
        frame:Hide()
    else
        FF.Database:LoadFriends()
        frame:Show()
    end

end
