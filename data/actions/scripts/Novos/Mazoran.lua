local config = {
	centerRoom = Position(33584, 32689, 14),
	BossPosition = Position(33584, 32689, 14),
	playerPositions = {
		Position(33593, 32644, 14),
		Position(33593, 32645, 14),
		Position(33593, 32646, 14),
		Position(33593, 32647, 14),
		Position(33593, 32648, 14)
	},
	newPosition = Position(33585, 32693, 14)
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 10029 then
		if player:getPosition() ~= Position(33593, 32644, 14) then
			item:transform(10030)
			return true
		end
	end
	if item.itemid == 10029 then
		if player:getStorageValue(Storage.FerumbrasAscension.MazoranTimer) >= 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait a while, recently someone challenge Mazoran.")
			return true
		end
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with Mazoran.")
				return true
			end
		end
		Game.createMonster("Mazoran", config.BossPosition, true, true)
		for y = 32644, 32648 do
			local playerTile = Tile(Position(33593, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
				playerTile:teleportTo(config.newPosition)
				playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				playerTile:setExhaustion(Storage.FerumbrasAscension.MazoranTimer, 60 * 60 * 2 * 24)
			end
		end
		Game.setStorageValue(GlobalStorage.FerumbrasAscendantQuest.MazoranTimer, 1)
		addEvent(clearForgotten, 30 * 60 * 1000, Position(33572, 32679, 14), Position(33599, 32701, 14), Position(33319, 32318, 13), GlobalStorage.FerumbrasAscendantQuest.MazoranTimer)
		item:transform(10030)
	elseif item.itemid == 10030 then
		item:transform(10029)
	end
	return true
end
		
			
		
		
		