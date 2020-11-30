function onSay(player, words, param)
	local Price = 10000	
	
	if player:getStorageValue(Storage.Exaust.tempo) >= os.time() then
	player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You are exhausted.')
	return true
    end
	
	if(player:hasBlessing(1) and player:hasBlessing(2) and player:hasBlessing(3) and player:hasBlessing(4) and player:hasBlessing(5) and player:hasBlessing(6)) then
	return	doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "You have already been blessed by the gods.") and doSendMagicEffect(getCreaturePosition(player), 3)
	else
	if player:removeMoneyNpc(Price) then
		for i = 1, 8 do
			if not player:hasBlessing(i) then
				player:addBlessing(i, 1)
			end
		end
		return true
	else
		player:sendCancelMessage("You do not have enough money.")
		return false
	end
	
	return false
end
end