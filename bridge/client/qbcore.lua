Relay.RegisterBridge('client', 'qbcore', function()
    local bridge = {}
    local coreObject = nil

    local function getCoreObject()
        if coreObject then
            return coreObject
        end

        if not Relay.IsResourceActive('qb-core') then
            return nil
        end

        local success, result = pcall(function()
            return exports['qb-core']:GetCoreObject()
        end)

        if success then
            coreObject = result
        end

        return coreObject
    end

    function bridge.GetPlayerData()
        local core = getCoreObject()

        if not core or not core.Functions or not core.Functions.GetPlayerData then
            return nil
        end

        return core.Functions.GetPlayerData()
    end

    function bridge.Notify(message, notifyType)
        local core = getCoreObject()

        if core and core.Functions and core.Functions.Notify then
            core.Functions.Notify(message, notifyType or 'primary')
        elseif lib and lib.notify then
            lib.notify({
                title = 'Relay',
                description = message,
                type = notifyType or 'inform'
            })
        end
    end

    -- TODO: Expand once Relay starts consuming QBCore-specific lifecycle events.
    return bridge
end)
