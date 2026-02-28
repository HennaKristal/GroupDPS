local type = type
local tableInsert = table.insert

function AddCallback(object, event, callback)
    local current = object[event]
    if current == nil then
        object[event] = callback
        return callback
    end

    if type(current) == "table" then
        tableInsert(current, callback)
        return callback
    end

    object[event] = { current, callback }
    return callback
end

function RemoveCallback(object, event, callback)
    local current = object[event]
    if current == nil then
        return
    end

    if current == callback then
        object[event] = nil
        return
    end

    if type(current) ~= "table" then
        return
    end

    local count = #current
    for index = 1, count do
        if current[index] == callback then
            current[index] = current[count]
            current[count] = nil
            count = count - 1

            if count == 1 then
                object[event] = current[1]
            elseif count == 0 then
                object[event] = nil
            end
            return
        end
    end
end
