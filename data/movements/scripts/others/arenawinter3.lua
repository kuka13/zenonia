local t = {x = 32215, y = 32049, z = 14} -- tp ENTRADA SAIDA

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(t)
	player:setStorageValue(56801, os.time() + 72000)
	player:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
	player:setDirection(DIRECTION_WEST)
end