local log = DosakisEmoteCombatAddOn.chatUtils.print;

local storeFrame = CreateFrame("FRAME"); -- Need a frame to respond to events
storeFrame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded

local externalStore = DosakisEmoteCombatAddOn.externalStore;
local defaultStore = DosakisEmoteCombatDefaultStore;
local storeToUse;


function storeFrame:OnEvent(event, arg1)
  if event == "ADDON_LOADED" and arg1 == "EmoteCombat" then
     log("Loading store...")
    -- Our saved variables are ready at this point. If there are none, both variables will set to nil.
    if DosakisEmoteCombatStore == nil then
      DosakisEmoteCombatStore = {
        ["UPDATED TIME"] = 0
      };
    end

    log("No new store found, initialized a new store")
    if externalStore["UPDATED TIME"] > defaultStore["UPDATED TIME"] then
      storeToUse = externalStore; -- This is the first time this addon is loaded; initialize the count to 0.
      print("Using externalStore")
      print(externalStore)
    else
      storeToUse = defaultStore;
      print("Using defaultStore")
      print(defaultStore)
    end
    print(storeToUse)
    storeToUse["UPDATED TIME"] = time();

    for k,v in pairs(storeToUse) do
      if DosakisEmoteCombatStore[k] == nil or storeToUse["UPDATED TIME"] > DosakisEmoteCombatStore["UPDATED TIME"] then
        DosakisEmoteCombatStore[k] = v
      end
    end
  end
end
storeFrame:SetScript("OnEvent", storeFrame.OnEvent);
