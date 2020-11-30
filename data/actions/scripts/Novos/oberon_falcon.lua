local config = {
	centerRoom = Position(33364, 31317, 9),
	BossPosition = Position(33364, 31317, 9),
	newPosition = Position(33364, 31323, 9)
}

local function clearForgottenThornKnight()
	local spectators = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
	for i = 1, #spectators do
		local spectator = spectators[i]
		if spectator:isPlayer() then
			spectator:teleportTo(Position(33362, 31342, 9))
			spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			spectator:say('Time out! You were teleported out by strange forces.', TALKTYPE_MONSTER_SAY)
		elseif spectator:isMonster() then
			spectator:remove()
		end
	end
	Game.setStorageValue(GlobalStorage.ForgottenKnowledge.ThornKnightTimer, 0)
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 1946 then
		if player:getPosition() ~= Position(33365, 31342, 9) then
			item:transform(1945)
			return true
		end
	end
	if item.itemid == 1945 then
		if Game.getStorageValue(GlobalStorage.ForgottenKnowledge.ThornKnightTimer) >= 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait a while, recently someone challenge Grand Master Oberon.")
			--Game.setStorageValue(GlobalStorage.ForgottenKnowledge.ThornKnightTimer, 0) --Aqui para forçar zerar o timer...
			return true
		end
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with Grand Master Oberon.")
				return true
			end
			if spec:isMonster() then
			spec:remove()
			end
		end
		for d = 1, 6 do
			Game.createMonster('possessed tree', Position(math.random(33359, 33370), math.random(31314, 31323), 9), true, true)
		end
		
		Game.createMonster("grand master oberon", config.BossPosition, true, true)
		
		for x = 33362, 33366 do
			local playerTile = Tile(Position(x, 31344, 9)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
				playerTile:teleportTo(config.newPosition)
				playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				playerTile:setExhaustion(Storage.ForgottenKnowledge.ThornKnightTimer, 20 * 60 * 60)
			end
		end
		Game.setStorageValue(GlobalStorage.ForgottenKnowledge.ThornKnightTimer, 1)
		addEvent(clearForgottenThornKnight, 30 * 240 * 1000)
		item:transform(1946)
		elseif item.itemid == 1946 then
		item:transform(1945)
	end
	return true
end
		
		
		
		