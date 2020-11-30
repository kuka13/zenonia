function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	local eixoX, eixoY, eixoZ = fromPosition.x, fromPosition.y, fromPosition.z
	
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	
	player:setStorageValue(250124, eixoX)
	player:setStorageValue(250125, eixoY)
	player:setStorageValue(250126, eixoZ)
	
	player:teleportTo(Position(32382, 31905, 7))
	return true
end
