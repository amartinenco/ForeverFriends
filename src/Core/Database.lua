
local addonName, FF = ...

--------------------------------------------------
-- Saved Variables
--------------------------------------------------

ForeverFriendsDB = ForeverFriendsDB or {}
ForeverFriendsDB.friends = ForeverFriendsDB.friends or {}

--------------------------------------------------
-- Database State
--------------------------------------------------

FF.Database.friends = {}
FF.Database.friendsCache = {}

--------------------------------------------------
-- Load SavedVariables into RAM Cache
--------------------------------------------------

function FF.Database:LoadCache()

    self.friendsCache = {}

    for accountID, friend in pairs(ForeverFriendsDB.friends) do

        self.friendsCache[accountID] = {
            characters = {}
        }

        for characterKey in pairs(friend.characters or {}) do
            self.friendsCache[accountID].characters[characterKey] = true
        end

    end

end

--------------------------------------------------
-- Load SavedVariables into UI Data
--------------------------------------------------

function FF.Database:LoadFriends()

    local previousFriends = self.friends
    self.friends = {}

    for accountID, storedFriend in pairs(ForeverFriendsDB.friends) do
        if accountID and accountID ~= "" then
            local previousFriend = previousFriends[accountID]

            local friend = {
                expanded = previousFriend and previousFriend.expanded or false,
                chars = {},
                bnetAccountID = accountID
            }

            for _, character in pairs(storedFriend.characters or {}) do
                table.insert(friend.chars, character)
            end

            table.sort(friend.chars, function(a, b)
                return a.name:lower() < b.name:lower()
            end)

            friend.accountName = storedFriend.accountName

            self.friends[accountID] = friend
        end
    end

    FF.UI:RenderTree()

end
