function saveData()
	local saveFile = {}
	saveFile.leftPos = leftPos
	saveFile.topPos = topPos
	saveFile.isLocked = isLocked
	saveFile.fontSize = fontSize
	saveFile.textLabel = textLabel
	Turbine.PluginData.Save(Turbine.DataScope.Account, saveFileName, saveFile);
end

function loadData()
	local saveFile = Turbine.PluginData.Load(Turbine.DataScope.Account, saveFileName)
	leftPos = saveFile.leftPos
	topPos = saveFile.topPos
	isLocked = saveFile.isLocked
	fontSize = saveFile.fontSize
	textLabel = saveFile.textLabel
end
