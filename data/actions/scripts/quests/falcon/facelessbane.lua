local config = {
	requiredLevel = 250,
	daily = true,
	BossPosition = Position(33617, 32558, 13),
	MinosPosition = Position(31558, 31950, 11),
	centerDemonRoomPosition = Position(33617, 32562, 13),
	playerPositions = {
		Position(33638, 32562, 13), -- Posição dos players 1,2,3,4,5
		Position(33639, 32562, 13),
		Position(33640, 32562, 13),
		Position(33641, 32562, 13),
		Position(33642, 32562, 13)

	},
	newPositions = {
		Position(33615, 32567, 13),
		Position(33616, 32567, 13),
		Position(33617, 32567, 13),
		Position(33618, 32567, 13),
		Position(33619, 32567, 13)
	},
}


function onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if item.itemid == 9825 then
	    if player:getPosition() ~= Position(33638, 32562, 13) then
			item:transform(9826)
			return true
		end	
		local storePlayers, playerTile = {}
		local exaustedSeconds = 1
		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not (player:getStorageValue(460030) <= os.time()) then
				player:say("You did this boss before 5 hours!", TALKTYPE_MONSTER_SAY)
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Someone did this boss before 5 hours.")
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
		local monster = Game.createMonster("Faceless Bane", Position(33617, 32558, 13))
		monster:setReward(true)
		for i = 1, #storePlayers do
			players = storePlayers[i]
		
			if not (players:getStorageValue(460030) <= os.time()) then
				players:sendTextMessage(TALKTYPE_MONSTER_SAY, "You did this boss before 1 hours.")
				player:say("Someone already did this room before 5 hours!", TALKTYPE_MONSTER_SAY)
				return 
			end
		end
		for i = 1, #storePlayers do
			players = storePlayers[i]
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
			players:setDirection(DIRECTION_NORTH)
			player:setStorageValue(460030, os.time()+exaustedSeconds*18000)
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