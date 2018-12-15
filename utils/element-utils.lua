local ec = DosakisEmoteCombatAddOn;
local elementUtils = {}
ec["elements"] = {}


elementUtils["find"] = function(elementName)
  for i, element in ipairs(ec["elements"]) do
    if element:GetName() == elementName then
      return element
    end
  end
end


elementUtils["addGenericText"] = function(text, parent, name, font, anchor, offsetx, offsety, justify)
  parent.text =
  parent:CreateFontString(parent:GetName() .. "__" .. name, "OVERLAY", font)
  parent.text:SetPoint(anchor, parent, anchor, offsetx, offsety)
  parent.text:SetJustifyH(justify)
  parent.text:SetJustifyV("MIDDLE")
  parent.text:SetText(text)
  return parent.text
end

elementUtils["addText"] = function(text, parent, name, x, y)
  local textElement = elementUtils["addGenericText"](text, parent, name, "GameFontNormalLarge", "TOPLEFT", x, y, "LEFT")
  textElement:SetTextColor(1,0.82,0,1)
  return textElement
end

elementUtils["addNumberText"] = function(text, parent, name, x, y)
  local textElement = elementUtils["addGenericText"](text, parent, name, "NumberFont_Shadow_Med", "TOPLEFT", x, y, "LEFT")
  textElement:SetTextColor(0.95,0.95,0.95,1)
  return textElement
end

ec["elementUtils"] = elementUtils
