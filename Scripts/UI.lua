GroupDPSFrame = class(Turbine.UI.Window)

 function GroupDPSFrame:Constructor()

	Turbine.UI.Window.Constructor(self)

	-- Main window
	self:SetSize(200, 40)
	self:SetPosition(leftPos, topPos)
	self:SetBackColor(Turbine.UI.Color(0, 0, 0, 0))
	self:SetZOrder(0)
	self:SetVisible(true)
	self:SetWantsKeyEvents(true)
	self:SetMouseVisible(not isLocked)
	self:SetWantsUpdates(true)
	self.updatelimiter = 9999
	self.Update = function()

		-- Limit the amount of calls we are doing --
		self.updatelimiter = self.updatelimiter + 1
		if (self.updatelimiter < 60) then return end
		self.updatelimiter = 0

		if groupDPSCalculationStarted then

			local sampleCount = 0
			for _ in pairs(moraleSamples) do
				sampleCount = sampleCount + 1
			end

			if sampleCount >= 2 then
				CalculateGroupDPS()
			end
		end
	end

	-- Raid DPS Label
	self.raidDPSLabel = Turbine.UI.Label()
	self.raidDPSLabel:SetParent(self)
	self.raidDPSLabel:SetSize(self:GetWidth(), self:GetHeight())
	self.raidDPSLabel:SetPosition(0, 0)
	self.raidDPSLabel:SetMultiline(false)
	self.raidDPSLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	self.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana14)
	self.raidDPSLabel:SetFontStyle(Turbine.UI.FontStyle.Outline)
	self.raidDPSLabel:SetForeColor(Turbine.UI.Color(0.8,0.8,0.8))
	self.raidDPSLabel:SetOutlineColor(Turbine.UI.Color(1, 0, 0, 0))
	self.raidDPSLabel:SetMouseVisible(not isLocked)

	self.raidDPSLabel.MouseDown = function(sender, args)
		self.mouseDown_MousePosition = {Turbine.UI.Display.GetMousePosition()}
		self.mouseDown_WindowPosition = {self:GetPosition()}
		self.isMouseDown = true
	end

	self.raidDPSLabel.MouseUp = function(sender, args)
		self.isMouseDown = false
	end

	self.raidDPSLabel.MouseMove = function(sender, args)
		if (self.isMouseDown and not isLocked) then
			local mouseDownX, mouseDownY = unpack(self.mouseDown_MousePosition)
			local mouseCurrentX, mouseCurrentY = Turbine.UI.Display.GetMousePosition()
			local windowLeft, windowTop = unpack(self.mouseDown_WindowPosition)
			local displayWidth, displayHeight = Turbine.UI.Display:GetSize()

			if (mouseCurrentX > displayWidth) then mouseCurrentX = displayWidth end
			if (mouseCurrentY > displayHeight) then mouseCurrentY = displayHeight end

			local deltaX = mouseCurrentX - mouseDownX
			local deltaY = mouseCurrentY - mouseDownY

			topPos = windowTop + deltaY
			leftPos = windowLeft + deltaX

			self:SetPosition(leftPos, topPos)
		end
	end
end


-- Toggle visibility when HUD is toggled --
function GroupDPSFrame:KeyDown(args)
    if (args.Action == 268435635) then
        self:SetVisible(not self:IsVisible())
    end
end


-- Update font size --
function GroupDPSFrame:UpdateFontSize()
	if (fontSize == "10") then self.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana10)
	elseif (fontSize == "12") then self.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana12)
	elseif (fontSize == "14") then self.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana14)
	elseif (fontSize == "16") then self.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16)
	elseif (fontSize == "18") then self.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana18)
	elseif (fontSize == "20") then self.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana20)
	elseif (fontSize == "22") then self.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana22)
	elseif (fontSize == "23") then self.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana23)
	else self.raidDPSLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16)
	end
end
