lib.callback.register('relay_phone:server:getBootstrap', function(source)
    return Relay.PhoneIdentity.GetBootstrapForSource(source)
end)
