ESX = nil
searching  = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

local place = {
    {x = -659.55,y = 4413.17,z = 15.02},
	{x = -655.52,y = 4412.07,z = 15.02},
	{x = -651.91,y = 4410.61,z = 15.07}
}

local gemplace = {
    {x = -793.55,y = 4456.60,z = 14.73},
	{x = -799.62,y = 4458.20,z = 14.71},
	{x = -804.83,y = 4457.58,z = 14.73}
}

local goldItems = {
    {x = -673.59,y = 4403.35,z = 18.00}
}

local gemItems = {
    {x = -789.65,y = 4473.64,z = 17.50}
}

closestPress = {
	"bkr_prop_coke_press_01b"
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(place) do
            DrawMarker(27, place[k].x, place[k].y, place[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(gemplace) do
            DrawMarker(27, gemplace[k].x, gemplace[k].y, gemplace[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(goldItems) do
            DrawMarker(27, goldItems[k].x, goldItems[k].y, goldItems[k].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(gemItems) do
            DrawMarker(27, gemItems[k].x, gemItems[k].y, gemItems[k].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(place) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local placedist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, place[k].x, place[k].y, place[k].z)

            if placedist <= 1.5 then
				drawText3D(place[k].x, place[k].y, place[k].z + 0.9, '⚙️')	
                while IsControlPressed(0, 38) do
				drawText3D(place[k].x, place[k].y, place[k].z + 0.8, '[~g~H~s~] to start ~b~Panning~s~')
				break
				end	
				if IsControlJustReleased(0, 74) then
				TriggerServerEvent('bobs_gold:checkgoldItems')
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(gemplace) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local gemplacedist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gemplace[k].x, gemplace[k].y, gemplace[k].z)

            if gemplacedist <= 1.5 then
				drawText3D(gemplace[k].x, gemplace[k].y, gemplace[k].z + 0.9, '⚙️')	
                while IsControlPressed(0, 38) do
				drawText3D(gemplace[k].x, gemplace[k].y, gemplace[k].z + 0.8, '[~g~H~s~] to start ~b~Panning~s~')
				break
				end	
				if IsControlJustReleased(0, 74) then
				TriggerServerEvent('bobs_gold:checkgemItems')
				end			
            end
        end
    end
end)

RegisterNetEvent('bobs_gold:success')
AddEventHandler('bobs_gold:success', function (source)	
		searching  = true
		exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 15000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "PANNING",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								--scenario = "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", -- https://alexguirre.github.io/animations-list/
								animationName = "machinic_loop_mechandplayer",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
								attachModel = GetHashKey('prop_kitch_pot_fry')
								boneNumber = 26613
								SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263) 
								local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber)
								RequestModel(attachModel)
								while not HasModelLoaded(attachModel) do
								Citizen.Wait(100)
								end
								attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
								AttachEntityToEntity(attachedProp, GetPlayerPed(-1), bone, 0.10, 0.10, 0.12, 10.00, 30.990, 220.080, 1, 1, 0, 1, 0, 1)
				Citizen.Wait(15000)
				if DoesEntityExist(attachedProp) then
				DeleteEntity(attachedProp)
				end
				TriggerServerEvent('bobs_gold:giveNugget')
				searching  = false
			
		
end)

RegisterNetEvent('bobs_gold:success_gem')
AddEventHandler('bobs_gold:success_gem', function (source)	
		searching  = true
		exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 15000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "PANNING",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								--scenario = "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", -- https://alexguirre.github.io/animations-list/
								animationName = "machinic_loop_mechandplayer",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
								attachModel = GetHashKey('prop_kitch_pot_fry')
								boneNumber = 26613
								SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263) 
								local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber)
								RequestModel(attachModel)
								while not HasModelLoaded(attachModel) do
								Citizen.Wait(100)
								end
								attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
								AttachEntityToEntity(attachedProp, GetPlayerPed(-1), bone, 0.10, 0.10, 0.12, 10.00, 30.990, 220.080, 1, 1, 0, 1, 0, 1)
				Citizen.Wait(15000)
				if DoesEntityExist(attachedProp) then
				DeleteEntity(attachedProp)
				end
				searching  = false
		TriggerServerEvent('bobs_gold:giveGem')	
		
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(goldItems) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local goldItemsdist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, goldItems[k].x, goldItems[k].y, goldItems[k].z)

            if goldItemsdist <= 1.5 then
				drawText3D(goldItems[k].x, goldItems[k].y, goldItems[k].z + 0.8, '[~g~E~s~] to buy~b~ Items~s~ [~g~H~s~] to sell~b~ Coins~s~')
				if IsControlJustPressed(0, 38) then -- "E"
					OpenBuyGoldItemsMenu()
				elseif IsControlJustPressed(0, 74) then -- "H"
					OpenSellCoinMenu()
				end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(gemItems) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local goldItemsdist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gemItems[k].x, gemItems[k].y, gemItems[k].z)

            if goldItemsdist <= 1.5 then
				drawText3D(gemItems[k].x, gemItems[k].y, gemItems[k].z + 0.8, '[~g~E~s~] to sell~b~ Pendants~s~')
				if IsControlJustPressed(0, 38) then -- "E"
					OpenSellGemMenu()
				end
            end
        end
    end
end)

function OpenBuyGoldItemsMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'buy_goldItems_menu',
        {
            title    = 'Buy Items',
			align    = 'top-left',
            elements = {
                
				{label = 'Metal Pan($50)', item = 'pan', type = 'slider', price = 50, value = 1, min = 1, max = 5},
				{label = 'Coin Press($1500)', item = 'press', type = 'slider', price = 1500, value = 1, min = 1, max = 5}
				
            }
        },
        function(data, menu)
				TriggerServerEvent('bobs_gold:buyItem', data.current.item, data.current.price, data.current.value)
        end,
        function(data, menu)
            menu.close()
        end)
end

function OpenSellCoinMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pawn_sell_menu',
        {
            title    = 'Do you have any Coins you want to sell?',
			align    = 'top-left',
            elements = {
                {label = 'Gold Coin($1500)', value = 'goldcoin'}				
            }
        },
        function(data, menu)
            if data.current.value == 'goldcoin' then
				TriggerServerEvent('bobs_gold:sellCoin')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenSellGemMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pawn_sell_menu',
        {
            title    = 'Do you have any Pendants you want to sell?',
			align    = 'top-left',
            elements = {
                {label = 'Gem Pendant($3000)', value = 'gempendant'}				
            }
        },
        function(data, menu)
            if data.current.value == 'gempendant' then
				TriggerServerEvent('bobs_gold:sellPendant')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

drawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
  
	local scale = 0.30
   
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 650
        --DrawRect(_x, _y + 0.0120, 0.030 + factor , 0.030, 66, 66, 66, 100)
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if searching then
            DisableControlAction(0, 38) 
			DisableControlAction(0, 47)
			DisableControlAction(0, 74)
        end
    end
end)

--press
Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i = 1, #closestPress do
            local x = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(closestPress[i]), false, false, false)
            local entity = nil
            if DoesEntityExist(x) then
                sleep  = 5
                entity = x
                press   = GetEntityCoords(entity)
				drawText3D(press.x, press.y, press.z + 1.3, '⚙️')				
                while IsControlPressed(0, 38) do
                drawText3D(press.x, press.y, press.z + 1.2, '[~g~H~s~] to press ~b~Coin~s~ [~g~F~s~] to pickup ~b~Press~s~')
				break
				end				
                if IsControlJustReleased(0, 74) and DoesEntityExist(entity) then
				TriggerServerEvent('bobs_gold:checkNugget')
				elseif IsControlJustReleased(0, 23) and DoesEntityExist(entity) then
				local item = 'press'
				ESX.Streaming.RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", function()
				TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8.0, -1, 0, 0, false, false, false)
				end)
				Citizen.Wait(3000)
				ClearPedTasks(PlayerPedId())
				TriggerServerEvent('bobs_gold:getItem', item)
				DeleteObject(entity)
				ClearPedTasks(PlayerPedId())
                end
                break
            else
                sleep = 1000
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('bobs_gold:spawnPress')
AddEventHandler('bobs_gold:spawnPress', function()
	ESX.Streaming.RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", function()
	TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8.0, -1, 0, 0, false, false, false)
	Citizen.Wait(2500)
	ClearPedTasks(PlayerPedId())
    AddPress()
	end)
end)

function AddPress()
	local ped= GetPlayerPed(-1)
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.2, 0.0)
    local heading = GetEntityHeading(ped)
	local pedcoords = GetEntityCoords(ped)

		local pressinfo = {
            x= coords.x,
            y= coords.y,
            z= coords.z,
            h= heading,
            propid=0,
            }

            local ModelHash = GetHashKey('bkr_prop_coke_press_01b')
            local Prop = CreateObject(ModelHash, 0, 0, 0, true, true, true)
            pressinfo.propid = Prop
                SetEntityCoords(Prop, pressinfo.x, pressinfo.y, pressinfo.z, 0, 0, 0, false)
                SetEntityHeading(Prop, pressinfo.h)
				PlaceObjectOnGroundProperly(Prop)
				Citizen.Wait(100)
                FreezeEntityPosition(pressinfo.propid, true)
    check = true
end

RegisterNetEvent('bobs_gold:pressCoin')
AddEventHandler('bobs_gold:pressCoin', function (source)	
		searching  = true
		exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 59000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "PRESSING COIN",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								--scenario = "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "anim@amb@business@coc@coc_packing_hi@", -- https://alexguirre.github.io/animations-list/
								animationName = "full_cycle_v3_pressoperator",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
				Citizen.Wait(59000)
				searching  = false
		TriggerServerEvent('bobs_gold:giveCoin')	
		
end)
