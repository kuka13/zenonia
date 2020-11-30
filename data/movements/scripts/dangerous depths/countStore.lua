local t = {x = 33681, y = 32339, z = 15} -- tp duke

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()

	if not player then
		return
	end

	player:teleportTo(t)
	player:setStorageValue(790022, os.time() + 72000)
end