-- Sends notifications to chat --
function Notification(message)
	Turbine.Shell.WriteLine(rgb["pluginName"] .. pluginName .. rgb["clear"] .. ": " .. tostring(message))
end
