
local addonName, FF = ...

--------------------------------------------------
-- Main Window
--------------------------------------------------

local frame = CreateFrame("Frame", "ForeverFriendsFrame", UIParent)

frame:SetSize(500, 400)
frame:SetPoint("CENTER")

frame:SetResizable(true)

local maxWidth = UIParent:GetWidth() * 0.9
local maxHeight = UIParent:GetHeight() * 0.9

frame:SetResizeBounds(300, 250, maxWidth, maxHeight)

frame:SetSize(
    UIParent:GetWidth() * 0.35,
    UIParent:GetHeight() * 0.45
)

frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")

frame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)

frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

frame:Hide()

--------------------------------------------------
-- Background
--------------------------------------------------

local bg = frame:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints()
bg:SetColorTexture(0.05, 0.05, 0.05, 0.95)

--------------------------------------------------
-- Header
--------------------------------------------------

local header = frame:CreateTexture(nil, "ARTWORK")
header:SetPoint("TOPLEFT")
header:SetPoint("TOPRIGHT")
header:SetHeight(30)
header:SetColorTexture(0.15, 0.15, 0.15, 1)

--------------------------------------------------
-- Title
--------------------------------------------------

local title = frame:CreateFontString(
    nil,
    "OVERLAY",
    "GameFontHighlightLarge"
)

title:SetPoint("TOP", 0, -10)
title:SetText("ForeverFriends")

--------------------------------------------------
-- Close Button
--------------------------------------------------

local closeBtn = CreateFrame("Button", nil, frame)

closeBtn:SetSize(22, 22)
closeBtn:SetPoint("TOPRIGHT", -5, -4)

local closeBg = closeBtn:CreateTexture(nil, "BACKGROUND")
closeBg:SetAllPoints()
closeBg:SetColorTexture(0.8, 0.15, 0.15, 1)

local closeText = closeBtn:CreateFontString(
    nil,
    "OVERLAY",
    "GameFontNormal"
)

closeText:SetPoint("CENTER")
closeText:SetText("X")

closeBtn:SetScript("OnClick", function()
    frame:Hide()
end)

--------------------------------------------------
-- Resize Handle
--------------------------------------------------

local resizeHandle = CreateFrame("Button", nil, frame)

resizeHandle:SetSize(16, 16)
resizeHandle:SetPoint("BOTTOMRIGHT", -2, 2)

local resizeTexture = resizeHandle:CreateTexture(
    nil,
    "ARTWORK"
)

resizeTexture:SetAllPoints()
resizeTexture:SetColorTexture(0.7, 0.7, 0.7, 1)

resizeHandle:SetScript("OnMouseDown", function()
    frame:StartSizing("BOTTOMRIGHT")
end)

resizeHandle:SetScript("OnMouseUp", function()
    frame:StopMovingOrSizing()
end)

--------------------------------------------------
-- Scroll Frame
--------------------------------------------------

local scrollFrame = CreateFrame("ScrollFrame", nil, frame)

scrollFrame:SetPoint("TOPLEFT", 10, -40)
scrollFrame:SetPoint("BOTTOMRIGHT", -25, 10)

local content = CreateFrame("Frame", nil, scrollFrame)

content:SetSize(1, 1)

scrollFrame:SetScrollChild(content)

--------------------------------------------------
-- Scroll Bar
--------------------------------------------------

local scrollbar = CreateFrame("Slider", nil, frame)

scrollbar:SetWidth(16)
scrollbar:SetPoint("TOPRIGHT", -5, -40)
scrollbar:SetPoint("BOTTOMRIGHT", -5, 10)

local track = scrollbar:CreateTexture(nil, "BACKGROUND")
track:SetAllPoints()
track:SetColorTexture(0.2, 0.2, 0.2, 1)

local thumb = scrollbar:CreateTexture(nil, "ARTWORK")
thumb:SetSize(12, 50)
thumb:SetColorTexture(0.8, 0.8, 0.8, 1)

scrollbar:SetThumbTexture(thumb)

scrollbar:SetMinMaxValues(0, 0)
scrollbar:SetValue(0)

scrollbar:SetScript("OnValueChanged", function(self, value)
    scrollFrame:SetVerticalScroll(value)
end)

--------------------------------------------------
-- Mouse Wheel Scroll
--------------------------------------------------

frame:EnableMouseWheel(true)

frame:SetScript("OnMouseWheel", function(_, delta)

    local current = scrollbar:GetValue()

    local minVal, maxVal = scrollbar:GetMinMaxValues()

    local newValue = math.max(
        minVal,
        math.min(maxVal, current - delta * 20)
    )

    scrollbar:SetValue(newValue)

end)

--------------------------------------------------
-- Resize Refresh
--------------------------------------------------

frame:SetScript("OnSizeChanged", function()

    local contentHeight = content:GetHeight()
    local visibleHeight = scrollFrame:GetHeight()

    local maxScroll = math.max(
        0,
        contentHeight - visibleHeight
    )

    scrollbar:SetMinMaxValues(0, maxScroll)

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

end)

--------------------------------------------------
-- Expose UI Elements
--------------------------------------------------

FF.UI.frame = frame
FF.UI.scrollFrame = scrollFrame
FF.UI.content = content
FF.UI.scrollbar = scrollbar
