-- Activate Plugin --
Plugins[pluginName].Load = function()
	Notification("Activated version " .. Plugins[pluginName]:GetVersion() .. " by HennaKristal.");

	if localPlayer:GetTarget() then
		groupDPSWindow:UpdateTarget(localPlayer:GetTarget())
	end
end

-- Unload Plugin --
Plugins[pluginName].Unload = function()
	SavePosition();
	Notification("Plugin has been deactivated.");
end
