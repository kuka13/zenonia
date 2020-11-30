local destination = {
	
	[27723] = {newPos = Position(32041, 32024, 14), effect = CONST_ME_YELLOWENERGY},
	[27724] = {newPos = Position(32042, 31923, 15), effect = CONST_ME_YELLOWENERGY},
	
	
	[27726] = {newPos = Position(33677, 32147, 7), effect = CONST_ME_ICEATTACK},


	
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

