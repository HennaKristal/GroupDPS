plugin.GetOptionsPanel = function(self)

	-- Create options panel --
	optionsPanel = Turbine.UI.Control();
	optionsPanel:SetSize(800, 450);


	-- Settings title --
	settingsTitle = Turbine.UI.Label();
	settingsTitle:SetParent(optionsPanel);
	settingsTitle:SetText("Settings");
	settingsTitle:SetSize(400, 30);
	settingsTitle:SetPosition(0, 25);
	settingsTitle:SetFont(Turbine.UI.Lotro.Font.TrajanPro18);
	settingsTitle:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
	settingsTitle:SetForeColor(color["yellow"]);
	settingsTitle:SetFontStyle(Turbine.UI.FontStyle.Outline);
	settingsTitle:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	settingsTitle:SetBackground(Turbine.UI.Graphic("GroupDPS/Images/optionsTitleBackground.tga"));

	-- Enable local time checkbox --
	lockPositionLabel = Turbine.UI.Label();
	lockPositionLabel:SetParent(optionsPanel);
	lockPositionLabel:SetSize(300, 30);
	lockPositionLabel:SetPosition(80, 80);
	lockPositionLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16);
	lockPositionLabel:SetText("Lock position");
	lockPositionLabel:SetForeColor(color["golden"]);
	lockPositionCheckbox = Turbine.UI.Lotro.CheckBox();
	lockPositionCheckbox:SetParent(optionsPanel);
	lockPositionCheckbox:SetSize(20, 20);
	lockPositionCheckbox:SetPosition(50, 79);
	lockPositionCheckbox:SetChecked(isLocked);

	-- Local time font size --
	fontSizeLabel = Turbine.UI.Label();
	fontSizeLabel:SetParent(optionsPanel);
	fontSizeLabel:SetSize(200, 50);
	fontSizeLabel:SetPosition(50, 120);
	fontSizeLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16);
	fontSizeLabel:SetText("Font Size:");
	fontSizeLabel:SetForeColor(color["golden"]);
	fontSizeDropdown = GroupDPS.Scripts.Utility.DropDownList();
	fontSizeDropdown:SetParent(optionsPanel);
	fontSizeDropdown:SetDropRows(5);
	fontSizeDropdown:SetSize(200, 20);
	fontSizeDropdown:SetPosition(50, 140);
	fontSizeDropdown:SetZOrder(1002);
	fontSizeDropdown:SetVisible(true);
	fontSizeDropdown:SetBackColor(Turbine.UI.Color(0, 0, 0));
	fontSizeDropdown:SetTextColor(Turbine.UI.Color(1, 1, 1));
	fontSizeDropdown:SetCurrentBackColor(Turbine.UI.Color(0, 0, 0));
	local fontSizes = {"10", "12", "14", "16", "18", "20", "22", "23"};
	for i = 1, #fontSizes do
		fontSizeDropdown:AddItem(fontSizes[i], string.lower(fontSizes[i]));
		if (fontSize == string.lower(fontSizes[i])) then
			fontSizeDropdown:SetSelectedIndex(i);
		end
	end

	-- DPS label --
	DPSLabel = Turbine.UI.Label();
	DPSLabel:SetParent(optionsPanel);
	DPSLabel:SetText("DPS Label");
	DPSLabel:SetForeColor(color["golden"]);
	DPSLabel:SetSize(200, 30);
	DPSLabel:SetPosition(50, 180);
	DPSLabelTextbox = Turbine.UI.TextBox();
	DPSLabelTextbox:SetParent(optionsPanel);
	DPSLabelTextbox:SetSize(240, 20);
	DPSLabelTextbox:SetPosition(50, 200);
	DPSLabelTextbox:SetText(textLabel);
	DPSLabelTextbox:SetMultiline(false);
	DPSLabelTextbox:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	DPSLabelTextbox:SetFont(Turbine.UI.Lotro.Font.Verdana14);
	DPSLabelTextbox:SetForeColor(color["black"]);
	DPSLabelTextbox:SetBackColor(color["white"]);

	-- Save settings button --
	saveSettingsButton = Turbine.UI.Lotro.Button();
	saveSettingsButton:SetText("Save Settings");
	saveSettingsButton:SetParent(optionsPanel);
	saveSettingsButton:SetSize(250, 20);
	saveSettingsButton:SetPosition(50, 260);
	saveSettingsButton:SetZOrder(100);
	saveSettingsButton.Click = function( sender, args)
		isLocked = lockPositionCheckbox:IsChecked();
		textLabel = DPSLabelTextbox:GetText();
		fontSize = fontSizeDropdown:GetValue();
		GroupDPSWindow.UpdateFontSize();
		saveData();
		notification("Settings have been saved!");
	end


	-- Troubleshoot title --
	troubleshootTitle = Turbine.UI.Label();
	troubleshootTitle:SetParent(optionsPanel);
	troubleshootTitle:SetText("Troubleshoot");
	troubleshootTitle:SetSize(400, 30);
	troubleshootTitle:SetPosition(0, 345);
	troubleshootTitle:SetFont(Turbine.UI.Lotro.Font.TrajanPro18);
	troubleshootTitle:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
	troubleshootTitle:SetForeColor(color["yellow"]);
	troubleshootTitle:SetFontStyle(Turbine.UI.FontStyle.Outline);
	troubleshootTitle:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	troubleshootTitle:SetBackground(Turbine.UI.Graphic("GroupDPS/Images/optionsTitleBackground.tga"));

	-- Local time offscreen help button --
	resetPositionButton = Turbine.UI.Lotro.Button();
	resetPositionButton:SetText("Reset Position");
	resetPositionButton:SetParent(optionsPanel);
	resetPositionButton:SetSize(250, 20);
	resetPositionButton:SetPosition(50, 400);
	resetPositionButton:SetZOrder(100);
	resetPositionButton.Click = function( sender, args)
		leftPos = (screenWidth / 2) - 50;
		topPos = screenHeight / 2;
		GroupDPSWindow:SetPosition(leftPos, topPos);
		notification("Position has been resetted.");
	end


	-- Return View --
	return optionsPanel;
end
