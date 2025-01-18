local ah = 'csb_cop'
------------- PED ------------
CreateThread(function ()
    for _, v in pairs(Zannn.Ped) do
        local ped = GetHashKey(v.model)
        local x, y, z = v.coords

        RequestModel(ped)

        while not HasModelLoaded(ped) do
            Wait(5)
        end

        local npc = CreatePed(4, ped, x, y, z, 0.0, false, true)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetEntityAsMissionEntity(npc, true, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        
    end
end)

------------------ TARGET ZONE ------------------

if Zannn.Target == 'ox_target' then
    exports.ox_target:addGlobalVehicle({
        {
            label = 'Kirim Ke Impound',
            icon = 'fa fa-hand',
            groups = {
                [Zannn.Job.job] = Zannn.Job.Grade,
                [Zannn.Job.job2] = Zannn.Job.Grade2
            },
            event = 'Zaaa:Impound'
        }
    })

    

    ------------- Target 2 -------------
    exports.ox_target:addModel(ah, {
        {
            label = 'Cek Impound',
            icon = 'fa fa-hand',
            event = 'Zannn:client:menu'
        }
    })

    exports.ox_target:addModel(ah, {
        {
            label = 'Open Impound Menu',
            icon = 'fa fa-hand',
            event = 'Police:open'
        }
    })

    
elseif Zannn.Target == 'qtarget' then
    exports.qtarget:Vehicle({
        options = {
            {
                event = "Zaaa:Impound",
                icon = "fa fa-hand",
                label = "Kirim Ke Impound",
                groups = {
                    [Zannn.Job.job] = Zannn.Job.Grade,
                    [Zannn.Job.job2] = Zannn.Job.Grade2
                },
            }
        },
        distance = 1
    })
end





