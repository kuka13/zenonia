local t = {x = 33718, y = 32304, z = 15} -- tp duke

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()

	if not player then
		return
	end

	player:teleportTo(t)
	player:setStorageValue(790020, os.time() + 72000)
end