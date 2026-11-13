
local addonName, FF = ...

--------------------------------------------------
-- Event Frame
--------------------------------------------------

local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("BN_CONNECTED")
eventFrame:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")

--------------------------------------------------
-- Event State
--------------------------------------------------

local cacheLoaded = false
local scanPending = false

--------------------------------------------------
-- Schedule Discovery Scan
--------------------------------------------------

local function ScheduleDiscoveryScan(delay)

    if scanPending then
        return
    end

    scanPending = true

    C_Timer.After(delay or 3, function()

        scanPending = false

        if not cacheLoaded then
            return
        end

        local changed = FF.Discovery:Scan()

        if changed then
            FF.Database:LoadFriends()
        end

    end)

end

--------------------------------------------------
-- Event Handler
--------------------------------------------------

eventFrame:SetScript("OnEvent", function(self, event, friendId, isCompanionApp)

    if event == "PLAYER_LOGIN" then

        -- Load existing SavedVariables into RAM once
        FF.Database:LoadCache()
        cacheLoaded = true

        ScheduleDiscoveryScan(10)
    
    elseif event == "PLAYER_ENTERING_WORLD" then 

        ScheduleDiscoveryScan()

    elseif event == "BN_CONNECTED" then

        ScheduleDiscoveryScan()

    elseif event == "BN_FRIEND_ACCOUNT_ONLINE" then

        if isCompanionApp then
            return
        end

        ScheduleDiscoveryScan()

    end

end)
