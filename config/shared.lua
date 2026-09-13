RelayConfig = RelayConfig or {}

RelayConfig.Framework = 'auto'
RelayConfig.FrameworkDetectionOrder = {
    'qbox',
    'qbcore',
    'esx',
    'standalone'
}

RelayConfig.OpenCommand = 'relayphone'
RelayConfig.OpenKey = 'M'
RelayConfig.OpenKeyDescription = 'Open Relay phone'

RelayConfig.Nui = {
    KeepInput = false
}

RelayConfig.Phone = {
    NumberPrefix = '555',
    NumberLength = 7,
    AssignmentMaxAttempts = 25
}

RelayConfig.Apps = {
    { id = 'phone', label = 'Phone', icon = 'phone' },
    { id = 'contacts', label = 'Contacts', icon = 'users' },
    { id = 'messages', label = 'Messages', icon = 'message-circle' },
    { id = 'settings', label = 'Settings', icon = 'settings' }
}
