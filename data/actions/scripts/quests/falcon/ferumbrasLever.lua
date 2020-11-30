local config = {
	requiredLevel = 250,
	daily = true,
	BossPosition = Position(33408, 32285, 14),
	MinosPosition = Position(33406, 32284, 14),
	centerDemonRoomPosition = Position(33409, 32287, 14),
	playerPositions = {
		Position(33380, 32308, 14), -- Posição dos players 1,2,3,4,5
		Position(33381, 32308, 14),
		Position(33382, 32308, 14),
		Position(33383, 32308, 14),
		Position(33384, 32308, 14),
		Position(33385, 32308, 14),
		Position(33386, 32308, 14),
		Position(33387, 32308, 14),
		Position(33388, 32308, 14),
		Position(33389, 32308, 14)

	},
	newPositions = {
		Position(33403, 32294, 14),
		Position(33404, 32294, 14),
		Position(33405, 32294, 14),
		Position(33406, 32294, 14),
		Position(33407, 32294, 14),
		Position(33408, 32294, 14),
		Position(33409, 32294, 14),
		Position(33410, 32294, 14),
		Position(33411, 32294, 14),
		Position(33412, 32294, 14)
	},
}


function onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if item.itemid == 9825 then
	    if player:getPosition() ~= Position(33380, 32308, 14) then
			item:transform(9826)
			return true
		end	
		local storePlayers, playerTile = {}
		local exaustedSeconds = 1
		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not (player:getStorageValue(460030) <= os.time()) then
				player:say("You did this boss before 1 hour!", TALKTYPE_MONSTER_SAY)
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Someone did this boss before 1 hours.")
				return true			
			end
			storePlayers[#storePlayers + 1] = playerTile
		end
		
		local specs, spec = Game.getSpectators(config.centerDemonRoomPosition, false, false, 12, 12, 12, 12)
		for i = 1, #specs do
			spec = specs[i]			
			if spec:isPlayer() then
				if item.itemid == 9826 then
					if player:getPosition() ~= Position(33558, 31497, 8) then
						item:transform(9826)
						player:say("Espere o boss morrer para clicar na alavanca!", TALKTYPE_MONSTER_SAY)
						return true
					end
				end
				return true
			end
		end		

		local specs, spec = Game.getSpectators(config.centerDemonRoomPosition, false, false, 12, 12, 12, 12)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:say("A team is already inside the quest room!", TALKTYPE_MONSTER_SAY)
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "A team is already inside the quest room.")
				return true
			end

			spec:remove()
		end
	
		local players
		local monster = Game.createMonster("Destabilized Ferumbras", Position(33408, 32285, 14))
		monster:setReward(true)
		for i = 1, #storePlayers do
			players = storePlayers[i]
		
			if not (players:getStorageValue(460030) <= os.time()) then
				players:sendTextMessage(TALKTYPE_MONSTER_SAY, "You did this boss before 1 hours.")
				player:say("Someone already did this room before 1 hour!", TALKTYPE_MONSTER_SAY)
				return 
			end
		end
		for i = 1, #storePlayers do
			players = storePlayers[i]
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
			players:setDirection(DIRECTION_NORTH)
			player:setStorageValue(460030, os.time()+exaustedSeconds*3600)
		end
		
			elseif item.itemid == 9825 then
		if config.daily then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
			return true
		end
	end

	item:transform(item.itemid == 9826 and 9825 or 9826)
	return true
end