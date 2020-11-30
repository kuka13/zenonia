local destination = {
	
	[27724] = {newPos = Position(32043, 31939, 15), effect = CONST_ME_YELLOWENERGY},

}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local teleport = destination[item.itemid]
	if not teleport then
		return
	end

	position:sendMagicEffect(teleport.effect)
	player:teleportTo(teleport.newPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

