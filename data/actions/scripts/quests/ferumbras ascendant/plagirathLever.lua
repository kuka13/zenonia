local config = {
	requiredLevel = 250,
	daily = true,
	BossPosition = Position(33164, 31496, 13),
	MinosPosition = Position(33164, 31497, 13),
	centerDemonRoomPosition = Position(33164, 31497, 13),
	playerPositions = {
		Position(33229, 31504, 13), -- Posição dos players 1,2,3,4,5
		Position(33229, 31503, 13),
		Position(33229, 31502, 13),
		Position(33229, 31501, 13),
		Position(33229, 31500, 13)

	},
	newPositions = {
		Position(33176, 31509, 13), -- Posição dos players 1,2,3,4,5
		Position(33175, 31509, 13),
		Position(33173, 31509, 13),
		Position(33171, 31509, 13),
		Position(33170, 31509, 13)
	},
}


function onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if item.itemid == 9825 then
	    if player:getPosition() ~= Position(33229, 31500, 13) then
			item:transform(9826)
			return true
		end	
		local storePlayers, playerTile = {}
		local exaustedSeconds = 1
		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not (player:getStorageValue(55002) <= os.time()) then
				player:say("You did this boss before 10 hours!", TALKTYPE_MONSTER_SAY)
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Someone did this boss before 10 hours.")
				return true			
			end
			storePlayers[#storePlayers + 1] = playerTile
		end
		
		local specs, spec = Game.getSpectators(config.centerDemonRoomPosition, false, false, 12, 12, 12, 12)
		for i = 1, #specs do
			spec = specs[i]			
			if spec:isPlayer() then
				if item.itemid == 9826 then
					if player:getPosition() ~= Position(33229, 31504, 13) then
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
		local monster = Game.createMonster("Plagirath", Position(33172, 31501, 13))
		monster:setReward(true)
		for i = 1, #storePlayers do
			players = storePlayers[i]
		
			if not (players:getStorageValue(55002) <= os.time()) then
				players:sendTextMessage(TALKTYPE_MONSTER_SAY, "You did this boss before 10 hours.")
				player:say("Someone already did this room before 10 hours!", TALKTYPE_MONSTER_SAY)
				return 
			end
		end
		for i = 1, #storePlayers do
			players = storePlayers[i]
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
			players:setDirection(DIRECTION_NORTH)
			player:setStorageValue(55002, os.time()+exaustedSeconds*36000)
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