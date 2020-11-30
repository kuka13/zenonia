local t = {x = 32870, y = 32725, z = 15} -- tp ENTRADA SAIDA

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(t)
	player:setStorageValue(48002, os.time() + 72000)
	player:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
	player:setDirection(DIRECTION_NORTH)
end