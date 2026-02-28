plugin.GetOptionsPanel = function(self)

	-- Create options panel --
	optionsPanel = Turbine.UI.Control()
	optionsPanel:SetSize(800, 450)


	-- Settings title --
	settingsTitle = Turbine.UI.Label()
	settingsTitle:SetParent(optionsPanel)
	settingsTitle:SetText("Settings")
	settingsTitle:SetSize(400, 30)
	settingsTitle:SetPosition(0, 25)
	settingsTitle:SetFont(Turbine.UI.Lotro.Font.TrajanPro18)
	settingsTitle:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	settingsTitle:SetForeColor(color["yellow"])
	settingsTitle:SetFontStyle(Turbine.UI.FontStyle.Outline)
	settingsTitle:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend)
	settingsTitle:SetBackground(Turbine.UI.Graphic("GroupDPS/Images/optionsTitleBackground.tga"))

	-- Enable local time checkbox --
	lockPositionLabel = Turbine.UI.Label()
	lockPositionLabel:SetParent(optionsPanel)
	lockPositionLabel:SetSize(300, 30)
	lockPositionLabel:SetPosition(80, 80)
	lockPositionLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16)
	lockPositionLabel:SetText("Lock position")
	lockPositionLabel:SetForeColor(color["golden"])
	lockPositionCheckbox = Turbine.UI.Lotro.CheckBox()
	lockPositionCheckbox:SetParent(optionsPanel)
	lockPositionCheckbox:SetSize(20, 20)
	lockPositionCheckbox:SetPosition(50, 79)
	lockPositionCheckbox:SetChecked(isLocked)

	-- Local time font size --
	fontSizeLabel = Turbine.UI.Label()
	fontSizeLabel:SetParent(optionsPanel)
	fontSizeLabel:SetSize(200, 50)
	fontSizeLabel:SetPosition(50, 120)
	fontSizeLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16)
	fontSizeLabel:SetText("Font Size:")
	fontSizeLabel:SetForeColor(color["golden"])
	fontSizeDropdown = GroupDPS.Scripts.Utility.DropDownList()
	fontSizeDropdown:SetParent(optionsPanel)
	fontSizeDropdown:SetDropRows(5)
	fontSizeDropdown:SetSize(200, 20)
	fontSizeDropdown:SetPosition(50, 140)
	fontSizeDropdown:SetZOrder(1002)
	fontSizeDropdown:SetVisible(true)
	fontSizeDropdown:SetBackColor(Turbine.UI.Color(0, 0, 0))
	fontSizeDropdown:SetTextColor(Turbine.UI.Color(1, 1, 1))
	fontSizeDropdown:SetCurrentBackColor(Turbine.UI.Color(0, 0, 0))
	local fontSizes = {"10", "12", "14", "16", "18", "20", "22", "23"}
	for i = 1, #fontSizes do
		fontSizeDropdown:AddItem(fontSizes[i], string.lower(fontSizes[i]))
		if (fontSize == string.lower(fontSizes[i])) then
			fontSizeDropdown:SetSelectedIndex(i)
		end
	end

	-- DPS label --
	dpsLabel = Turbine.UI.Label()
	dpsLabel:SetParent(optionsPanel)
	dpsLabel:SetText("DPS Prefix")
	dpsLabel:SetForeColor(color["golden"])
	dpsLabel:SetSize(200, 30)
	dpsLabel:SetPosition(50, 180)
	dpsLabelTextbox = Turbine.UI.TextBox()
	dpsLabelTextbox:SetParent(optionsPanel)
	dpsLabelTextbox:SetSize(240, 20)
	dpsLabelTextbox:SetPosition(50, 200)
	dpsLabelTextbox:SetText(textLabel)
	dpsLabelTextbox:SetMultiline(false)
	dpsLabelTextbox:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
	dpsLabelTextbox:SetFont(Turbine.UI.Lotro.Font.Verdana14)
	dpsLabelTextbox:SetForeColor(color["black"])
	dpsLabelTextbox:SetBackColor(color["white"])

	-- Save settings button --
	saveSettingsButton = Turbine.UI.Lotro.Button()
	saveSettingsButton:SetText("Save Settings")
	saveSettingsButton:SetParent(optionsPanel)
	saveSettingsButton:SetSize(250, 20)
	saveSettingsButton:SetPosition(50, 260)
	saveSettingsButton:SetZOrder(100)
	saveSettingsButton.Click = function( sender, args)
		isLocked = lockPositionCheckbox:IsChecked()
		textLabel = dpsLabelTextbox:GetText()
		fontSize = fontSizeDropdown:GetValue()
		groupDPSFrame:UpdateFontSize()
		UpdateTarget(localPlayer:GetTarget())
		SaveSettings()
		Notification("Settings have been saved!")
	end


	-- Troubleshoot title --
	troubleshootTitle = Turbine.UI.Label()
	troubleshootTitle:SetParent(optionsPanel)
	troubleshootTitle:SetText("Troubleshoot")
	troubleshootTitle:SetSize(400, 30)
	troubleshootTitle:SetPosition(0, 345)
	troubleshootTitle:SetFont(Turbine.UI.Lotro.Font.TrajanPro18)
	troubleshootTitle:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	troubleshootTitle:SetForeColor(color["yellow"])
	troubleshootTitle:SetFontStyle(Turbine.UI.FontStyle.Outline)
	troubleshootTitle:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend)
	troubleshootTitle:SetBackground(Turbine.UI.Graphic("GroupDPS/Images/optionsTitleBackground.tga"))

	-- Local time offscreen help button --
	resetPositionButton = Turbine.UI.Lotro.Button()
	resetPositionButton:SetText("Reset Position")
	resetPositionButton:SetParent(optionsPanel)
	resetPositionButton:SetSize(250, 20)
	resetPositionButton:SetPosition(50, 400)
	resetPositionButton:SetZOrder(100)
	resetPositionButton.Click = function( sender, args)
		leftPos = (screenWidth / 2) - (groupDPSFrame:GetWidth() / 2)
		topPos = (screenHeight / 2) - (groupDPSFrame:GetHeight() / 2)
		groupDPSFrame:SetPosition(leftPos, topPos)
		Notification("Position has been resetted.")
	end


	-- Return View --
	return optionsPanel
end
