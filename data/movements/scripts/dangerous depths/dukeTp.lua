local t = {x = 33275, y = 32318, z = 15} -- tp duke
local p = {x = 33718, y = 32304, z = 15}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

    if player:getStorageValue(790019) < os.time() then
		player:teleportTo(p)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    else 
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:teleportTo(t)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have already cleared this warzone in the last ten hours.")
    end

end