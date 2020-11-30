local config = {
	levers = {
		[1945] = 1946, [1946] = 1945
	},
	
	fromPositions = {
	-- aqui colocar os 5 sqm de entrada do time A
		[1] = Position(1046, 1027, 7),
		[2] = Position(1047, 1027, 7),
		[3] = Position(1048, 1027, 7),
		[4] = Position(1049, 1027, 7),
		[5] = Position(1050, 1027, 7),
	--aqui colocar os 5 sqm de entrada do time B	
		[6] = Position(1046, 1029, 7),
		[7] = Position(1047, 1029, 7),
		[8] = Position(1048, 1029, 7),
		[9] = Position(1049, 1029, 7),
		[10] = Position(1050, 1029, 7)
	},
	
	toPositions = {
	-- aqui colocar os 5 sqm do time A na arena
		[1] = Position(1003, 1017, 7),
		[2] = Position(1009, 1023, 7),
		[3] = Position(1003, 1029, 7),
		[4] = Position(1011, 1035, 7),
		[5] = Position(1003, 1041, 7),
	-- aqui colocar os 5 sqm do time B na arena
		[6] = Position(1030, 1017, 7),
		[7] = Position(1024, 1023, 7),
		[8] = Position(1030, 1029, 7),
		[9] = Position(1022, 1035, 7),
		[10] = Position(1030, 1041, 7)
	}
	
}


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if #BomberTeam1 > 0 or #BomberTeam2 > 0 then
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Existe uma partida em andamento.")
	return true
	end
	
	
	local players = {}
	
	for pos = 1, 10 do
		local creature = Tile(config.fromPositions[pos]):getTopCreature()
		if creature then --and creature:isPlayer() then -- *Se quiser permitir monstros entrar no bomberman trocar por (if creature) apenas.
			table.insert(players, creature)
		end
	end
	
	if #players == 10 then
		for i = 1, 10 do
		if players[i]:isPlayer() then
			BombermanOutfit[players[i]:getGuid()] = players[i]:getOutfit()
	    end
			players[i]:teleportTo(config.toPositions[i])
			if isPlayer(players[i]) then
				getPlayerPosition(players[i]):sendMagicEffect(CONST_ME_TELEPORT)
				if i <= 5 then
					players[i]:setOutfit({lookBody = 88, lookAddons = 0, lookType = 619, lookHead = 114, lookMount = 0, lookLegs = 114, lookFeet = 114})	
				else
					players[i]:setOutfit({lookBody = 94, lookAddons = 0, lookType = 619, lookHead = 114, lookMount = 0, lookLegs = 114, lookFeet = 114})
				end
				elseif isMonster(players[i]) then
				getCreaturePosition(players[i]):sendMagicEffect(CONST_ME_TELEPORT)
			end		
			if i <= 5 then
				table.insert(BomberTeam1, players[i])
				else
				table.insert(BomberTeam2, players[i])
			end
			if isPlayer(players[i]) then
				players[i]:setStorageValue(Storage.bomberman.bombsize, 1)
				players[i]:setStorageValue(Storage.bomberman.maxbombammount, 1)
				players[i]:setStorageValue(Storage.bomberman.bombermanspeed, 1)
			end
		end
		
		bombermanEnd = addEvent(endGame, 60 * 10 * 1000)
		broadcastMessage("A partida de Bomberman acaba em 10 minutos.", MESSAGE_EVENT_ADVANCE)
	end
	
	item:transform(config.levers[item.itemid])
	item:decay()
	return true
end

function endGame()
	exitPosition = Position(32363, 32240, 5) --se nao houve ganhador, enviar players restantes para
	broadcastMessage("A partida de bomberman acabou. Nenhum time venceu", MESSAGE_EVENT_ADVANCE)
	for i = 1, #BomberTeam1 do
		if isPlayer(BomberTeam1[i]) then
			resetplayerbomberman(BomberTeam1[i])
			BomberTeam1[i]:setOutfit(BombermanOutfit[BomberTeam1[i]:getGuid()])
		end
		BomberTeam1[i]:teleportTo(Position(exitPosition))
	end
	for i = 1, #BomberTeam2 do
		if isPlayer(BomberTeam2[i]) then
			resetplayerbomberman(BomberTeam2[i])
			BomberTeam2[i]:setOutfit(BombermanOutfit[BomberTeam2[i]:getGuid()])
		end
		BomberTeam2[i]:teleportTo(Position(exitPosition))
	end
	
	for i = 1, #BlockListBomberman do	-- limpar e reconstruir mapa para proxima partida		
			local powerItens = {2684, 4852, 2642}
			for pointer = 1, 3 do
			if Tile(BlockListBomberman[i]):getItemById(powerItens[pointer]) then --removendo powerups da partida anterior
			remover = Tile(BlockListBomberman[i]):getItemById(powerItens[pointer])
			remover:remove()
			end
			end
			if not Tile(BlockListBomberman[i]):getItemById(9421) then
			Game.createItem(9421, 1, BlockListBomberman[i])
			end
		end
	BomberTeam1, BomberTeam2 = {}, {} -- zerando todos os parametros para proxima partida
	BlockListBomberman = {}
	BombermanPortal = 0
end

function resetplayerbomberman(player)
	local player = Player(player)
	player:setStorageValue(Storage.bomberman.activebombs, -1)
	player:setStorageValue(Storage.bomberman.maxbombammount, -1)
	player:setStorageValue(Storage.bomberman.bombermanspeed, -1)
	doChangeSpeed(player, getCreatureBaseSpeed(player)-player:getSpeed())
end
