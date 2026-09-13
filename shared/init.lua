Relay = Relay or {}
Relay.ResourceName = GetCurrentResourceName()
Relay.FrameworkBridgeFactories = Relay.FrameworkBridgeFactories or {
    client = {},
    server = {}
}

Relay.FrameworkResources = {
    qbox = 'qbx_core',
    qbcore = 'qb-core',
    esx = 'es_extended'
}

function Relay.RegisterBridge(context, name, factory)
    assert(context == 'client' or context == 'server', 'invalid bridge context')
    assert(type(name) == 'string' and name ~= '', 'bridge name must be a non-empty string')
    assert(type(factory) == 'function', 'bridge factory must be a function')

    Relay.FrameworkBridgeFactories[context][name] = factory
end

function Relay.IsResourceActive(resourceName)
    if not resourceName or resourceName == '' then
        return false
    end

    local state = GetResourceState(resourceName)
    return state == 'started' or state == 'starting'
end

function Relay.ResolveFrameworkName()
    local configuredFramework = RelayConfig.Framework or 'auto'

    if configuredFramework ~= 'auto' then
        return configuredFramework
    end

    for _, frameworkName in ipairs(RelayConfig.FrameworkDetectionOrder or {}) do
        if frameworkName == 'standalone' then
            return 'standalone'
        end

        if Relay.IsResourceActive(Relay.FrameworkResources[frameworkName]) then
            return frameworkName
        end
    end

    return 'standalone'
end

function Relay.CreateFrameworkBridge(context)
    local frameworkName = Relay.ResolveFrameworkName()
    local factory = Relay.FrameworkBridgeFactories[context][frameworkName]

    if not factory then
        error(('No Relay %s bridge registered for framework "%s"'):format(context, frameworkName))
    end

    local bridge = factory()
    bridge.name = frameworkName

    return bridge
end

function Relay.Info(message)
    print(('[relay_phone] %s'):format(message))
end
