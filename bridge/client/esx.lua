Relay.RegisterBridge('client', 'esx', function()
    local bridge = {}
    local sharedObject = nil

    local function getSharedObject()
        if sharedObject then
            return sharedObject
        end

        if not Relay.IsResourceActive('es_extended') then
            return nil
        end

        local success, result = pcall(function()
            return exports.es_extended:getSharedObject()
        end)

        if success then
            sharedObject = result
        end

        return sharedObject
    end

    function bridge.GetPlayerData()
        local esx = getSharedObject()

        if not esx or not esx.GetPlayerData then
            return nil
        end

        return esx.GetPlayerData()
    end

    function bridge.Notify(message, notifyType)
        local esx = getSharedObject()

        if esx and esx.ShowNotification then
            esx.ShowNotification(message)
        elseif lib and lib.notify then
            lib.notify({
                title = 'Relay',
                description = message,
                type = notifyType or 'inform'
            })
        end
    end

    -- TODO: Expand once Relay starts consuming ESX-specific lifecycle events.
    return bridge
end)
