local t = {x = 32890, y = 31621, z = 10} -- tp ENTRADA SAIDA

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(t)
	player:setStorageValue(49002, os.time() + 72000)
	player:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
	player:setDirection(DIRECTION_NORTH)
end