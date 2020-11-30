function onSay(player, words, param)
    
	if player:getStorageValue(Storage.Exaust.tempo) >= os.time() then
	player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You are exhausted.')
	return true
    end
	
	local soma = 0
	if #spoofPlayers > 0 then
	soma = #spoofPlayers
	end

	local hasAccess = player:getGroup():getAccess()
	local players = Game.getPlayers()
	local playerCount = Game.getPlayerCount()+soma --spoof

	player:sendTextMessage(MESSAGE_INFO_DESCR, playerCount .. " players online.")

	return false
end
 