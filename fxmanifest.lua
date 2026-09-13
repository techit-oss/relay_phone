fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'relay_phone'
author 'Relay Contributors'
description 'A free, open-source, modular FiveM phone resource.'
version '0.1.0'
license 'MIT'

ui_page 'web/dist/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    'config/shared.lua',
    'shared/init.lua'
}

client_scripts {
    'bridge/client/qbox.lua',
    'bridge/client/qbcore.lua',
    'bridge/client/esx.lua',
    'bridge/client/standalone.lua',
    'bridge/client/init.lua',
    'client/nui.lua',
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/server/qbox.lua',
    'bridge/server/qbcore.lua',
    'bridge/server/esx.lua',
    'bridge/server/standalone.lua',
    'bridge/server/init.lua',
    'server/services/phone_identity.lua',
    'server/main.lua'
}

files {
    'web/dist/index.html',
    'web/dist/assets/*.js',
    'web/dist/assets/*.css'
}

dependencies {
    'ox_lib',
    'oxmysql'
}
