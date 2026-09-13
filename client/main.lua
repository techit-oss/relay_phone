RegisterCommand(RelayConfig.OpenCommand, function()
    Relay.Phone.Toggle()
end, false)

RegisterKeyMapping(
    RelayConfig.OpenCommand,
    RelayConfig.OpenKeyDescription,
    'keyboard',
    RelayConfig.OpenKey
)

RegisterNetEvent('relay_phone:client:open', function()
    Relay.Phone.Open()
end)

RegisterNetEvent('relay_phone:client:close', function()
    Relay.Phone.Close()
end)

RegisterNetEvent('relay_phone:client:toggle', function()
    Relay.Phone.Toggle()
end)

exports('OpenPhone', function()
    Relay.Phone.Open()
end)

exports('ClosePhone', function()
    Relay.Phone.Close()
end)

exports('TogglePhone', function()
    Relay.Phone.Toggle()
end)

exports('IsPhoneOpen', function()
    return Relay.Phone.IsOpen()
end)
