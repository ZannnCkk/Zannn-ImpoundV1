    local rne = RegisterNetEvent
    local tse = TriggerServerEvent

    local terkunci = {}


    rne('Police:open')
    AddEventHandler('Police:open', function ()
        lib.callback('Zaaa:server:Impound', false, function(data)
            if #data > 0 then
                local context = {}
                for k, v in pairs(data) do
                    if terkunci[v.id] == nil then
                        terkunci[v.id] = true
                    end
                    table.insert(context, {
                        title = string.format('Plat: %s | Model: %s', v.plate, v.model),
                        description = string.format('Pengirim: %s | Reason: %s', v.pengirim, v.reason),
                        args = v.id,
                        onSelect = function ()

                            lib.registerContext({
                                id = 'menupolice1',
                                title = '🚗 Vehicle mneu 🚗',
                                menu = 'menupolice',
                                options = {
                                    
                                    {
                                        title = 'Kembali ke menu utama',
                                        onSelect = function()
                                            lib.showContext('open') 
                                        end
                                    },
                                    {   
                                        title = 'Kendraan Terkunci',
                                        description = 'Buka Kunci Kendraan?.',
                                        disabled = not terkunci[v.id],
                                        onSelect = function()
                                            local alert = lib.alertDialog({
                                                header = 'Buka Kunci Kendraa?',
                                                content = 'Click Confrim To Open',
                                                centered = true,
                                                cancel = true
                                            })

                                            if alert == 'confirm' then
                                                if lib.progressBar({
                                                    duration = 5000,
                                                    label = 'Membuka Impound Kendraan',
                                                    useWhileDead = true,
                                                    canCancel = true,
                                                    disable = {
                                                        car = true,
                                                        move = true,
                                                        combat = true
                                                    },
                                                    anim = {
                                                        dict = 'missheistdockssetup1clipboard@base',
                                                        clip = 'base'
                                                    },
                                                    
                                                }) then 
                                                    lib.notify({title = 'Success', description = 'Kendraan Terbuka.', type = 'success'})
                                                    terkunci[v.id] = false
                                            
                                                else
                                                    lib.notify({title = 'Success', description = 'Anda Membatalkan.', type = 'success'})
                                            
                                                end
                                                
                                            end
                                        end
                                    },
                                }
                            })
                            lib.showContext('menupolice1')

                        end
                    })
                end

                lib.registerContext({
                    id = 'open',
                    title = '👮‍♂️ Open Impound 👮‍♀️',
                    menu = 'open1',
                    options = context
                })
                lib.showContext('open')
            else
                local message = 'Impound Kosong'
                lib.notify({title = 'Police', description = message, type = 'error'})

            end
        end)



    end)

    function progres(model, plate, reason, vehicle, p, jam, number)
        if lib.progressBar({
            duration = 5000,
            label = 'Mengirim Kendraan Ke Impound',
            useWhileDead = true,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true
            },
            anim = {
            dict = 'mini@repair',
                clip = 'fixing_a_player'

            },
            
        }) then 
            DeleteVehicle(vehicle)
            tse('Zaaa:server:Impound', model, plate, reason, p, jam, number)
            lib.notify({title = 'Success', description = 'Kendraan Telah Di Kirim Ke Impound.', type = 'success'})

        else
            lib.notify({title = 'Success', description = 'Anda Membatalkan.', type = 'success'})

        end
        
    end

    -----🚗
    rne('Zaaa:Impound') 
    AddEventHandler('Zaaa:Impound', function ()
        local input = lib.inputDialog('🚨 Vehicle Impound 🚨', {
            {type = 'input', label = 'Reason', description = 'Alasan impound', required = true, min = 4, max = 100},
            {type = 'number', label = 'Durasi (Jam)', description = 'Berapa jam kendaraan akan diimpound?', required = true, icon = 'clock'},
            {type = 'number', label = 'Durasi (Menit)', description = 'Berapa menit tambahan?', required = true, icon = 'clock'},
            {type = 'checkbox', label = 'Hanya Police Yang Dapat Mengambil Kendraan?'},
        })

        -------------- BERANTKAN ZONE -----------
        ---
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local vehicle = GetClosestVehicle(pedCoords.x, pedCoords.y, pedCoords.z, 5.0, 0, 70)
        local playername = GetPlayerName(PlayerId())
        

        local jam = tonumber(input[2]) or 0
        local number = tonumber(input[3]) or 0
        

        local p = playername
        if (IsPedInAnyVehicle(ped, false)) then
            return
        end

        if vehicle ~= nil then
            local prop = ESX.Game.GetVehicleProperties(vehicle)
            local model = prop.model
            local plate = prop.plate
            local reason = input[1]
            local owner = prop.owner
            progres(model, plate, reason, vehicle, p, jam, number)
        end

    end)

    ------------ FUNGSI MENGHAPUS KENDRAAAAAAAN --------------

    -------------------- 2 ------------------------


    rne('Zannn:client:menu')
    AddEventHandler('Zannn:client:menu', function()
        lib.callback('Zaaa:server:Impound', false, function(data)
            if #data > 0 then
                local simpen = {}
                for k, v in pairs(data) do
                    if terkunci[v.id] == nil then
                        terkunci[v.id] = true
                    end
                    table.insert(simpen, {
                        title = string.format('Plat: %s | Model: %s', v.plate, v.model),
                        description = string.format('Pengirim: %s | Reason: %s', v.pengirim, v.reason),
                        args = v.id,
                        onSelect = function(vehicleid)
                            lib.registerContext({
                                id = 'newContext',
                                title = '🚗 Vehicle Removed 🚗',
                                menu = 'newMenu',
                                options = {
                                    
                                    {
                                        title = 'Kembali ke menu utama',
                                        onSelect = function()
                                            lib.showContext('mneu') 
                                        end
                                    },
                                    {
                                        title = text,
                                        description = 'Terkunci Hinga',
                                        disabled = terkunci[v.id],
                                        onSelect = function()
                                        tse('Zaaa:impound:remove', vehicleid)
                                            lib.notify({title = 'Success', description = 'Kendaraan berhasil dikeluarkan.', type = 'success'})
                                            terkunci[v.id] = false
                                        end
                                    },
                                }
                            })
                            lib.showContext('newContext')
                        end
                    })
                end
                -- Menampilkan menu utama
                lib.registerContext({
                    id = 'mneu',
                    title = '🚗 List Vehicle Impound 🚗',
                    menu = 'ahh',
                    options = simpen
                })
                lib.showContext('mneu')
            else
                local message = 'Tidak Ada Kendaraan Di Impound'
                if Zannn.Notify == 'ox_lib' then
                    lib.notify({title = 'Police', description = message, type = 'error'})
                end
            end
        end)
    end)



    rne('Zaaa:Unlock')
    AddEventHandler('Zaaa:Unlock', function (model, plate)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        local modelID = tonumber(model)  

        local name = GetDisplayNameFromVehicleModel(modelID)

        print(name)

        ESX.Game.SpawnVehicle(modelID, 
    { x = pedCoords.x, y = pedCoords.y, z = pedCoords.z}, 0.0, function (vehicle)
        TaskWarpPedIntoVehicle(ped, vehicle, -1)

        
    end)

    end)