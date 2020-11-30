function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local posTorch = Position(32400, 31793, 8)
	local posParede = Position(32396, 31806, 8)
	local wall = Tile(posParede):getItemById(1050)

	if Tile(posParede):getItemById(1050) then
		wall:remove(1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hear a loud grinding sound not very far from you. something very heavy seems to have moved.")
		addEvent(Game.createItem, 5*60*1000, 1050, 1, posParede)
	end
	

	return true
end

