local config = {
	requiredLevel = 250,
	daily = true,
	BossPosition = Position(32206, 32048, 14),
	MinosPosition = Position(32206, 32047, 14),
	centerDemonRoomPosition = Position(32206, 32048, 14),
	playerPositions = {
		Position(32208, 32021, 13), -- Posição dos players 1,2,3,4,5
		Position(32208, 32022, 13),
		Position(32208, 32023, 13),
		Position(32208, 32024, 13),
		Position(32208, 32025, 13)

	},
	newPositions = {
		Position(32224, 32046, 14),
		Position(32224, 32047, 14),
		Position(32224, 32048, 14),
		Position(32224, 32049, 14),
		Position(32224, 32050, 14)
	},
}


function onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if item.itemid == 10029 then
	    if player:getPosition() ~= Position(32208, 32021, 13) then
			item:transform(10030)
			return true
		end	
		local storePlayers, playerTile = {}
		local exaustedSeconds = 1
		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not (player:getStorageValue(56801) <= os.time()) then
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
				if item.itemid == 10030 then
					if player:getPosition() ~= Position(32208, 32021, 12) then
						item:transform(10030)
						player:say("Espere o izcandar morrer para clicar na alavanca!", TALKTYPE_MONSTER_SAY)
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
		local monster = Game.createMonster("Izcandar the Banished", Position(32206, 32048, 14))
		monster:setReward(true)
		for i = 1, #storePlayers do
			players = storePlayers[i]
		
			if not (players:getStorageValue(56801) <= os.time()) then
				players:sendTextMessage(TALKTYPE_MONSTER_SAY, "You did this boss before 3 hours.")
				player:say("Someone already did this room before 3 hours!", TALKTYPE_MONSTER_SAY)
				return 
			end
		end
		for i = 1, #storePlayers do
			players = storePlayers[i]
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
			players:setDirection(DIRECTION_NORTH)
			player:setStorageValue(56801, os.time()+exaustedSeconds*72000)
		end
		
			elseif item.itemid == 10029 then
		if config.daily then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
			return true
		end
	end

	item:transform(item.itemid == 10030 and 10029 or 10030)
	return true
end