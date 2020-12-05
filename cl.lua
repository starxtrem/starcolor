-- Devlopped By Starxtrem --
local achatok = false
ESX = nil

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)


function OpenMenu()
    local elems = {
        {label = 'Custom Xeon', value = 'open_list'},
        {label = 'Custom Turbo', value = 'open_list1'},

	}
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MenuCustom',{
        title = 'Menu custom',
        align = 'top-left',
        elements = elems
    },
    function(data, menu)
        if data.current.value == 'open_list' then 
        	ColourList()
		end
		if data.current.value == 'open_list1' then 
          	TurboList()
        end

    end,
    function(data, menu)
        menu.close()
    end)
end

function ColourList()
        local elems = {
            {label = 'Bleu nuit', value = 1},
            {label = 'Bleu clair', value = 2},
            {label = 'Turquoise', value = 3},
            {label = 'Vert', value = 4},
            {label = 'Jaune', value = 5},
            {label = 'Or', value = 6},
            {label = 'Orange', value = 7},
            {label = 'Rouge', value = 8},
            {label = 'Rose', value = 9},
            {label = 'Violet', value = 10},
            {label = 'Pourpre', value = 11},
            {label = 'Ultra-violet', value = 12},

        }
    
        ESX.UI.Menu.CloseAll()
    
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MenuCustomXeon',{
            title = 'Xeon Menu',
            align = 'top-left',
            elements = elems
        },
        function(data, menu)
            if data.current.value ~= nil then
                ESX.TriggerServerCallback('starcolor:price', function(money)
                    if money == true then
                        achatok = true
                    else
                        achatok = false
                    end
                end, 4000)
                if achatok then
                    local veh = GetVehiclePedIsUsing(PlayerPedId())
                    ToggleVehicleMod(veh, 22, true) -- Xenon
                    SetVehicleXenonLightsColour(veh, data.current.value)
                    ESX.ShowNotification('~g~Merci.')
                else
                    ESX.ShowNotification('~r~Tu n\'a pas la tune.')
                end
            end
    end,
    function(data, menu)
        menu.close()
    end)
end

function TurboList()
	local elems = {
		{label = 'Pas de turbo', value = false},
		{label = 'Turbo', value = true},

	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MenuCustomTurbo',{
		title = 'Turbo Menu',
		align = 'top-left',
		elements = elems
	},
	function(data, menu)
        if data.current.value ~= nil then
                ESX.TriggerServerCallback('starcolor:price', function(money)
                    if money == true then
                        achatok = true
                    else
                        achatok = false
                    end
            end, 30000)
            if achatok then
			    local veh = GetVehiclePedIsUsing(PlayerPedId())
                ToggleVehicleMod(veh, 18, data.current.value) -- turbo off
                ESX.ShowNotification('~g~Merci.')
            else
                ESX.ShowNotification('~r~Tu n\'a pas la tune.')
            end
		end
end,
function(data, menu)
	menu.close()
end)
end

local location = {
    {x = -220.4,y = -2658.93,z = 6.0},
    {x = -225.0,y = -2658.89,z = 6.0},
    {x = -229.62,y = -2658.84,z = 6.0},
    {x = -234.81,y = -2659.12,z = 6.0},

}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local pause = false
        local playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed, false) then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'darkmeca' then
                    for k in pairs(location) do
                        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                        local coords = GetEntityCoords(PlayerPedId())
                        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, location[k].x, location[k].y, location[k].z)
                        if dist <= 20.0 then
                            pause = true
                            DrawMarker(20, location[k].x, location[k].y, location[k].z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 255, 50, 255, 100, true, true, 2, true, false, false, false)
                        end
                        if dist <= 2.5 then
                            pause = true
                            ESX.ShowHelpNotification("Appuie ~INPUT_TALK~ pour faire des ~p~Modification~s~")
                            if IsControlJustPressed(1,51) then 
                                OpenMenu()
                            end
                        end
                    end
                    if not pause then
                        Citizen.Wait(500)
                        pause = false
                    end
            else
                Citizen.Wait(500)
            end
        end
    end
end)

AddEventHandler('onResourceStop',function(resource)
    if resource == GetCurrentResourceName() then
        
    end
end)

-- Devlopped By Starxtrem --
