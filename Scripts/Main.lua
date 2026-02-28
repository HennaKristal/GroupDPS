function UpdateTarget(newTarget)

	if currentTarget then
		RemoveCallback(currentTarget, "MoraleChanged", MoraleChangedHandler)
		RemoveCallback(currentTarget, "BaseMaxMoraleChanged", MoraleChangedHandler)
		RemoveCallback(currentTarget, "MaxMoraleChanged", MoraleChangedHandler)
	end

	currentTarget = newTarget
	groupDPSCalculationStarted = false

	groupDPSFrame.raidDPSLabel:SetText(textLabel .. " 0")

	if newTarget then
		if newTarget.GetLevel ~= nil and newTarget:GetLevel() > 1 then
			AddCallback(newTarget, "MoraleChanged", MoraleChangedHandler)
			AddCallback(newTarget, "BaseMaxMoraleChanged", MoraleChangedHandler)
			AddCallback(newTarget, "MaxMoraleChanged", MoraleChangedHandler)
			MoraleChangedHandler(newTarget)
		else
			groupDPSFrame.raidDPSLabel:SetText("")
		end
	else
		groupDPSFrame.raidDPSLabel:SetText("")
	end
end


function MoraleChangedHandler(sender, args)

    if not currentTarget then
        return
    end

    local currentMorale = currentTarget:GetMorale()
    local maxMorale = currentTarget:GetMaxMorale()

    if (currentMorale <= 0 or maxMorale <= 0) then
        return
    end

    if currentMorale == maxMorale then
        return
    end

    if not groupDPSCalculationStarted then
        ResetRaidDPS()
        return
    end

    UpdateMoraleTable()
    CalculateGroupDPS()
end


function ResetRaidDPS()
    groupDPSCalculationStarted = true
    moraleSamples = {[Turbine.Engine:GetGameTime()] = currentTarget:GetMorale()}
end


function UpdateMoraleTable()
    local currentTime = Turbine.Engine:GetGameTime()

    for timestamp, _ in pairs(moraleSamples) do
        if currentTime - timestamp > holdDurationSeconds then
            moraleSamples[timestamp] = nil
        end
    end

    moraleSamples[currentTime] = currentTarget:GetMorale()
end


function CalculateGroupDPS()
    local highestMorale = nil
    local highestMoraleTimestamp = nil
    local currentMorale = currentTarget:GetMorale()
    local currentTimestamp = Turbine.Engine:GetGameTime()
    local dpsValue = 0

    -- Find highest morale from samples
    for time, morale in pairs(moraleSamples) do
        if highestMorale == nil or morale > highestMorale then
            highestMorale = morale
            highestMoraleTimestamp = time
        end
    end

    -- Calculate DPS
    if highestMorale ~= nil then
        local timeDifference = math.abs(currentTimestamp - highestMoraleTimestamp)
        if timeDifference > minDPStime and highestMorale > currentMorale then
            dpsValue = (highestMorale - currentMorale) / timeDifference
        end
    end

    groupDPSFrame.raidDPSLabel:SetText(textLabel .. " " .. FormatDPS(dpsValue))
    groupDPSFrame.updatelimiter = 0;
end


function FormatDPS(value)
    if value < 1000 then
        return tostring(math.floor(value))
    end

    if value < 10000 then
        return string.format("%.1fK", value / 1000)
    end

    if value < 1000000 then
        return tostring(math.floor(value / 1000)) .. "K"
    end

    if value < 10000000 then
        return string.format("%.1fM", value / 1000000)
    end

    return tostring(math.floor(value / 1000000)) .. "M"
end
