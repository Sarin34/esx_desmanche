-----------------------------------------------------------------------------------------------------------------------------------------
-- SCRIPT CREATED BY DISCORD : ! Jp#2263 | https://discord.gg/HEtBSAJuJU | EDITED AND CONVERTED BY DISCORD : Sarin#9926
-----------------------------------------------------------------------------------------------------------------------------------------

ESX              = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEL
-----------------------------------------------------------------------------------------------------------------------------------------

local etapa = 0
local menuactive = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "porta" then
		TriggerServerEvent("peças-vender","porta")
	elseif data == "capo" then
		TriggerServerEvent("peças-vender","capo")
	elseif data == "porta-malas" then
		TriggerServerEvent("peças-vender","porta-malas")
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local japa = 500
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1370.84,-2068.95,52.01,true)
		if distance <= 15 then
			japa = 5
			DrawMarker(21,1370.84,-2068.95,52.01-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if distance <= 1.2 then
				japa = 5
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
		Wait(japa)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES 
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    
    while true do 

        local source = source
        local ped = PlayerPedId()
        local carro = GetVehiclePedIsIn(ped, true)
        local x,y,z = GetEntityCoords(ped)
        
        for k,v in pairs(Config.Desmanche) do

            local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),v[1],v[2],v[3],true)

            if dist > 5 then
                Wait(1000)
            else
                DrawMarker(27, v[1],v[2],v[3]-0.96, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 0.5, 255, 0, 0, 50, false, false, 0, true)
                if IsPedInAnyVehicle(ped) == false then
                else
                    if dist <= 5 and etapa == 0 then
                        msg('APERTE ~b~E~w~ PARA COMEÇAR O DESMANCHE',4,0.5,0.93,0.50,255,255,255,180) 
                        if IsControlJustPressed(0, 46) and etapa == 0 then     
                            if Config.CarNPC == false  then                                     
                                ESX.TriggerServerCallback('sarin:checkvehicle', function(isPlayerVehicle)
                                    if isPlayerVehicle then
                                        etapa = 1
                                        SetEntityCoords(carro, 1376.32, -2064.28, 52.0-1)
                                        SetEntityHeading(carro, 39.45)
                                        FreezeEntityPosition(carro, true)
                                        for i = 0 , 7 do
                                            SetVehicleDoorOpen(carro, i, false, true)
                                        end
                                    else
                                        TriggerEvent('esx:showNotification', 'Você não pode desmanchar veículos de locais!')
                                    end
                                end, ESX.Math.Trim(GetVehicleNumberPlateText(carro)))
                            else
                                etapa = 1
                                SetEntityCoords(carro, 1376.32, -2064.28, 52.0-1)
                                SetEntityHeading(carro, 39.45)
                                FreezeEntityPosition(carro, true)
                                for i = 0 , 7 do
                                    SetVehicleDoorOpen(carro, i, false, true)
                                end
                            end
                        end 
                    end   
                end
            end

            if etapa == 1 then
                local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),Config.Texto[1],Config.Texto[2],Config.Texto[3],true)
                if dist > 3 then
                    Wait(1000)
                else
                    DrawText3Ds(Config.Texto[1],Config.Texto[2],Config.Texto[3]-1,' ~g~ PRESSIONE~w~ ~h~[E]~h~ ~g~PARA REMOVER A PORTA DO MOTORISTA~w~')
                    if IsControlJustPressed(0, 46) then
                        SetEntityCoords(ped,1374.24,-2064.1,52.0-1,true)
                        SetEntityHeading(ped, 248.7)                        
                        local lib, anim = "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector" 
                        ESX.Streaming.RequestAnimDict(lib, function()        
                        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 3000, 0, 0, false, false, false)
                        end)
                        Citizen.Wait(3000)
                        SetVehicleDoorBroken(carro, 0, false)
                        Wait(200)
                        ClearAreaOfEverything(x, y, z, 20.0, false, false, false, false)
                        etapa = 2
                        TriggerServerEvent("jpcheckpegarporta")
                    end
                end
            end
                
            if etapa == 2 then
                local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),Config.Texto[1],Config.Texto[2],Config.Texto[3],true)
                if dist <= 3 then
                    DrawText3Ds(Config.Texto[1],Config.Texto[2],Config.Texto[3]-1,' ~g~ PRESSIONE~w~ ~h~[E]~h~ ~g~PARA REMOVER A PORTA DO PASSAGEIRO DA FRENTE~w~')
                    if IsControlJustPressed(0, 46) then
                        SetEntityCoords(ped,1376.21,-2062.26, 52.0-1,true)
                        SetEntityHeading(ped, 194.9)     
                        ClearPedTasks(GetPlayerPed(-1))                
                        local lib, anim = "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector"         
                        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 3000, 0, 0, false, false, false)
                        Citizen.Wait(3000)
                        SetVehicleDoorBroken(carro, 1, false)
                        Wait(200)
                        ClearAreaOfEverything(x, y, z, 20.0, false, false, false, false)
                        etapa = 3
                        TriggerServerEvent("jpcheckpegarporta")
                    end
                end
            end
                
            if etapa == 3 then
                local portasTraseira = GetEntityBoneIndexByName(carro, 'door_dside_r')
                if portasTraseira ~= -1 then
                    Citizen.Wait(100000)
                    local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),Config.Texto[1],Config.Texto[2],Config.Texto[3],true)
                    if dist <= 3 then
                        DrawText3Ds(Config.Texto[1],Config.Texto[2],Config.Texto[3]-1,' ~g~ PRESSIONE~w~ ~h~[E]~h~ ~g~PARA REMOVER A PORTA ESQUERDA DE TRÁS~w~')
                        if IsControlJustPressed(0, 46) then
                            SetEntityCoords(ped,1374.96,-2064.73,52.0-1,true)
                            SetEntityHeading(ped, 242.8)
                            local lib, anim = "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector"         
                            TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 3000, 0, 0, false, false, false)
                            Citizen.Wait(3000)
                            SetVehicleDoorBroken(carro, 2, false)
                            Wait(200)
                            ClearAreaOfEverything(x, y, z, 20.0, false, false, false, false)
                            etapa = 4
                            TriggerServerEvent("jpcheckpegarporta")
                        end
                    end
                else
                    etapa = 5
                end              
            end
                
            if etapa == 4 then
                local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),Config.Texto[1],Config.Texto[2],Config.Texto[3],true)
                if dist <= 3 then
                    DrawText3Ds(Config.Texto[1],Config.Texto[2],Config.Texto[3]-1,' ~g~ PRESSIONE~w~ ~h~[E]~h~ ~g~PARA REMOVER A PORTA DIREITA DE TRÁS~w~')
                    if IsControlJustPressed(0, 46) then
                        SetEntityCoords(ped,1377.17,-2063.18,52.0-1,true)
                        SetEntityHeading(ped, 191.0)
                        local lib, anim = "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector"         
                        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 3000, 0, 0, false, false, false)
                        Citizen.Wait(3000)
                        SetVehicleDoorBroken(carro, 3, false)
                        Wait(200)
                        ClearAreaOfEverything(x, y, z, 20.0, false, false, false, false)
                        etapa = 5
                        TriggerServerEvent("jpcheckpegarporta")
                    end
                end
            end

            if etapa == 5 then
                local hood = GetEntityBoneIndexByName(carro, 'bonnet')                           
                if hood ~= -1 then
                    local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),Config.Texto[1],Config.Texto[2],Config.Texto[3],true)
                    if dist <= 3 then
                        DrawText3Ds(Config.Texto[1],Config.Texto[2],Config.Texto[3]-1,' ~g~ PRESSIONE~w~ ~h~[E]~h~ ~g~PARA REMOVER CAPO~w~')
                        if IsControlJustPressed(0, 46) then
                            SetEntityCoords(ped,1374.67,-2064.19,52.0-1,true)
                            SetEntityHeading(ped, 311.5)
                            local lib, anim = "mini@repair", "fixing_a_ped" 
                            ESX.Streaming.RequestAnimDict(lib, function()        
                            TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 3000, 0, 0, false, false, false)
                            end)
                            Citizen.Wait(3000)
                            SetVehicleDoorBroken(carro, 4, false)
                            Wait(200)
                            ClearAreaOfEverything(x, y, z, 20.0, false, false, false, false)
                            etapa = 6
                            TriggerServerEvent("jpcheckpegarcapo")
                        end
                    end
                else
                    etapa = 6
                end
            end      
            if etapa == 6 then
                local truck = GetEntityBoneIndexByName(carro, 'boot')
                if truck ~= -1 then
                    local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),Config.Texto[1],Config.Texto[2],Config.Texto[3],true)
                    if dist <= 3 then
                        DrawText3Ds(Config.Texto[1],Config.Texto[2],Config.Texto[3]-1,' ~g~ PRESSIONE~w~ ~h~[E]~h~ ~g~PARA REMOVER O PORTA-MALAS~w~')
                        if IsControlJustPressed(0, 46) then
                            SetEntityCoords(ped,1378.15,-2066.41,52.0-1,true)
                            SetEntityHeading(ped, 41.9)
                            local lib, anim = "mini@repair", "fixing_a_ped"         
                            TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 3000, 0, 0, false, false, false)
                            Citizen.Wait(3000)
                            SetVehicleDoorBroken(carro, 5, false)
                            Wait(200)
                            ClearAreaOfEverything(x, y, z, 20.0, false, false, false, false)
                            etapa = 0
                            ESX.ShowNotification('Você desmanchou o veículo tome seu dinheiro pela carcaça do carro')
                            DeleteVehicle(carro)                     
                        end
                    end
                else
                    etapa = 0
                    ESX.ShowNotification('Você desmanchou o veículo tome seu dinheiro pela carcaça do carro')
                    DeleteVehicle(carro)   
                end
            end  
        end
        Wait(1)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTRAS FUNÇÕES 
-----------------------------------------------------------------------------------------------------------------------------------------

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end

function msg(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCRIPT CREATED BY DISCORD : ! Jp#2263 | https://discord.gg/HEtBSAJuJU | EDITED AND CONVERTED BY DISCORD : Sarin#9926
-----------------------------------------------------------------------------------------------------------------------------------------
