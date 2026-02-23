function SaveSettings()
	local saveFile = {}
	saveFile.isLocked = isLocked
	saveFile.fontSize = fontSize
	saveFile.textLabel = textLabel
	Turbine.PluginData.Save(Turbine.DataScope.Account, saveFileName, saveFile);
end

function LoadSettings()
	local saveFile = Turbine.PluginData.Load(Turbine.DataScope.Account, saveFileName)

	if saveFile == nil then
		return
	end

	isLocked = saveFile.isLocked
	fontSize = saveFile.fontSize
	textLabel = saveFile.textLabel
end

function SavePosition()
	local saveFile = {}
	saveFile.leftPos = leftPos
	saveFile.topPos = topPos
	Turbine.PluginData.Save(Turbine.DataScope.Character, savePositionFileName, saveFile);
end

function LoadPosition()
	local saveFile = Turbine.PluginData.Load(Turbine.DataScope.Character, savePositionFileName)

	if saveFile == nil then
		return
	end

	leftPos = saveFile.leftPos
	topPos = saveFile.topPos
end
