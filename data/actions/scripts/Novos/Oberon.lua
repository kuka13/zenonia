local config = {
	centerRoom = Position(33365, 31320, 9),
	BossPosition = Position(33365, 31316, 9),
	newPosition = Position(33364, 31322, 9)
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 9825 then
		if player:getPosition() ~= Position(33380, 31342, 9) then
			item:transform(9826)
			return true
		end
	end
	if item.itemid == 9825 then
		if player:getStorageValue(Storage.FerumbrasAscension.TarbazTimer) >= 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait a while, recently someone challenge Grand Master Oberon.")
			return true
		end
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with Grand Master Oberon.")
				return true
			end
		end
		Game.createMonster("Grand Master Oberon", config.BossPosition, true, true)
		for y = 31342, 31346 do
			local playerTile = Tile(Position(33380, y, 9)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
				playerTile:teleportTo(config.newPosition)
				playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				playerTile:setExhaustion(Storage.FerumbrasAscension.TarbazTimer, 60 * 60 * 2 * 24)
			end
		end 
		Game.setStorageValue(GlobalStorage.FerumbrasAscendantQuest.TarbazTimer, 1)
		addEvent(clearForgotten, 30 * 60 * 1000, Position(33380, 31339, 9), Position(33381, 31339, 9), Position(33382, 31339, 9), GlobalStorage.FerumbrasAscendantQuest.TarbazTimer)
		item:transform(9826)
	elseif item.itemid == 9826 then
		item:transform(9825)
	end
	return true
end
		
		
		
		