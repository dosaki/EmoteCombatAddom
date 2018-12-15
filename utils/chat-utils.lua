local ec = DosakisEmoteCombatAddOn;
local chatUtils = {}

chatUtils["print"] = function(text)
  if DosakisEmoteCombatAddOn.isDebug then
    print("[Emote Combat] " .. text)
  end
end

ec["chatUtils"] = chatUtils;
