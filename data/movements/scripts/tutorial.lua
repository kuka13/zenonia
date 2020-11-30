function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	if player:getPosition() == Position(32075, 31900, 6) then
		player:sendTutorial(2)
	end
	if player:getPosition() == Position(32075, 31900, 5) then
		return false
	end
	
	return true
end
