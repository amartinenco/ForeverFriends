
local addonName, FF = ...

--------------------------------------------------
-- Row Pools
--------------------------------------------------

local friendButtonPool = {}
local characterTextPool = {}

local friendButtonIndex = 0
local characterTextIndex = 0

--------------------------------------------------
-- Clear Existing Rows
--------------------------------------------------

local function ClearRows()

    friendButtonIndex = 0
    characterTextIndex = 0

    for _, row in ipairs(friendButtonPool) do
        row:Hide()
    end

    for _, row in ipairs(characterTextPool) do
        row:Hide()
    end

end

--------------------------------------------------
-- Render Friend List
--------------------------------------------------

function FF.UI:RenderTree()

    local content = self.content
    local scrollFrame = self.scrollFrame
    local scrollbar = self.scrollbar

    local friends = FF.Database.friends

    local previousScroll = scrollbar:GetValue()

    ClearRows()

    local y = -10

    local sortedAccountIDs = {}

    for accountID in pairs(friends) do
        table.insert(sortedAccountIDs, accountID)
    end

    table.sort(sortedAccountIDs, function(a, b)

        local nameA = friends[a].accountName or ""
        local nameB = friends[b].accountName or ""

        return nameA:lower() < nameB:lower()

    end)

    for _, accountID in ipairs(sortedAccountIDs) do

        local chars = friends[accountID]

        friendButtonIndex = friendButtonIndex + 1

        local friendButton = friendButtonPool[friendButtonIndex]

        if not friendButton then

            friendButton = CreateFrame(
                "Button",
                nil,
                content
            )

            friendButtonPool[friendButtonIndex] = friendButton

            local friendBg = friendButton:CreateTexture(
                nil,
                "BACKGROUND"
            )

            friendBg:SetAllPoints()
            friendBg:SetColorTexture(0.15, 0.15, 0.15, 0.6)

            local friendText = friendButton:CreateFontString(
                nil,
                "OVERLAY",
                "GameFontNormal"
            )

            friendText:SetPoint("LEFT", 5, 0)

            friendButton.friendText = friendText

        end

        friendButton:ClearAllPoints()
        friendButton:SetPoint("TOPLEFT", 10, y)
        friendButton:SetSize(430, 24)
        friendButton:Show()

        local displayName = accountID

        if chars.expanded then
            friendButton.friendText:SetText("[-] " .. displayName)
        else
            friendButton.friendText:SetText("[+] " .. displayName)
        end

        friendButton:SetScript("OnClick", function()

            chars.expanded = not chars.expanded

            self:RenderTree()

        end)

        y = y - 25

        if chars.expanded then

            for _, character in ipairs(chars.chars) do

                characterTextIndex = characterTextIndex + 1

                local charRow = characterTextPool[characterTextIndex]

                if not charRow then

                    charRow = content:CreateFontString(
                        nil,
                        "OVERLAY",
                        "GameFontNormal"
                    )

                    characterTextPool[characterTextIndex] = charRow

                end

                charRow:ClearAllPoints()
                charRow:SetPoint("TOPLEFT", 35, y)

                local text = string.format(
                    "%s - %s",
                    character.name,
                    character.class or "Unknown"
                )

                charRow:SetText(" - " .. text)
                charRow:Show()

                y = y - 20

            end

            y = y - 10

        end

    end

    --------------------------------------------------
    -- Update Content Height and Scrollbar
    --------------------------------------------------

    local contentHeight = math.abs(y) + 20

    content:SetHeight(contentHeight)

    local visibleHeight = scrollFrame:GetHeight()

    local maxScroll = math.max(
        0,
        contentHeight - visibleHeight
    )

    scrollbar:SetMinMaxValues(0, maxScroll)

    scrollbar:SetValue(
        math.min(previousScroll, maxScroll)
    )

    if maxScroll <= 0 then

        scrollbar:Hide()
        scrollbar:SetValue(0)

        scrollFrame:ClearAllPoints()
        scrollFrame:SetPoint("TOPLEFT", 10, -40)
        scrollFrame:SetPoint("BOTTOMRIGHT", -10, 10)

    else

        scrollbar:Show()

        scrollFrame:ClearAllPoints()
        scrollFrame:SetPoint("TOPLEFT", 10, -40)
        scrollFrame:SetPoint("BOTTOMRIGHT", -25, 10)

    end

end
