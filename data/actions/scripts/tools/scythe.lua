function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if toPosition == Position(32177,31925,7) then
	if player:getLevel() >= 300 then
	player:teleportTo(Position(32516, 32541, 12))
	else
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Needed level 300.")
	end
	end
	
	return onUseScythe(player, item, fromPosition, target, toPosition, isHotkey)
end