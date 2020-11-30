local config = {
	requiredLevel = 250,
	daily = true,
	BossPosition = Position(31524, 31967, 11),
	MinosPosition = Position(31524, 31965, 11),
	centerDemonRoomPosition = Position(31524, 31966, 11),
	playerPositions = {
		Position(31533, 31929, 11), -- Posição dos players 1,2,3,4,5
		Position(31534, 31929, 11),
		Position(31535, 31929, 11),
		Position(31536, 31929, 11),
		Position(31537, 31929, 11)

	},
	newPositions = {
		Position(31522, 31973, 11),
		Position(31523, 31973, 11),
		Position(31524, 31973, 11),
		Position(31525, 31973, 11),
		Position(31526, 31973, 11)
	},
}


function onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if item.itemid == 32586 then
	    if player:getPosition() ~= Position(31533, 31929, 11) then
			item:transform(32910)
			return true
		end	
		local storePlayers, playerTile = {}
		local exaustedSeconds = 1
		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not (player:getStorageValue(460024) <= os.time()) then
				player:say("You did this boss before 3 hours!", TALKTYPE_MONSTER_SAY)
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Someone did this boss before 3 hours.")
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
						player:say("Espere o oberon morrer para clicar na alavanca!", TALKTYPE_MONSTER_SAY)
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
		local monster = Game.createMonster("Gorzindel", Position(31524, 31967, 11))
		monster:setReward(true)
		for i = 1, #storePlayers do
			players = storePlayers[i]
		
			if not (players:getStorageValue(460024) <= os.time()) then
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
			player:setStorageValue(460024, os.time()+exaustedSeconds*10800)
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