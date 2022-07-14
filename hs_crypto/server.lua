
ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

ESX.RegisterUsableItem(cfg.items["phone"], function(source)

    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('hs_crypto:open', source)

end)
ESX.RegisterUsableItem(cfg.items["usb"], function(source)

    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(cfg.items["usb"], 1)
    TriggerClientEvent('hs_crypto:game', source)

end)

RegisterNetEvent("hs_crypto:buy")
AddEventHandler("hs_crypto:buy", function(test)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.canCarryItem(cfg.items["btc"], 1) then
        xPlayer.addInventoryItem(cfg.items["btc"], 1)
        xPlayer.removeAccountMoney('bank', test)
    else
        TriggerClientEvent('esx:showNotification', source, cfg.translations["noplace"])

    end
end)

RegisterNetEvent("hs_crypto:sell")
AddEventHandler("hs_crypto:sell", function(test)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getInventoryItem(cfg.items["btc"]).count > 0 then
        xPlayer.removeInventoryItem(cfg.items["btc"], 1)
        xPlayer.addInventoryItem("money", test)
    else
        TriggerClientEvent('esx:showNotification', source, cfg.translations["nobtc"])

    end
end)
RegisterNetEvent("hs_crypto:win")
AddEventHandler("hs_crypto:win", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local random = math.random(cfg.wininminigame["countbtcrandom"])
    if xPlayer.canCarryItem(cfg.items["btc"], 1) then
        xPlayer.addInventoryItem(cfg.items["btc"], random)
        xPlayer.removeInventoryItem(cfg.items["usb"], 1)
    else
        TriggerClientEvent('esx:showNotification', source, cfg.translations["noplace"])

    end
end)

