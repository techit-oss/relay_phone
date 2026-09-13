Relay.Phone = Relay.Phone or {}

local isPhoneOpen = false

local function setFocus(hasFocus)
    SetNuiFocus(hasFocus, hasFocus)

    if SetNuiFocusKeepInput then
        SetNuiFocusKeepInput(hasFocus and RelayConfig.Nui.KeepInput or false)
    end
end

local function sendVisibility(visible)
    SendNUIMessage({
        type = 'relay_phone:setVisible',
        visible = visible
    })
end

function Relay.Phone.IsOpen()
    return isPhoneOpen
end

function Relay.Phone.Open()
    if isPhoneOpen then
        return
    end

    isPhoneOpen = true
    setFocus(true)
    sendVisibility(true)
end

function Relay.Phone.Close()
    if not isPhoneOpen then
        return
    end

    isPhoneOpen = false
    sendVisibility(false)
    setFocus(false)
end

function Relay.Phone.Toggle()
    if isPhoneOpen then
        Relay.Phone.Close()
    else
        Relay.Phone.Open()
    end
end

RegisterNUICallback('relay_phone:close', function(_, cb)
    Relay.Phone.Close()
    cb({ ok = true })
end)

RegisterNUICallback('relay_phone:getBootstrap', function(_, cb)
    local success, response = pcall(function()
        return lib.callback.await('relay_phone:server:getBootstrap', false)
    end)

    if success and response then
        cb(response)
        return
    end

    cb({
        ok = false,
        error = 'bootstrap_failed'
    })
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= Relay.ResourceName then
        return
    end

    isPhoneOpen = false
    setFocus(false)
end)
