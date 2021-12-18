-- by. [Développeur] PX - G_Corporation | https://discord.gg/VpYP58ZjmD   
   
--------------------------------------------------------------------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local lancer = false
local count = nil 
local mainMenu = RageUI.CreateMenu('GoFast', 'interaction')
mainMenu.Closed = function()
	lancer = false
end

RegisterNetEvent("gofast:count")
AddEventHandler("gofast:count", function(_count)
	count = _count
end)

function gofastmenu()
    if lancer then 
        lancer = false
        RageUI.Visible(mainMenu, false)
        return
    else
        lancer = true 
        RageUI.Visible(mainMenu, true)
        CreateThread(function()
			while count == nil do 
				Wait(1000)
				count = 1	
			end
       		while lancer do 
           		RageUI.IsVisible(mainMenu,function() 
            		RageUI.Button("Lancer le GoFast", "Nombre de Gofast disponible : ~b~"..count.."", {RightLabel = "→"}, true , {
              		 	onSelected = function()
                			if count > 0 then
                  				TriggerServerEvent("gofast:remove")
				            	SpawnDuVehicule()
				            	gofastvente()
                  				RageUI.CloseAll()
								lancer = false
				            	Citizen.Wait(10*2000)
			    	        	ESX.ShowAdvancedNotification("Complice", "~r~Message du Complice", "Dépêche toi ! Une taupe t'as balancé aux poulets !", "CHAR_MP_ROBERTO", 7)
                			else
                  				ESX.ShowNotification("Aucune voiture disponible reviens après")
                			end
               			end
            		})			   
           		end)
         	Wait(0)
        	end
     	end)
  	end
end

local menugofast = {{x = 95.86, y = -2216.29, z = 5.17}}

Citizen.CreateThread(function()
    while true do
      	local wait = 900
        for k in pairs(menugofast) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, menugofast[k].x, menugofast[k].y, menugofast[k].z)
            if dist <= 2.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~r~E~w~] pour lancer un ~r~GoFast", 1)
                if IsControlJustPressed(1,51) then
					gofastmenu()
           		end
        	end
        end
    Citizen.Wait(wait)
	end
end)

local SpawnVehicule = {coords = vector3(90.41, -2217.37, 5.04)}

function SpawnDuVehicule()
	local ped = PlayerPedId()
	local spawn = ESX.Game.IsSpawnPointClear(SpawnVehicule.coords, 2.0)
	if spawn then
		ESX.Game.SpawnVehicle(0x6322B39A, SpawnVehicule.coords, 353.13, function(veh)
		SwitchInPlayer(PlayerPedId())
		RequestModel(0x6322B39A)
		SetVehicleNumberPlateText(veh, 'GOFAST')
		SetVehicleEnginePowerMultiplier(veh, 2.0 * 20.0)
		SetModelAsNoLongerNeeded(veh)
		SetVehicleAsNoLongerNeeded(veh)
		TaskEnterVehicle(PlayerPedId(), veh, 1000, -1, 1.0, 1, 0)
		TriggerServerEvent("pgofast:messagelspd")
		TriggerServerEvent("pgofast:messagebcso")
		end)
	else
		ESX.ShowNotification("Il y'a déjà un véhicule")
	end
end

function gofastvente()
	SetNewWaypoint(-114.77, 6368.91, 31.52)
end

local vente = false 
local mainMenu2 = RageUI.CreateMenu('Garage', 'interaction')
mainMenu2.Closed = function()
	vente = false
end

function gofastventemenu()
    if vente then 
        vente = false
        RageUI.Visible(mainMenu2, false)
        return
    else
        vente = true 
        RageUI.Visible(mainMenu2, true)
        CreateThread(function()
        	while vente do 
           		RageUI.IsVisible(mainMenu2,function() 
            		RageUI.Button("Vendre le Véhicule", nil, {RightLabel = "→"}, true , {
               			onSelected = function()	
							FinDeGoFast()
                			RageUI.CloseAll()
							vente = false
               			end
            		})  
           		end)
         	Wait(0)
        	end
    	end)
  	end
end

local vente = {{x = -114.77, y = 6368.91, z = 31.52}}

Citizen.CreateThread(function()
    while true do
      local wait = 900
        for k in pairs(vente) do	
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, vente[k].x, vente[k].y, vente[k].z)        
            if dist <= 2.0 then
               wait = 0			   
                Visual.Subtitle("Appuyez sur [~r~E~w~] pour intéragir avec ~r~l'incconu", 1) 
                if IsControlJustPressed(1,51) then
					gofastventemenu()
           		end
        	end
        end
    Citizen.Wait(wait)
	end
end)

function FinDeGoFast()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn( ped, false )
	local plate = GetVehicleNumberPlateText(vehicle)
	if plate == ' GOFAST ' then
		
		ESX.Game.DeleteVehicle(vehicle)
		ESX.ShowAdvancedNotification("GoFast", "~r~Inconnu", "Vehicule reçu ! tu recevra bientot l'argent !", "CHAR_MULTIPLAYER", 7)
		Citizen.Wait(10*1000)
		TriggerServerEvent("gofast:venteduvehicle")
		Wait(10)
		local playerPed = PlayerPedId()
	else
		ESX.ShowAdvancedNotification("GoFast", "~b~Inconnu", "Tu pense m'avoir comme ça ? dépeche toi avant que j'appelle les flics !", "CHAR_MULTIPLAYER", 7)

	end
end