local t = {x = 33650, y = 32311, z = 15} -- tp duke

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()

	if not player then
		return
	end

	player:teleportTo(t)
	player:setStorageValue(790021, os.time() + 72000)
end