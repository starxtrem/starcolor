-- Devlopped By Starxtrem --
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('starcolor:price', function(source, cb , money)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
if xPlayer.getMoney() >= money then
	xPlayer.removeMoney(money)
	cb(true)
else
	cb(false)
end

end)

AddEventHandler("esxStar:ReloadESX", function (obj)
	ESX = obj
end)


-- Devlopped By Starxtrem --
