local t = {x = 33650, y = 32311, z = 15} -- tp duke

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

    if player:getStorageValue(790021) < os.time() then
		player:teleportTo(t)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    else 
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:teleportTo(fromPosition)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have already cleared this warzone in the last 20 hours.")
    end

end