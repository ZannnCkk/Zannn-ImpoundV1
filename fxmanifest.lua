fx_version 'cerulean'
game 'gta5'
lua54 'yes'
name "Zaaa-Impound"
description "Gabut"
author "Apaan"
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
