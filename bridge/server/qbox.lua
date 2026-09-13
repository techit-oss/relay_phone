Relay.RegisterBridge('server', 'qbox', function()
    local bridge = {}

    local function getPlayer(source)
        if not Relay.IsResourceActive('qbx_core') then
            return nil
        end

        local success, player = pcall(function()
            return exports.qbx_core:GetPlayer(source)
        end)

        if success then
            return player
        end

        return nil
    end

    local function getPlayerData(source)
        local player = getPlayer(source)

        if not player then
            return nil
        end

        return player.PlayerData or player
    end

    function bridge.GetIdentifier(source)
        local playerData = getPlayerData(source)

        if not playerData then
            return nil
        end

        return playerData.citizenid
    end

    function bridge.GetCharacterName(source)
        local playerData = getPlayerData(source)

        if not playerData then
            return nil
        end

        local charInfo = playerData.charinfo or {}
        local firstName = charInfo.firstname or charInfo.firstName
        local lastName = charInfo.lastname or charInfo.lastName

        if firstName and lastName then
            return ('%s %s'):format(firstName, lastName)
        end

        return firstName or GetPlayerName(source)
    end

    return bridge
end)
