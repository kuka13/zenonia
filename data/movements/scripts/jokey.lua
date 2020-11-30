function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if table.contains(apostadores, player.uid) then
		player:teleportTo(fromPosition)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Aguarde ate a corrida comecar.')
		return true
	end
	
	return true
end
