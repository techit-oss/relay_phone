Relay.RegisterBridge('client', 'standalone', function()
    local bridge = {}

    function bridge.GetPlayerData()
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

    -- TODO: Provide hooks for custom frameworks without changing Relay core.
    return bridge
end)
