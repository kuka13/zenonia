function onSay(player, words, param)

	StaminaTreiner = {1}
	--print("> " .. player:getName() .. " broadcasted: \"" .. param .. "\".")

		broadcastMessage(""..param.."", MESSAGE_STATUS_WARNING)
		player:setStamina(0)
		
	return false
end
