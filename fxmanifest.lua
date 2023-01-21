fx_version 'adamant'

game 'gta5'

author 'Nasko'

description 'nCreator'

version '1.0'

shared_scripts {
    "shared/*.lua"
}

server_scripts {
    "server/*.lua",
    '@mysql-async/lib/MySQL.lua',
}

client_scripts {
    "client/*.lua",

    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
}