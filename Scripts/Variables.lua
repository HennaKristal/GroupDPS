pluginName = "GroupDPS"
saveFileName = "GroupDPS_Settings"
savePositionFileName = "GroupDPS_Position"

-- Notification color codes --
rgb = {
    pluginName = "<rgb=#DAA520>",
    error = "<rgb=#FF0000>",
    clear = "</rgb>"
}

-- Turbine colors --
color = {
    black = Turbine.UI.Color(0, 0, 0),
    darkgrey = Turbine.UI.Color(0.15, 0.15, 0.15),
    grey = Turbine.UI.Color(0.65, 0.64, 0.59),
    lightgrey = Turbine.UI.Color(0.8, 0.8, 0.75),
    white = Turbine.UI.Color(1, 1, 1),
    golden = Turbine.UI.Color(242/255, 217/255, 140/255),
    yellow = Turbine.UI.Color(244/255, 255/255, 51/255),
    orange = Turbine.UI.Color(1, 0.5, 0),
    red = Turbine.UI.Color(0.8, 0, 0),
    lightred = Turbine.UI.Color(1, 0.5, 0.5),
    darkred = Turbine.UI.Color(0.4, 0, 0),
    green = Turbine.UI.Color(0, 0.7, 0),
    lightgreen = Turbine.UI.Color(0.56, 0.93, 0.56),
    darkgreen = Turbine.UI.Color(0, 0.4, 0),
    blue = Turbine.UI.Color(0, 0, 1),
    lightblue = Turbine.UI.Color(0, 1, 1),
    darkblue = Turbine.UI.Color(0, 0.25, 0.5),
}

-- References
localPlayer = Turbine.Gameplay.LocalPlayer:GetInstance()
screenWidth, screenHeight = Turbine.UI.Display:GetSize()

-- Settings
leftPos = (screenWidth / 2)
topPos = screenHeight / 2
fontSize = "14"
isLocked = false
textLabel = "DPS:"

-- private variables
groupDPSCalculationStarted = false
holdDurationSeconds = 12.0
minDPStime = 1.0
moraleSamples = {}
currentTarget = nil
