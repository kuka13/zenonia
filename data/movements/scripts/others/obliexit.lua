local t = {x = 33380, y = 31339, z = 9} -- tp ENTRADA SAIDA

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(t)
	player:setStorageValue(46012, os.time() + 18000)
	player:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
	player:setDirection(DIRECTION_NORTH)
end