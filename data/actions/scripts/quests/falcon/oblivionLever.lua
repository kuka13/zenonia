local config = {
	requiredLevel = 250,
	daily = true,
	BossPosition = Position(33413, 31356, 9),
	MinosPosition = Position(33413, 31355, 9),
	centerDemonRoomPosition = Position(33404, 31357, 9),
	playerPositions = {
		Position(33379, 31342, 9), -- Posição dos players 1,2,3,4,5
		Position(33379, 31343, 9),
		Position(33379, 31344, 9),
		Position(33379, 31345, 9),
		Position(33379, 31346, 9),
		Position(33380, 31342, 9),
		Position(33380, 31343, 9),
		Position(33380, 31344, 9),
		Position(33380, 31345, 9),
		Position(33380, 31346, 9),
		Position(33381, 31342, 9),
		Position(33381, 31343, 9),
		Position(33381, 31344, 9),
		Position(33381, 31345, 9),
		Position(33381, 31346, 9)

	},
	newPositions = {
		Position(33393, 31353, 9),
		Position(33393, 31354, 9),
		Position(33393, 31355, 9),
		Position(33393, 31356, 9),
		Position(33393, 31357, 9),
		Position(33394, 31353, 9),
		Position(33394, 31354, 9),
		Position(33394, 31355, 9),
		Position(33394, 31356, 9),
		Position(33394, 31357, 9),
		Position(33395, 31353, 9),
		Position(33395, 31354, 9),
		Position(33395, 31355, 9),
		Position(33395, 31356, 9),
		Position(33395, 31357, 9)
	},
}


function onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if item.itemid == 9825 then
	    if player:getPosition() ~= Position(33380, 31342, 9) then
			item:transform(9826)
			return true
		end	
		local storePlayers, playerTile = {}
		local exaustedSeconds = 1
		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not (player:getStorageValue(46012) <= os.time()) then
				player:say("You did this boss before 12 hours!", TALKTYPE_MONSTER_SAY)
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Someone did this boss before 12 hours.")
				return true			
			end
			storePlayers[#storePlayers + 1] = playerTile
		end
		
		local specs, spec = Game.getSpectators(config.centerDemonRoomPosition, false, false, 12, 12, 12, 12)
		for i = 1, #specs do
			spec = specs[i]			
			if spec:isPlayer() then
				if item.itemid == 9826 then
					if player:getPosition() ~= Position(33380, 31342, 10) then
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
		local monster = Game.createMonster("great king oblivion", Position(33413, 31356, 9))
		monster:setReward(true)
		for i = 1, #storePlayers do
			players = storePlayers[i]
		
			if not (players:getStorageValue(46012) <= os.time()) then
				players:sendTextMessage(TALKTYPE_MONSTER_SAY, "You did this boss before 12 hours.")
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
			player:setStorageValue(46012, os.time()+exaustedSeconds*43200)
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