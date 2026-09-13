Relay.RegisterBridge('server', 'standalone', function()
    local bridge = {}

    local function getPrimaryIdentifier(source)
        local license = GetPlayerIdentifierByType(source, 'license')

        if license then
            return license
        end

        for index = 0, GetNumPlayerIdentifiers(source) - 1 do
            local identifier = GetPlayerIdentifier(source, index)

            if identifier then
                return identifier
            end
        end

        return nil
    end

    function bridge.GetIdentifier(source)
        return getPrimaryIdentifier(source)
    end

    function bridge.GetCharacterName(source)
        return GetPlayerName(source)
    end

    -- TODO: Replace this with a custom server bridge for production frameworks.
    return bridge
end)
