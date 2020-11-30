local config = {
	requiredLevel = 250,
	daily = true,
	BossPosition = Position(33648, 32299, 15),
	MinosPosition = Position(33648, 32303, 15),
	centerDemonRoomPosition = Position(33648, 32303, 15),
	playerPositions = {
		Position(33630, 32334, 15), -- Posição dos players 1,2,3,4,5
		Position(33629, 32335, 15),
		Position(33629, 32336, 15),
		Position(33629, 32337, 15),
		Position(33630, 32335, 15),
		Position(33630, 32336, 15),
		Position(33630, 32337, 15),
		Position(33631, 32335, 15),
		Position(33631, 32336, 15),
		Position(33631, 32337, 15)

	},
	newPositions = {
		Position(33646, 32310, 15),
		Position(33647, 32310, 15),
		Position(33648, 32310, 15),
		Position(33649, 32310, 15),
		Position(33650, 32310, 15),
		Position(33646, 32309, 15),
		Position(33647, 32309, 15),
		Position(33648, 32309, 15),
		Position(33649, 32309, 15),
		Position(33650, 32309, 15)
	},
}

local function clearArea(fromPosition, toPosition, bossName)
	for x = fromPosition.x, toPosition.x do
		for y = fromPosition.y, toPosition.y do
			for z = fromPosition.z, toPosition.z do
				local creature = Tile(Position(x, y, z)):getTopCreature()
				if creature then
					if creature:isPlayer() then
						creature:teleportTo(33650, 32312, 15)
					end

					if creature:isMonster() and creature:getName():lower() == bossName:lower() then
						creature:remove()
					end
				end
			end
		end
	end
end


function onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if item.itemid == 9825 then
	    if player:getPosition() ~= Position(33630, 32334, 15) then
			item:transform(9826)
			return true
		end	
		local storePlayers, playerTile = {}
		local exaustedSeconds = 1
		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not (player:getStorageValue(46871) <= os.time()) then
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
					if player:getPosition() ~= Position(33648, 32299, 15) then
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
		local monster = Game.createMonster("the count of the core", Position(33648, 32299, 15))
		monster:setReward(true)
		for i = 1, #storePlayers do
			players = storePlayers[i]
		
			if not (players:getStorageValue(46861) <= os.time()) then
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
			player:setStorageValue(46861, os.time()+exaustedSeconds*72000)
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