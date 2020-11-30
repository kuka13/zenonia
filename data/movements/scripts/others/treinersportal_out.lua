function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local eixoX, eixoY, eixoZ = player:getStorageValue(250124), player:getStorageValue(250125), player:getStorageValue(250126)
	
	if eixoX > 1 and eixoY > 1 and eixoZ > 1 then
	player:teleportTo(Position(eixoX, eixoY, eixoZ))
	else
	player:teleportTo(player:getTown():getTemplePosition())
	end
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	
	player:setStorageValue(250124, -1)
	player:setStorageValue(250125, -1)
	player:setStorageValue(250126, -1)
	return true
end
