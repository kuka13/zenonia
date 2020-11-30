local config = {
	[24886] = {pos = Position(31994, 32391, 9)},
	[24887] = {pos = Position(33047, 32713, 3)}
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local config = config[item.actionid]
	if not config then
		return true
	end

	player:teleportTo(config.pos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end