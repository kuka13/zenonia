function onSay(player, words, param)
	print("> " .. player:getName() .. " broadcasted: \"" .. param .. "\".")
	for _, targetPlayer in ipairs(Game.getPlayers()) do
		targetPlayer:sendPrivateMessage(player, param, MESSAGE_EVENT_DEFAULT)
	end
	return false
end
