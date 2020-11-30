local config = {
	requiredLevel = 200,
	daily = true,
	BossPosition = Position(31986, 32842, 14),
	MinosPosition = Position(31986, 32841, 14),
	centerDemonRoomPosition = Position(31985, 32847, 14),
	playerPositions = {
		Position(32018, 32844, 14), -- Posição dos players 1,2,3,4,5
		Position(32018, 32845, 14),
		Position(32018, 32846, 14),
		Position(32018, 32847, 14),
		Position(32018, 32848, 14),
		Position(32019, 32844, 14),
		Position(32019, 32845, 14),
		Position(32019, 32846, 14),
		Position(32019, 32847, 14),
		Position(32019, 32848, 14),
		Position(32020, 32844, 14),
		Position(32020, 32845, 14),
		Position(32020, 32846, 14),
		Position(32020, 32847, 14),
		Position(32020, 32848, 14)
	},
	newPositions = {
		Position(31982, 32853, 14),
		Position(31983, 32853, 14),
		Position(31984, 32853, 14),
		Position(31985, 32853, 14),
		Position(31986, 32853, 14),
		Position(31987, 32853, 14),
		Position(31988, 32853, 14),
		Position(31989, 32853, 14),
		Position(31990, 32853, 14),
		Position(31982, 32854, 14),
		Position(31983, 32854, 14),
		Position(31984, 32854, 14),
		Position(31985, 32854, 14),
		Position(31986, 32854, 14),
		Position(31987, 32854, 14)
	},
}


function onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)
	if item.itemid == 9825 then
	    if player:getPosition() ~= Position(32019, 32844, 14) then
			item:transform(9826)
			return true
		end	
		local storePlayers, playerTile = {}
		local exaustedSeconds = 1
		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not (player:getStorageValue(49005) <= os.time()) then
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
					if player:getPosition() ~= Position(32019, 32844, 14) then
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
		local monster = Game.createMonster("The Last Lore Keeper", Position(31986, 32842, 14))
		monster:setReward(true)
		for i = 1, #storePlayers do
			players = storePlayers[i]
		
			if not (players:getStorageValue(49005) <= os.time()) then
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
			player:setStorageValue(49005, os.time()+exaustedSeconds*72000)
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