local config = {
	[4121] = {premium = true, destination = Position(32801, 31766, 9)},
	[3220] = {destination = Position(32627, 31864, 11)},
	[3128] = {level = 80, destination = Position(33000, 31870, 13)},
	[3129] = {destination = Position(32795, 31762, 10)},
	[3130] = {level = 80, destination = Position(32864, 31844, 11)},
	[3131] = {destination = Position(32803, 31746, 10)},
	[3132] = {level = 80, destination = Position(32988, 31862, 9)},
	[3133] = {destination = Position(32798, 31783, 10)},
	[3134] = {level = 80, destination = Position(32959, 31953, 9)},
	[3135] = {destination = Position(33001, 31915, 9)},
	[3136] = {level = 80, destination = Position(32904, 31894, 13)},
	[3137] = {destination = Position(32979, 31907, 9)},
	[3215] = {level = 80, destination = Position(32329, 32172, 9)},
	[3216] = {destination = Position(32195, 31182, 8)},
	[3217] = {level = 80, destination = Position(32402, 32816, 6)},
	[3218] = {destination = Position(33153, 31833, 10)},
	[3219] = {level = 80, destination = Position(33186, 32385, 8)},
	[3222] = {level = 80, destination = Position(32771, 31800, 10)},
	[3221] = {destination = Position(32790, 31795, 10)}
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPortal = config[item.actionid]
	if not targetPortal then
		return true
	end

	if targetPortal.premium then
		if not player:isPremium() then
			local toPosition = Position(32624, 31855, 11)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Only premium accounts can use this teleporter.')
			player:teleportTo(toPosition)
			position:sendMagicEffect(CONST_ME_TELEPORT)
			toPosition:sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	end

	player:teleportTo(targetPortal.destination)
	position:sendMagicEffect(CONST_ME_TELEPORT)
	targetPortal.destination:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
