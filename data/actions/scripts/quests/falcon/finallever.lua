local config = {
	requiredLevel = 250,
	daily = true,
	BossPosition = Position(31638, 31923, 11),
	MinosPosition = Position(31638, 31923, 11),
	centerDemonRoomPosition = Position(31638, 31933, 11),
	playerPositions = {
		Position(31593, 31931, 11), -- Posi��o dos players 1,2,3,4,5
		Position(31593, 31932, 11),
		Position(31593, 31933, 11),
		Position(31593, 31934, 11),
		Position(31593, 31935, 11),
		Position(31594, 31931, 11),
		Position(31594, 31932, 11),
		Position(31594, 31933, 11),
		Position(31594, 31934, 11),
		Position(31594, 31935, 11)

	},
	newPositions = {
		Position(31638, 31943, 11)
	},
}


function onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if item.itemid == 32586 then
	    if player:getPosition() ~= Position(31593, 31933, 11) then
			item:transform(32910)
			return true
		end	
		local storePlayers, playerTile = {}
		local exaustedSeconds = 1
		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not (player:getStorageValue(460026) <= os.time()) then
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
				if item.itemid == 32910 then
					if player:getPosition() ~= Position(33558, 31497, 8) then
						item:transform(32910)
						player:say("Espere o Boss morrer para clicar!", TALKTYPE_MONSTER_SAY)
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
		local monster = Game.createMonster("The Scourge Of Oblivion", Position(31638, 31923, 11))
		monster:setReward(true)
		for i = 1, #storePlayers do
			players = storePlayers[i]
		
			if not (players:getStorageValue(460026) <= os.time()) then
				players:sendTextMessage(TALKTYPE_MONSTER_SAY, "You did this boss before 20 hours.")
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
			player:setStorageValue(460026, os.time()+exaustedSeconds*72000)
		end
		
			elseif item.itemid == 32586 then
		if config.daily then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
			return true
		end
	end

	item:transform(item.itemid == 32910 and 32586 or 32910)
	return true
end