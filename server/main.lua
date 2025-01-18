
-------------------- ServerSIde ----------------

local rne = RegisterNetEvent
local tce = TriggerClientEvent

rne('Zaaa:server:Impound')
AddEventHandler('Zaaa:server:Impound', function (model, plate, reason, p, jam, menit)
    local insert = MySQL.insert.await('INSERT INTO `zaaa_impound` (reason, pengirim, model, plate) VALUES (?, ?, ?, ?)', {
        reason, p, model, plate
    })
    print(insert)
end)

--------------------- 2 ---------------------------------

lib.callback.register('Zaaa:server:Impound', function ()
    local ahh = MySQL.query.await('SELECT * FROM `zaaa_impound`')
    return ahh
end)

rne('Zaaa:impound:remove')
AddEventHandler('Zaaa:impound:remove', function(vehicleId)
    local src = source
    local vehicleData = MySQL.query.await('SELECT * FROM zaaa_impound WHERE id = ?', {vehicleId})

    if vehicleData[1] then
        local model = vehicleData[1].model
        local plate = vehicleData[1].plate

        local result = MySQL.query.await('DELETE FROM zaaa_impound WHERE id = ?', {vehicleId})
        
        if result.affectedRows > 0 then
            tce('Zaaa:Unlock', src, model, plate)
            print('Event client-side dipanggil dengan model: ' .. model .. ' dan plate: ' .. plate)
        else
            print('Gagal menghapus kendaraan dari impound.')
        end
    else
        print('Kendaraan tidak ditemukan di impound.')
    end
end)

