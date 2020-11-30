function onSay(player, words, param)
    if player:getStorageValue(Storage.Exaust.tempo) >= os.time() then
	player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You are exhausted.')
	return true
    end
	
	if player:stopLiveCast(param) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have stopped casting your gameplay.")
	else
		player:sendCancelMessage("You're not casting your gameplay.")
	end
	return false
end
