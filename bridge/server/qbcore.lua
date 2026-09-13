Relay.RegisterBridge('server', 'qbcore', function()
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

    local function getPlayer(source)
        local core = getCoreObject()

        if not core or not core.Functions or not core.Functions.GetPlayer then
            return nil
        end

        return core.Functions.GetPlayer(source)
    end

    function bridge.GetIdentifier(source)
        local player = getPlayer(source)
        local playerData = player and player.PlayerData

        return playerData and playerData.citizenid or nil
    end

    function bridge.GetCharacterName(source)
        local player = getPlayer(source)
        local playerData = player and player.PlayerData
        local charInfo = playerData and playerData.charinfo or {}
        local firstName = charInfo.firstname
        local lastName = charInfo.lastname

        if firstName and lastName then
            return ('%s %s'):format(firstName, lastName)
        end

        return firstName or GetPlayerName(source)
    end

    -- TODO: Add QBCore lifecycle hooks after the core phone behaviour is stable.
    return bridge
end)
