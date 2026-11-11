
local addonName, FF = ...

--------------------------------------------------
-- Discover New Characters
--------------------------------------------------

function FF.Discovery:Scan()

    local discovered = false

    local numFriends = BNGetNumFriends()

    for i = 1, numFriends do

        local accountInfo = C_BattleNet.GetFriendAccountInfo(i)

        if accountInfo and accountInfo.battleTag and accountInfo.battleTag ~= "" then

            local accountID = accountInfo.battleTag

            -- Check every game account belonging to this friend
            local numGameAccounts =
                C_BattleNet.GetFriendNumGameAccounts(i)

            for j = 1, numGameAccounts do

                local gameInfo =
                    C_BattleNet.GetFriendGameAccountInfo(i, j)

                if gameInfo
                    and gameInfo.isOnline
                    and gameInfo.clientProgram == BNET_CLIENT_WOW then

                    local charName = gameInfo.characterName
                    local realm = gameInfo.realmDisplayName
                        or gameInfo.realmName

                    if charName and charName ~= "" then

                        local regionID = gameInfo.regionID
                        local key = (regionID or 0) .. "-" .. charName

                        -- Check RAM cache first
                        local cachedFriend =
                            FF.Database.friendsCache[accountID]

                        if not cachedFriend then
                            cachedFriend = { characters = {} }
                            FF.Database.friendsCache[accountID] = cachedFriend
                        end

                        if not cachedFriend.characters[key] then

                            -- Create persistent friend record if necessary
                            local storedFriend =
                                ForeverFriendsDB.friends[accountID]

                            if not storedFriend then
                                storedFriend = {
                                    accountName = accountInfo.accountName,
                                    characters = {}
                                }

                                ForeverFriendsDB.friends[accountID] =
                                    storedFriend
                            end

                            -- Ensure the character table exists
                            storedFriend.characters =
                                storedFriend.characters or {}

                            -- Save character to database
                            storedFriend.characters[key] = {
                                name = charName,
                                realm = realm,
                                class = gameInfo.className,
                                regionID = regionID
                            }

                            -- Update RAM cache
                            cachedFriend.characters[key] = true

                            discovered = true

                            print("Discovered new character:", charName)

                        end
                    end
                end
            end
        end
    end

    return discovered

end
