local destination = {
	[57601] = {newPos = Position(33364, 31339, 4), effect = CONST_ME_ICEATTACK},
	[57605] = {newPos = Position(33364, 31336, 4), effect = CONST_ME_ICEATTACK},
	[57606] = {newPos = Position(33362, 31340, 4), effect = CONST_ME_ICEATTACK},
	[57607] = {newPos = Position(33365, 31340, 4), effect = CONST_ME_ICEATTACK},
	[57608] = {newPos = Position(33367, 31324, 6), effect = CONST_ME_ICEATTACK},
	[57609] = {newPos = Position(32816, 32748, 10), effect = CONST_ME_ICEATTACK},

}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local teleport = destination[item.actionid]
	if not teleport then
		return
	end
		player:teleportTo(teleport.newPos)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
end

