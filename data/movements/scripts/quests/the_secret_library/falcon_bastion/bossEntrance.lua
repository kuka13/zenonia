local config = {
	entrance = Position(33310, 31325, 8),
	exit = Position(33330, 31334, 9),
}
function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end

	local entrance = config.entrance
	local exit = config.exit
	if creature then
		if creature:getStorageValue(Storage.secretLibrary.FalconBastion.oberonTimer) <= os.time() then
			creature:teleportTo(Position(33359, 31340, 9), true)
		else
			creature:teleportTo(fromPosition, true)
		end
	end
	creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
