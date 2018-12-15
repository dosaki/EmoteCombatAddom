local ec = DosakisEmoteCombatAddOn;
local skills = {}
local log = DosakisEmoteCombatAddOn.chatUtils.print

local parentFrame = EmoteCombat_Skills_Frame
parentFrame:RegisterEvent("ADDON_LOADED");

DosakisEmoteCombatAddOn["allButtonsStore"] = {}
DosakisEmoteCombatAddOn["experienceBar"] = nil
DosakisEmoteCombatAddOn["experienceText"] = nil

local getMax = function(max, skill)
  if skill.parent ~= "" then
    return math.floor(DosakisEmoteCombatStore[skill.parent].value / 2);
  end
  return max
end

local getMin = function(min, skill)
  if skill.parent ~= "" then
    return 0;
  end
  return min
end

local checkDisabled = function(plus, minus, value, min, max, cost)
  if (value >= max) or ((DosakisEmoteCombatStore["Experience"].value - cost) < 0) then
    plus:Disable()
  else
    plus:Enable()
  end
  if value <= min then
    minus:Disable()
  else
    minus:Enable()
  end
end

local checkButtonStatus = function(min, max, skillName, plus, minus, cost)
  local lMax = getMax(max, DosakisEmoteCombatStore[skillName]);
  local lMin = getMin(min, DosakisEmoteCombatStore[skillName]);
  checkDisabled(plus, minus, DosakisEmoteCombatStore[skillName].value, lMin, lMax, cost);
end

local changeExperience = function(cost)
  DosakisEmoteCombatStore["Experience"].value = DosakisEmoteCombatStore["Experience"].value + cost
  DosakisEmoteCombatAddOn["experienceText"]:SetText("Experience" .. " " .. DosakisEmoteCombatStore["Experience"].value)
  DosakisEmoteCombatAddOn["experienceBar"]:SetValue(DosakisEmoteCombatStore["Experience"].value)
end

skills["makeSkill"] = function(skillName, x, y, parent, cost)
  ec.elementUtils.addText(skillName, parent, string.gsub(skillName, " ", "") .. "_Name_Text", x, y);
  local valueText = ec.elementUtils.addNumberText(
    DosakisEmoteCombatStore[skillName].value,
    parent,
    string.gsub(skillName, " ", "") .. "_Value_Text",
    135, y);
  local plus = ec.frameUtils.newButton(string.gsub(skillName, " ", "") .. "_Plus_Button", parent, 20, 20, 155, y, "+");
  local minus = ec.frameUtils.newButton(string.gsub(skillName, " ", "") .. "_Minus_Button", parent, 20, 20, 175, y, "−");

  local max = getMax(6, DosakisEmoteCombatStore[skillName]);
  local min = getMin(1, DosakisEmoteCombatStore[skillName]);
  checkDisabled(plus, minus, DosakisEmoteCombatStore[skillName].value, min, max, cost);

  plus:SetScript("OnClick", function(self,event)
    local pMax = getMax(6, DosakisEmoteCombatStore[skillName]);
    local pMin = getMin(1, DosakisEmoteCombatStore[skillName]);
    if (DosakisEmoteCombatStore[skillName].value + 1) <= pMax then
      DosakisEmoteCombatStore[skillName].value = DosakisEmoteCombatStore[skillName].value + 1;
      valueText:SetText(DosakisEmoteCombatStore[skillName].value);
      changeExperience(-cost)
    end
    if DosakisEmoteCombatAddOn["allButtonsStore"] ~= nil then
      for buttonSkillName, buttons in ipairs(DosakisEmoteCombatAddOn["allButtonsStore"]) do
        checkButtonStatus(0, 6, buttonsSkillName, buttons.plus, buttons.minus, buttons.cost)
      end
    end
  end)

  minus:SetScript("OnClick", function(self,event)
    local mMax = getMax(6, DosakisEmoteCombatStore[skillName]);
    local mMin = getMin(1, DosakisEmoteCombatStore[skillName]);
    if (DosakisEmoteCombatStore[skillName].value - 1) >= mMin then
      DosakisEmoteCombatStore[skillName].value = DosakisEmoteCombatStore[skillName].value - 1;
      valueText:SetText(DosakisEmoteCombatStore[skillName].value);
      changeExperience(cost)
    end
    if DosakisEmoteCombatAddOn["allButtonsStore"] ~= nil then
      print(DosakisEmoteCombatAddOn["allButtonsStore"])
      for buttonSkillName, buttons in ipairs(DosakisEmoteCombatAddOn["allButtonsStore"]) do
        checkButtonStatus(0, 6, buttonsSkillName, buttons.plus, buttons.minus, buttons.cost)
      end
    end
  end)

  DosakisEmoteCombatAddOn["allButtonsStore"][skillName] = {
    ["plus"] = plus,
    ["minus"] = minus,
    ["cost"] = cost
  }
  return skillName, plus, minus, cost
end

skills["makeSkillGroupHolder"] = function(groupName, x, y)
  local skillFrame = ec.frameUtils.newDefaultFrame(string.gsub(groupName, " ", ""), parentFrame, 200, 150)
  skillFrame:SetPoint("CENTER", parentFrame, "CENTER", x, y)
  return skillFrame
end

skills["makeSkillGroup"] = function(mainSkill, subskills, x, y)
  local skillFrame = skills["makeSkillGroupHolder"](mainSkill, x, y)
  for i, subskill in ipairs(subskills) do
    skills["makeSkill"](subskill, 10, (i)*-25, skillFrame, 3)
  end
  skills["makeSkill"](mainSkill, 0, 0, skillFrame, 5)
end

skills["makeSkillBar"] = function(skillName, x, y, isUserAlterable)
  local skillFrame = skills["makeSkillGroupHolder"](skillName, x, y)
  local skillbar = ec.frameUtils.newStatusBar(string.gsub(skillName, " ", ""), skillFrame, 425, 20)
  skillbar:SetPoint("CENTER", skillFrame, "CENTER", 0, 0)
  skillbar:SetMinMaxValues(0, DosakisEmoteCombatStore["Max" .. skillName].value)
  skillbar:SetValue(DosakisEmoteCombatStore[skillName].value)

  local valueText = ec.elementUtils.addNumberText(
    skillName .. " " .. DosakisEmoteCombatStore[skillName].value,
    skillbar,
    string.gsub(skillName, " ", "") .. "_Value_Text",
    5, -2)

  if isUserAlterable then
    local plus = ec.frameUtils.newButton(string.gsub(skillName, " ", "") .. "_Plus_Button", skillFrame, 20, 20, 0, 0, "+")
    plus:SetPoint("TOPLEFT", skillFrame, "CENTER", 220, 10)
    plus:SetScript("OnClick", function(self,event)
      if DosakisEmoteCombatStore[skillName].value < DosakisEmoteCombatStore["Max" .. skillName].value then
        DosakisEmoteCombatStore[skillName].value = DosakisEmoteCombatStore[skillName].value + 1
        valueText:SetText(skillName .. " " .. DosakisEmoteCombatStore[skillName].value)
        skillbar:SetValue(DosakisEmoteCombatStore[skillName].value)
      end
    end)

    local minus = ec.frameUtils.newButton(string.gsub(skillName, " ", "") .. "_Minus_Button", skillFrame, 20, 20, 0, 0, "−")
    minus:SetPoint("TOPLEFT", skillFrame, "CENTER", 240, 10)
    minus:SetScript("OnClick", function(self,event)
      if DosakisEmoteCombatStore[skillName].value - 1 >= 0 then
        DosakisEmoteCombatStore[skillName].value = DosakisEmoteCombatStore[skillName].value - 1
        valueText:SetText(skillName .. " " .. DosakisEmoteCombatStore[skillName].value)
        skillbar:SetValue(DosakisEmoteCombatStore[skillName].value)
      end
    end)
  end
  print(skillbar, valueText)
  return skillbar, valueText
end

skills["addSkills"] = function()
    DosakisEmoteCombatAddOn["experienceBar"], DosakisEmoteCombatAddOn["experienceText"] = skills["makeSkillBar"]("Experience", -25, 320, false)
    DosakisEmoteCombatAddOn["experienceBar"]:SetStatusBarColor(0.59, 0.17, 0.76)
    local healthbar, healthText = skills["makeSkillBar"]("Health", -25, 280, true)
    healthbar:SetStatusBarColor(0.17, 0.76, 0.33)
    skills["makeSkillGroup"]("Agility", {"Dodge", "Light Armour", "Ranged", "Speed"}, -140, 160)
    skills["makeSkillGroup"]("Might", {"Brawn", "Heavy Armour", "Melee", "Shield"}, 140, 160)
    skills["makeSkillGroup"]("Presence", {"Authority", "Charm", "Deception", "Perception"}, -140, -20)
    skills["makeSkillGroup"]("Brains", {"Engineering", "History", "Medicine", "Warcraft"}, 140, -20)
    skills["makeSkillGroup"]("Magic", {"Arcane", "Druidic", "Fel", "Fire", "Ice", "Light", "Shadow"}, -140, -200)
end


ec["skills"] = skills

function parentFrame:OnEvent(event, arg1)
 if event == "ADDON_LOADED" and arg1 == "EmoteCombat" then
   log("Loading skills...")
   DosakisEmoteCombatAddOn["skills"]["addSkills"]()
 end
end
parentFrame:SetScript("OnEvent", parentFrame.OnEvent);
