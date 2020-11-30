
function onUse(player, item, fromPosition, itemEx, toPosition) 
	
	if player:getStorageValue(Storage.Exaust.tempo) >= os.time() then
	player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You are exhausted.')
	return true
    end


		db.query('UPDATE accounts SET coins = coins+'.. 300 ..' WHERE id = ' .. player:getAccountId())
	
	
	doPlayerSendTextMessage(player, MESSAGE_EVENT_ADVANCE, "You have recived 300 Tibia Coins to your account.")
	doSendMagicEffect(getCreaturePosition(player), 28)
	doRemoveItem(item.uid,1)
	player:setStorageValue(Storage.Exaust.tempo, os.time())
	return true
end