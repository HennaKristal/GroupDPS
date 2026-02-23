-- Activate Plugin --
Plugins[pluginName].Load = function()
	notification("Activated version " .. Plugins[pluginName]:GetVersion() .. " by HennaKristal.");

	if localPlayer:GetTarget() then
		GroupDPSWindow:UpdateTarget(localPlayer:GetTarget())
	end
end

-- Unload Plugin --
Plugins[pluginName].Unload = function()
	saveData();
	notification("Plugin has been deactivated.");
end
