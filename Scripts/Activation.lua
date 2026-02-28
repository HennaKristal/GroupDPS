-- Activate Plugin --
Plugins[pluginName].Load = function()
	Notification("Activated version " .. Plugins[pluginName]:GetVersion() .. " by HennaKristal.")

	groupDPSFrame = GroupDPSFrame()

	LoadSettings()
	groupDPSFrame:UpdateFontSize()

	LoadPosition()
	groupDPSFrame:SetPosition(leftPos, topPos)

	if localPlayer:GetTarget() then
		UpdateTarget(localPlayer:GetTarget())
	end

	localPlayer.TargetChanged = function(sender, args)
		UpdateTarget(localPlayer:GetTarget())
	end
end


-- Unload Plugin --
Plugins[pluginName].Unload = function()
	SavePosition()
	Notification("Plugin has been deactivated.")
end
