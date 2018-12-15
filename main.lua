local log = DosakisEmoteCombatAddOn.chatUtils.print

function EmoteCombat_SlashCommand()
  log("Opening Emote Combat")
  EmoteCombat_Frame:Show()
end
function EmoteCombat_Loaded()
  log("Emote Combat loaded!")
end

function EmoteCombat_OnLoad()
  SlashCmdList["EmoteCombat"] = EmoteCombat_SlashCommand;
  SLASH_EmoteCombat1= "/emotecombat";
end
