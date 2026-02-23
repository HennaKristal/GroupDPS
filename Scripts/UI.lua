groupDPSFrame = class(Turbine.UI.Window)

 function groupDPSFrame:Constructor()

	Turbine.UI.Window.Constructor(self)

	self.TARGET = localPlayer:GetTarget()
	self:SetSize(200, 40);
	self:SetPosition(leftPos, topPos)
	self:SetBackColor(Turbine.UI.Color(0, 0, 0, 0));
	self:SetZOrder(0);
	self:SetVisible(true);
	self:SetWantsKeyEvents(true);
	self:SetMouseVisible(not isLocked);

	-- Raid DPS Label
	self.raidDPSLabel = Turbine.UI.Label()
	self.raidDPSLabel:SetParent(self)
	self.raidDPSLabel:SetSize(self:GetWidth(), self:GetHeight())
	self.raidDPSLabel:SetPosition(0, 0);
	self.raidDPSLabel:SetMultiline(false);
	self.raidDPSLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
	self.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana14)
	self.raidDPSLabel:SetFontStyle(Turbine.UI.FontStyle.Outline);
	self.raidDPSLabel:SetForeColor(Turbine.UI.Color(0.8,0.8,0.8))
	self.raidDPSLabel:SetOutlineColor(Turbine.UI.Color(1, 0, 0, 0));
	self.raidDPSLabel:SetMouseVisible(not isLocked);

	localPlayer.TargetChanged = function(sender, args)
		self:UpdateTarget(localPlayer:GetTarget())
	end

	self.raidDPSLabel.MouseDown = function(sender, args)
		self.mouseDown_MousePosition = {Turbine.UI.Display.GetMousePosition();}
		self.mouseDown_WindowPosition = {self:GetPosition();}
		self.isMouseDown = true;
	end

	self.raidDPSLabel.MouseUp = function(sender, args)
		self.isMouseDown = false;
	end

	self.raidDPSLabel.MouseMove = function(sender, args)
		if (self.isMouseDown and not isLocked) then
			local mouseDownX, mouseDownY = unpack(self.mouseDown_MousePosition);
			local mouseCurrentX, mouseCurrentY = Turbine.UI.Display.GetMousePosition();
			local windowLeft, windowTop = unpack(self.mouseDown_WindowPosition);
			local displayWidth, displayHeight = Turbine.UI.Display:GetSize();

			if (mouseCurrentX > displayWidth) then mouseCurrentX = displayWidth; end
			if (mouseCurrentY > displayHeight) then mouseCurrentY = displayHeight; end

			local deltaX = mouseCurrentX - mouseDownX;
			local deltaY = mouseCurrentY - mouseDownY;

			topPos = windowTop + deltaY;
			leftPos = windowLeft + deltaX;

			self:SetPosition(leftPos, topPos);
		end
	end
end


function groupDPSFrame:KeyDown(args)
    -- Toggle visibility when HUD is toggled --
    if (args.Action == 268435635) then
        self:SetVisible(not self:IsVisible());
    end
end


function groupDPSFrame:UpdateFontSize()
	if (fontSize == "10") then groupDPSWindow.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana10);
	elseif (fontSize == "12") then groupDPSWindow.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana12);
	elseif (fontSize == "14") then groupDPSWindow.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana14);
	elseif (fontSize == "16") then groupDPSWindow.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16);
	elseif (fontSize == "18") then groupDPSWindow.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana18);
	elseif (fontSize == "20") then groupDPSWindow.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana20);
	elseif (fontSize == "22") then groupDPSWindow.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana22);
	elseif (fontSize == "23") then groupDPSWindow.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana23);
	else groupDPSWindow.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16);
	end
end


function groupDPSFrame:UpdateTarget(newTarget)

	if self.TARGET then
		RemoveCallback(self.TARGET, "MoraleChanged", MoraleChangedHandler)
		RemoveCallback(self.TARGET, "BaseMaxMoraleChanged", MoraleChangedHandler)
		RemoveCallback(self.TARGET, "MaxMoraleChanged", MoraleChangedHandler)
	end

	self.TARGET = newTarget
	groupDPSCalculationStarted = false

	self.raidDPSLabel:SetText(textLabel .. " 0K")

	if self.TARGET then
		if self.TARGET.GetLevel ~= nil and self.TARGET:GetLevel() > 1 then
			AddCallback(self.TARGET, "MoraleChanged", MoraleChangedHandler)
			AddCallback(self.TARGET, "BaseMaxMoraleChanged", MoraleChangedHandler)
			AddCallback(self.TARGET, "MaxMoraleChanged", MoraleChangedHandler)
			MoraleChangedHandler(self);
		else
			self.raidDPSLabel:SetText("")
		end
	else
		self.raidDPSLabel:SetText("")
	end
end
