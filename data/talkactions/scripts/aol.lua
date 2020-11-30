function onSay(player, words, param)
   
	local price_aol = 10000

    if player:getStorageValue(Storage.Exaust.tempo) >= os.time() then
	player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You are exhausted.')
	return true
    end
	
	if player:getMoney() >= price_aol then
		player:removeMoney(price_aol)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		player:addItem(2173, 1)	
		
		
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("You dont have enought money.")
	end
	
end

