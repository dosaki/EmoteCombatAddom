local ec = DosakisEmoteCombatAddOn;
local frameUtils = {}

frameUtils["makeMoveable"] = function(frame)
  frame:SetMovable(true)
  frame:RegisterForDrag("LeftButton")
  frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
  frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
end

frameUtils["newGenericFrame"] = function (name, type, parent, width, height, isClickable, isMoveable, inherits)
  local newFrame = nil

  if inherits == "" then
    newFrame = CreateFrame(type, parent:GetName() .. "__" .. name, parent)
  else
    newFrame = CreateFrame(type, parent:GetName() .. "__" .. name, parent, inherits)
  end
  newFrame:SetWidth(width)
  newFrame:SetHeight(height)
  newFrame:SetPoint("CENTER", parent, "CENTER")
  newFrame:EnableMouse(isClickable)

  if isMoveable and isClickable then
    frameUtils["makeMoveable"](newFrame)
  end
  return newFrame
end

frameUtils["newDefaultFrame"] = function (name, parent, width, height)
  return frameUtils["newGenericFrame"](name, "frame", parent, width, height, false, false, "")
end

frameUtils["newButton"] = function (name, parent, width, height, x, y, text)
  local button = frameUtils["newGenericFrame"](name, "Button", parent, width, height, true, false, "UIPanelButtonTemplate")
  button:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
  button:SetText(text)
  return button
end

frameUtils["newStatusBar"] = function (name, parent, width, height)
  local statusBar = frameUtils["newGenericFrame"](name, "StatusBar", parent, width, height, false, false, "")
  local texture = statusBar:CreateTexture(nil, "BACKGROUND")
  texture:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
  statusBar:SetStatusBarTexture(texture)
  statusBar:GetStatusBarTexture():SetHorizTile(false)
  statusBar:GetStatusBarTexture():SetVertTile(false)
  return statusBar
end

ec["frameUtils"] = frameUtils
