
local addonName, FF = ...

--------------------------------------------------
-- Addon Information
--------------------------------------------------

FF.name = addonName

--------------------------------------------------
-- Module Namespaces
--------------------------------------------------

FF.Database = {}
FF.Discovery = {}
FF.Events = {}
FF.UI = {}
FF.Commands = {}

--------------------------------------------------
-- Loaded Message
--------------------------------------------------

DEFAULT_CHAT_FRAME:AddMessage(
    "|cff00ff00ForeverFriends loaded!|r"
)
