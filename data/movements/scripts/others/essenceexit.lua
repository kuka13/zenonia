local t = {x = 33090, y = 31963, z = 15} -- tp ENTRADA SAIDA

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(t)
	player:setStorageValue(59501, os.time() + 72000)
	player:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
	player:setDirection(DIRECTION_NORTH)
end