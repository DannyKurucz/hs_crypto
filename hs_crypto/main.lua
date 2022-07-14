
ESX = nil -- ESX 

CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

local display = false
local shop = true
local btc = false
local test = 0
CreateThread(function()
	
  blip = AddBlipForCoord(cfg.blip['blipposition'])
  AddTextEntry('dasjdhausds', cfg.blip['blipname'])
  SetBlipSprite(blip, cfg.settings['sprite'])
  SetBlipColour(blip, cfg.settings['color'])
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 1.0)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName('dasjdhausds')
  EndTextCommandSetBlipName(blip)
  
end)


CreateThread(function()
	while true do
    cas = 1000
		local playerPed = GetPlayerPed(-1)
    local Coords = GetEntityCoords(PlayerPedId())
    local pos = (cfg.zones["shop"])
		local dist = #(Coords - pos)
    if dist < 3 then
      if shop then
        shop = true
        if shop == true then
          cas = 5
          ShowFloatingHelpNotification(""..cfg.translations["shop"]..test.."$", pos)
          if IsControlJustPressed(0, 38) and dist < 2 then
            shop = true
            TriggerServerEvent("hs_crypto:sell", test)
          end
        end
      end
    end
    Wait(cas)
	end
end)



ShowFloatingHelpNotification = function(msg, pos)
  AddTextEntry('text', msg)
  SetFloatingHelpTextWorldPosition(1, pos.x, pos.y, pos.z)
  SetFloatingHelpTextStyle(2, 1, 25, -1, 3, 0)
  BeginTextCommandDisplayHelp('text')
  EndTextCommandDisplayHelp(2, false, false, -1)
end



RegisterNetEvent('hs_crypto:open') 
AddEventHandler('hs_crypto:open', function()
  SetDisplay(not display)

end)
RegisterNetEvent('hs_crypto:game') 
AddEventHandler('hs_crypto:game', function()
  startAnim()
  Wait(2000)
  TriggerEvent("utk_fingerprint:Start", cfg.minigame["level"], cfg.minigame["lives"], cfg.minigame["minutes"], function(outcome, reason)
    if outcome == true then -- reason will be nil if outcome is true
      TriggerServerEvent("hs_crypto:win")
      Wait(1000)
      stopAnim()
    elseif outcome == false then
      Wait(1000)
      stopAnim()
      ESX.ShowNotification(cfg.translations["fail"])
    end
  end)
  stopAnim()
end)

RegisterNUICallback("exit", function()
  SetDisplay(false)
end)

RegisterNUICallback("buy", function()
  ESX.ShowNotification(""..cfg.translations["buybtc"]..test.."$")
  TriggerServerEvent("hs_crypto:buy", test)
end)

RegisterNUICallback("info", function()
  ESX.ShowNotification(""..cfg.translations["current"]..test.."$")
  btc = true
end)


Citizen.CreateThread(function()

  while true do
    Wait(2000)
    if(btc == false) then
      mathRandomSellPriceBTC(10000,99999)
      btc = true
    end
    Wait(cfg.timetochangeprice["time"])
    if(btc == true) then
      mathRandomSellPriceBTC(10000,99999)
      btc = true
    end



  end

end)



function mathRandomSellPriceBTC(min,max)
	test = math.random(min,max)
end


function SetDisplay(bool)
  display = bool
  SetNuiFocus(bool, bool)
  SendNUIMessage({
      type = "ui",
      status = bool,
  })
end

Citizen.CreateThread(function()
  while display do
      Citizen.Wait(0)
      DisableControlAction(0, 1, display)
      DisableControlAction(0, 2, display)
      DisableControlAction(0, 142, display)
      DisableControlAction(0, 18, display)
      DisableControlAction(0, 322, display)
      DisableControlAction(0, 106, display)
  end
end)

function startAnim()
	Citizen.CreateThread(function()
	  RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
	  while not HasAnimDictLoaded("amb@world_human_seat_wall_tablet@female@base") do
	    Citizen.Wait(0)
	  end
		attachObject()
		TaskPlayAnim(GetPlayerPed(-1), "amb@world_human_seat_wall_tablet@female@base", "base" ,8.0, -8.0, -1, 50, 0, false, false, false)
	end)
end

function attachObject()
	tab = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(tab, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, true, true, false, true, 1, true)
end

function stopAnim()
	StopAnimTask(GetPlayerPed(-1), "amb@world_human_seat_wall_tablet@female@base", "base" ,8.0, -8.0, -1, 50, 0, false, false, false)
	DeleteEntity(tab)
end