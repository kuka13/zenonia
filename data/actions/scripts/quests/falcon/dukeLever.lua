local config = {
	requiredLevel = 250,
	daily = true,
	BossPosition = Position(33706, 32302, 15),
	MinosPosition = Position(33706, 32301, 15),
	centerDemonRoomPosition = Position(33711, 32303, 15),
	playerPositions = {
		Position(33742, 32294, 15), -- Posição dos players 1,2,3,4,5
		Position(33741, 32295, 15),
		Position(33741, 32296, 15),
		Position(33741, 32297, 15),
		Position(33742, 32295, 15),
		Position(33742, 32296, 15),
		Position(33742, 32297, 15),
		Position(33743, 32295, 15),
		Position(33743, 32296, 15),
		Position(33743, 32297, 15)

	},
	newPositions = {
		Position(33717, 32300, 15),
		Position(33717, 32301, 15),
		Position(33717, 32302, 15),
		Position(33717, 32303, 15),
		Position(33717, 32304, 15),
		Position(33718, 32300, 15),
		Position(33718, 32301, 15),
		Position(33718, 32302, 15),
		Position(33718, 32303, 15),
		Position(33718, 32304, 15)
	},
}


function onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if item.itemid == 9825 then
	    if player:getPosition() ~= Position(33742, 32294, 15) then
			item:transform(9826)
			return true
		end	
		local storePlayers, playerTile = {}
		local exaustedSeconds = 1
		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not (player:getStorageValue(46800) <= os.time()) then
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
				if item.itemid == 9826 then
					if player:getPosition() ~= Position(33742, 32294, 14) then
						item:transform(9826)
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
		local monster = Game.createMonster("The Duke Of The Depths", Position(33706, 32302, 15))
		monster:setReward(true)
		for i = 1, #storePlayers do
			players = storePlayers[i]
		
			if not (players:getStorageValue(46800) <= os.time()) then
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
			player:setStorageValue(46800, os.time()+exaustedSeconds*72000)
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