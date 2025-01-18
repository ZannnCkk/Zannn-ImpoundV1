fx_version 'cerulean'
game 'gta5'
lua54 'yes'
name "Zaaa-Impound"
description "Zannn-Impound-V1/ESX"
author "Zannn"
version "1"

shared_scripts {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}
