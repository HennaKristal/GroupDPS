function init()
    groupDPSWindow = groupDPSFrame()

	LoadSettings()
	groupDPSWindow.UpdateFontSize();

    LoadPosition()
    groupDPSWindow:SetPosition(leftPos, topPos);
end

init();


function AddCallback(object, event, callback)
    if (object[event] == nil) then
        object[event] = callback;
    else
        if (type(object[event]) == "table") then
            table.insert(object[event], callback);
        else
            object[event] = {object[event], callback};
        end
    end
    return callback;
end

function RemoveCallback(object, event, callback)
    if (object[event] == callback) then
        object[event] = nil;
    else
        if (type(object[event]) == "table") then
            local size = table.getn(object[event]);
            for i = 1, size do
                if (object[event][i] == callback) then
                    table.remove(object[event], i);
                    break;
                end
            end
        end
    end
end


function TargetChangeHandler(sender, args)
    for key, frame in pairs (TargetFrames) do
        TargetFrame.UpdateTarget(frame)
    end
end


function MoraleChangedHandler(sender, args)

    local currentFrame = groupDPSWindow

    if not currentFrame.TARGET then
        return
    end

    if (currentFrame.TARGET:GetMorale() <= 0 or currentFrame.TARGET:GetMaxMorale() <= 0) then
        return
    end

    if currentFrame.TARGET:GetMorale() == currentFrame.TARGET:GetMaxMorale() then
        return
    end

    if not groupDPSCalculationStarted then
        ResetRaidDPS()
        return
    end

    CalculateGroupDPS(sender, args)
end


function ResetRaidDPS(sender, args)
    local currentFrame = groupDPSWindow
    groupDPSCalculationStarted = true;
    previousMorale = currentFrame.TARGET:GetMorale()
    previousTimestamp = Turbine.Engine:GetGameTime()
    DPS_1 = 0;
    DPS_2 = 0;
    DPS_3 = 0;
    DPS_4 = 0;
    DPS_5 = 0;
end


function CalculateGroupDPS(sender, args)

    local currentFrame = groupDPSWindow
    local currentMorale = currentFrame.TARGET:GetMorale()
    local currentTimestamp = Turbine.Engine:GetGameTime()
    local timeDelta = currentTimestamp - previousTimestamp

    if currentMorale > previousMorale then
        ResetRaidDPS()
        return
    end

    if timeDelta < DPSMinUpdateTime then
        return
    end

    local dpsValue = (previousMorale - currentMorale) / timeDelta

    if DPS_1 == 0 then
        DPS_1 = dpsValue
    elseif DPS_2 == 0 then
        DPS_2 = dpsValue
    elseif DPS_3 == 0 then
        DPS_3 = dpsValue
    elseif DPS_4 == 0 then
        DPS_4 = dpsValue
    elseif DPS_5 == 0 then
        DPS_5 = dpsValue
    else
        DPS_1 = DPS_2
        DPS_2 = DPS_3
        DPS_3 = DPS_4
        DPS_4 = DPS_5
        DPS_5 = dpsValue
    end

    local total = 0
    local count = 0

    if DPS_1 > 0 then
        total = total + DPS_1
        count = count + 1
    end

    if DPS_2 > 0 then
        total = total + DPS_2
        count = count + 1
    end

    if DPS_3 > 0 then
        total = total + DPS_3
        count = count + 1
    end

    if DPS_4 > 0 then
        total = total + DPS_4
        count = count + 1
    end

    if DPS_5 > 0 then
        total = total + DPS_5
        count = count + 1
    end

    if count > 0 then
        local averageDps = total / count

        
        currentFrame.raidDPSLabel:SetText(textLabel .. " " .. FormatDPS(averageDps));
    else
        currentFrame.raidDPSLabel:SetText("")
    end

    previousMorale = currentMorale
    previousTimestamp = currentTimestamp
end


function FormatDPS(value)
    if value < 1000 then
        return tostring(math.floor(value))
    elseif value > 1000000 then
        return string.format("%.2f", value / 1000000) .. "M"
    else
        return tostring(math.floor(value / 1000)) .. "K"
    end
end
