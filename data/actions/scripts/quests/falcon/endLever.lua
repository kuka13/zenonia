local config = {
	requiredLevel = 250,
	daily = true,
	BossPosition = Position(33681, 32275, 15),
	MinosPosition = Position(33681, 32274, 15),
	centerDemonRoomPosition = Position(33676, 32275, 15),
	playerPositions = {
		Position(33634, 32252, 15), -- Posição dos players 1,2,3,4,5
		Position(33634, 32253, 15),
		Position(33634, 32254, 15),
		Position(33634, 32255, 15),
		Position(33634, 32256, 15),
		Position(33635, 32252, 15), 
		Position(33635, 32253, 15),
		Position(33635, 32254, 15),
		Position(33635, 32255, 15),
		Position(33635, 32256, 15),
		Position(33636, 32252, 15), 
		Position(33636, 32253, 15),
		Position(33636, 32254, 15),
		Position(33636, 32255, 15),
		Position(33636, 32256, 15),
		Position(33637, 32252, 15), 
		Position(33637, 32253, 15),
		Position(33637, 32254, 15),
		Position(33637, 32255, 15),
		Position(33637, 32256, 15)

	},
	newPositions = {
		Position(33668, 32272, 15), -- Posição dos players 1,2,3,4,5
		Position(33668, 32273, 15),
		Position(33668, 32274, 15),
		Position(33668, 32275, 15),
		Position(33668, 32276, 15),
		Position(33669, 32272, 15), 
		Position(33669, 32273, 15),
		Position(33669, 32274, 15),
		Position(33669, 32275, 15),
		Position(33669, 32276, 15),
		Position(33670, 32272, 15), 
		Position(33670, 32273, 15),
		Position(33670, 32274, 15),
		Position(33670, 32275, 15),
		Position(33670, 32276, 15),
		Position(33671, 32272, 15), 
		Position(33671, 32273, 15),
		Position(33671, 32274, 15),
		Position(33671, 32275, 15),
		Position(33671, 32276, 15)
	},
}


function onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if item.itemid == 33973 then
	    if player:getPosition() ~= Position(33634, 32252, 15) then
			item:transform(33974)
			return true
		end	
		local storePlayers, playerTile = {}
		local exaustedSeconds = 1
		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not (player:getStorageValue(46819) <= os.time()) then
				player:say("You did this boss before 20 hours!", TALKTYPE_MONSTER_SAY)
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Someone did this boss before 20 hours.")
				return true			
			end
			storePlayers[#storePlayers + 1] = playerTile
		end
		
		local specs, spec = Game.getSpectators(config.centerDemonRoomPosition, false, false, 12, 12, 12, 12)
		for i = 1, #specs do
			spec = specs[i]			
			if spec:isPlayer() then
				if item.itemid == 33974 then
					if player:getPosition() ~= Position(33634, 32252, 14) then
						item:transform(33974)
						player:say("Espere o Boss morrer para clicar na alavanca!", TALKTYPE_MONSTER_SAY)
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
		local monster = Game.createMonster("end", Position(33682, 32275, 15))
		monster:setReward(true)
		for i = 1, #storePlayers do
			players = storePlayers[i]
		
			if not (players:getStorageValue(46819) <= os.time()) then
				players:sendTextMessage(TALKTYPE_MONSTER_SAY, "You did this boss before 20 hours.")
				player:say("Someone already did this room before 20 hours!", TALKTYPE_MONSTER_SAY)
				return 
			end
		end
		for i = 1, #storePlayers do
			players = storePlayers[i]
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
			players:setDirection(DIRECTION_NORTH)
			player:setStorageValue(46819, os.time()+exaustedSeconds*72000)
		end
		
			elseif item.itemid == 33973 then
		if config.daily then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
			return true
		end
	end

	item:transform(item.itemid == 33974 and 33973 or 33974)
	return true
end