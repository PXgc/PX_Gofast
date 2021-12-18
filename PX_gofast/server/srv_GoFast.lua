

-- by. [Développeur] PX - G_Corporation | https://discord.gg/VpYP58ZjmD   
   
--------------------------------------------------------------------------------------

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("pgofast:messagelspd")
AddEventHandler("pgofast:messagelspd", function()
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          if xPlayer.job.name == 'lspd' then
               Citizen.Wait(0)
               TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Agent Infiltré', '~b~Message de l\'agent', 'D\'après mes infos, un Go Fast vient de démarrer. Restez vigilant et dirigez vous vers le nord !', 'CHAR_JOSEF', 7) 
		end
	end
end)

RegisterServerEvent("pgofast:messagebcso")
AddEventHandler("pgofast:messagebcso", function()
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          if xPlayer.job.name == 'sheriff' then
               Citizen.Wait(0)
               TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Agent Infiltré', '~b~Message de l\'agent', 'D\'après mes infos, un Go Fast vient de démarrer. Restez vigilant et dirigez vous vers le nord ! ', 'CHAR_JOSEF', 7)
		end
	end
end)

RegisterServerEvent("gofast:venteduvehicle")
AddEventHandler("gofast:venteduvehicle", function()
     local xPlayer = ESX.GetPlayerFromId(source)
     local prix = 10000
     xPlayer.addAccountMoney('black_money', prix)
     TriggerClientEvent('esx:showAdvancedNotification', source, 'GoFast', '~r~Inconnu', '~w~Le véhicule est en plutot bonne état, Vous avez gagné ~r~'..prix..'$', 'CHAR_MULTIPLAYER', 3)
end)

count = 1

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10*60000)
          count = 1
          TriggerClientEvent("gofast:count", -1, count)
	end
end)

RegisterServerEvent("gofast:remove")
AddEventHandler("gofast:remove", function()
     count = 0
     TriggerClientEvent("gofast:count", -1, count)
end)