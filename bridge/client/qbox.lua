Relay.RegisterBridge('client', 'qbox', function()
    local bridge = {}

    function bridge.GetPlayerData()
        if not Relay.IsResourceActive('qbx_core') then
            return nil
        end

        local success, playerData = pcall(function()
            return exports.qbx_core:GetPlayerData()
        end)

        if success then
            return playerData
        end

        return nil
    end

    function bridge.Notify(message, notifyType)
        if lib and lib.notify then
            lib.notify({
                title = 'Relay',
                description = message,
                type = notifyType or 'inform'
            })
        end
    end

    return bridge
end)
