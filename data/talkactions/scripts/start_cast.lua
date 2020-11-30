function onSay(player, words, param)
    if player:getStorageValue(Storage.Exaust.tempo) >= os.time() then
	player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You are exhausted.')
	return true
    end
	
	if param == "on" then
		param = nil
	end

	if player:startLiveCast(param) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have started casting your gameplay. Commands: !spectators - !stopcast")
	else
		player:sendCancelMessage("You're already casting your gameplay.")
	end
	return false
end
