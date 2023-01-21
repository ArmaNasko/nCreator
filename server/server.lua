TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("nCreator:save")
AddEventHandler("nCreator:save", function(playerInfo)
    local src = source
    local player = ESX.GetPlayerFromId(src)

    MySQL.Sync.execute('UPDATE users SET firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, sex = @sex, height = @height WHERE identifier = @identifier', {
		['@identifier'] = player.identifier,
		['@firstname'] = playerInfo.firstName,
		['@lastname'] = playerInfo.lastName,
		['@dateofbirth'] = playerInfo.dateOfBirth,
		['@sex'] = playerInfo.sex,
		['@height'] = playerInfo.height
	})
end)

RegisterServerEvent("nCreator:setPlayerToBucket")
AddEventHandler("nCreator:setPlayerToBucket", function(id)
    SetPlayerRoutingBucket(source, id)
end)

RegisterServerEvent("nCreator:setPlayerToNormalBucket")
AddEventHandler("nCreator:setPlayerToNormalBucket", function()
    SetPlayerRoutingBucket(source, 0)
end)