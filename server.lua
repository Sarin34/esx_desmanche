-----------------------------------------------------------------------------------------------------------------------------------------
-- SCRIPT CREATED BY DISCORD : ! Jp#2263 | https://discord.gg/HEtBSAJuJU | EDITED AND CONVERTED BY DISCORD : Sarin#9926
-----------------------------------------------------------------------------------------------------------------------------------------

ESX              = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('sarin:checkvehicle', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1].owner == identifier then
			TriggerClientEvent('esx:showNotification', xPlayer.source,  'Você vão pode desmanchar seu proprio carro')
		else			
			cb(result[1] ~= nil)
		end
	end)
end)

RegisterServerEvent('jpcheckpegarporta')
AddEventHandler('jpcheckpegarporta', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("porta", 1)
end)

RegisterServerEvent('jpcheckpegarcapo')
AddEventHandler('jpcheckpegarcapo', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("capo", 1)
end)

RegisterServerEvent('jpcheckpegarmalas')
AddEventHandler('jpcheckpegarmalas', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("porta-malas", 1)
end)

RegisterServerEvent("peças-vender")
AddEventHandler("peças-vender",function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local data = xPlayer.getInventoryItem(item)
	if data.count > 0 then
		xPlayer.removeInventoryItem(item, data.count)
		xPlayer.addAccountMoney('black_money', data.count*Config.Valores[item].venda)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source,  'Você vão possui ' .. data.name .. " em sua mochila.")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SCRIPT CREATED BY DISCORD : ! Jp#2263 | https://discord.gg/HEtBSAJuJU | EDITED AND CONVERTED BY DISCORD : Sarin#9926
-----------------------------------------------------------------------------------------------------------------------------------------
