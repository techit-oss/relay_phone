Relay.RegisterBridge('server', 'esx', function()
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

    local function getPlayer(source)
        local esx = getSharedObject()

        if not esx or not esx.GetPlayerFromId then
            return nil
        end

        return esx.GetPlayerFromId(source)
    end

    function bridge.GetIdentifier(source)
        local player = getPlayer(source)

        if not player then
            return nil
        end

        if player.getIdentifier then
            return player.getIdentifier()
        end

        return player.identifier
    end

    function bridge.GetCharacterName(source)
        local player = getPlayer(source)

        if player and player.getName then
            return player.getName()
        end

        return GetPlayerName(source)
    end

    -- TODO: Add ESX lifecycle hooks after the core phone behaviour is stable.
    return bridge
end)
