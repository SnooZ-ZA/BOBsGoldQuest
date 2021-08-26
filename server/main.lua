ESX = nil


TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('bobs_gold:getItem')
AddEventHandler('bobs_gold:getItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addInventoryItem(item, 1)
	TriggerClientEvent('esx:showNotification', source, '~b~You picked up a ' .. item)	
end)

RegisterServerEvent('bobs_gold:checkgoldItems')
AddEventHandler('bobs_gold:checkgoldItems', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local panQuantity = xPlayer.getInventoryItem('pan').count
	
	if panQuantity > 0 then
		TriggerClientEvent('bobs_gold:success', source)
	else
		TriggerClientEvent('esx:showNotification', source, '~r~You dont have a pan.')
	end	

end)

RegisterServerEvent('bobs_gold:checkgemItems')
AddEventHandler('bobs_gold:checkgemItems', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		local panQuantity = xPlayer.getInventoryItem('pan').count
	
		if panQuantity > 0 then
			TriggerClientEvent('bobs_gold:success_gem', source)
		else
			TriggerClientEvent('esx:showNotification', source, '~r~You dont have a pan.')
		end	
	end
end)

RegisterServerEvent('bobs_gold:giveNugget')
AddEventHandler('bobs_gold:giveNugget', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		local goldnuggetQuantity = xPlayer.getInventoryItem('goldnugget').count
		if goldnuggetQuantity < 100 then
			local nuggetweight = math.random(1, 10)
			xPlayer.addInventoryItem('goldnugget', nuggetweight)
			TriggerClientEvent('esx:showNotification', source, '~g~You found a nugget of grams ~y~'.. nuggetweight)
		else
			TriggerClientEvent('esx:showNotification', source, '~r~You cant carry more gold nuggets.')
		end
	end
end)

RegisterServerEvent('bobs_gold:giveGem')
AddEventHandler('bobs_gold:giveGem', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		local gemQuantity = xPlayer.getInventoryItem('gem').count
		if gemQuantity < 10 then
			local luck = math.random(1, 2)
			if luck == 1 then
			gemQty = math.random(1, 2)
			xPlayer.addInventoryItem('gem', gemQty)
				TriggerClientEvent('esx:showNotification', source, '~g~You found ~y~Gems '.. gemQty)
			else
				TriggerClientEvent('esx:showNotification', source, '~g~You didnt find any ~y~ Gems')
			end
		else
			TriggerClientEvent('esx:showNotification', source, '~r~You cant carry more Gems.')
		end
	end
end)

RegisterServerEvent('bobs_gold:checkNugget')
AddEventHandler('bobs_gold:checkNugget', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		local goldnuggetQuantity = xPlayer.getInventoryItem('goldnugget').count
		if goldnuggetQuantity >= 20 then
			local goldcoinQuantity = xPlayer.getInventoryItem('goldcoin').count
				if goldcoinQuantity < 100 then
					xPlayer.removeInventoryItem("goldnugget", 20)
					TriggerClientEvent('bobs_gold:pressCoin', source)
				else
					TriggerClientEvent('esx:showNotification', source, '~r~You cant carry more Gold Coins.')
				end
		else
			TriggerClientEvent('esx:showNotification', source, '~r~You dont have enough Gold.')	
		end
	end
end)

RegisterServerEvent('bobs_gold:giveCoin')
AddEventHandler('bobs_gold:giveCoin', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		local gemQuantity = xPlayer.getInventoryItem('gem').count
		if gemQuantity > 0 then
			TriggerClientEvent('esx:showNotification', source, 'You got a Gem Pendant')
		xPlayer.removeInventoryItem("gem", 1)
		xPlayer.addInventoryItem('gempendant', 1)
		else
			TriggerClientEvent('esx:showNotification', source, 'You got a Gold Coin')
		xPlayer.addInventoryItem('goldcoin', 1)
		end
	end
end)

RegisterServerEvent('bobs_gold:buyItem')
AddEventHandler('bobs_gold:buyItem', function(itemName, price, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if(xPlayer.getMoney() >= price) then
		xPlayer.removeMoney(price)		
		xPlayer.addInventoryItem(itemName, amount)		
		TriggerClientEvent("esx:showNotification", source, "You bought ~g~Items")
	else
		TriggerClientEvent("esx:showNotification", source, "You don't have enough ~r~money")
	end		
end)

ESX.RegisterUsableItem('press', function(source)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('press', 1)
	TriggerClientEvent("bobs_gold:spawnPress", source)
end)

RegisterServerEvent("bobs_gold:sellCoin")
AddEventHandler("bobs_gold:sellCoin", function()	
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		local currentCoin = xPlayer.getInventoryItem("goldcoin")["count"]   
		if currentCoin > 0 then
			xPlayer.removeInventoryItem("goldcoin", currentCoin)
			xPlayer.addMoney(1500 * currentCoin)
			TriggerClientEvent("esx:showNotification", source, ("You had %s Coins and got paid $%s."):format(currentCoin, currentCoin * 1500))
		else
			TriggerClientEvent("esx:showNotification", source, "You don't have any Coins to sell.")
		end
	end
end)

RegisterServerEvent("bobs_gold:sellPendant")
AddEventHandler("bobs_gold:sellPendant", function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		local currentCoin = xPlayer.getInventoryItem("gempendant")["count"]    
		if currentCoin > 0 then
			xPlayer.removeInventoryItem("gempendant", currentCoin)
			xPlayer.addMoney(3000 * currentCoin)
			TriggerClientEvent("esx:showNotification", source, ("You had %s Pendants and got paid $%s."):format(currentCoin, currentCoin * 3000))
		else
			TriggerClientEvent("esx:showNotification", source, "You don't have any Pendants to sell.")
		end
	end
end)