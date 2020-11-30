function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end
		
	if item:getActionId() == 19001 then
		if player:getStorageValue(Storage.bomberman.bombsize) == 10 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Sua bomba atinge o maximo (+10) de sqms.")
			return true
		end
		player:setStorageValue(Storage.bomberman.bombsize, player:getStorageValue(Storage.bomberman.bombsize) + 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Agora sua bomba atinge ate "..player:getStorageValue(Storage.bomberman.bombsize).." sqm.")
		item:remove()
	elseif item:getActionId() == 19002 then
		if player:getStorageValue(Storage.bomberman.maxbombammount) == 10 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce pode soltar o numero maximo (+10) de bombas.")
			return true
		end
		player:setStorageValue(Storage.bomberman.maxbombammount, player:getStorageValue(Storage.bomberman.maxbombammount) + 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Agora voce pode soltar ate "..player:getStorageValue(Storage.bomberman.maxbombammount).." bombas.")
		item:remove()	
	elseif item:getActionId() == 19003 then
		if player:getStorageValue(Storage.bomberman.bombermanspeed) == 10 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce esta com a speed (+10) maxima.")
			return true
		end
	
		local speed = player:getStorageValue(Storage.bomberman.bombermanspeed)
		if speed >= 0 and speed < 11 then
			player:setStorageValue(Storage.bomberman.bombermanspeed, player:getStorageValue(Storage.bomberman.bombermanspeed) + 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Agora sua speed esta +("..player:getStorageValue(Storage.bomberman.bombermanspeed)..") points.")
			doChangeSpeed(creature, getCreatureBaseSpeed(creature))
		end
		item:remove()	
	elseif item:getActionId() == 19004 then
		exitPosition = Position(1057, 923, 5) -- posic
		local team1, team2 = #BomberTeam1, #BomberTeam2
		if team1 == 0 or team2 == 0 then
			stopEvent(bombermanEnd)
			if team1 > team2 then
				for i = 1, #BomberTeam1 do
					if isPlayer(BomberTeam1[i]) then
					resetplayerbomberman(BomberTeam1[i])
					BomberTeam1[i]:sendTextMessage(MESSAGE_INFO_DESCR, "Seu time Venceu. Parabens!")
					--BomberTeam1[i]:addItem(2160) TIME A: Exemplo de recompensa que cada ganhador ganharia
					BomberTeam1[i]:setOutfit(BombermanOutfit[BomberTeam1[i]:getGuid()])
					end
					BomberTeam1[i]:teleportTo(Position(exitPosition))
				end
			else
				for i = 1, #BomberTeam2 do
					if isPlayer(BomberTeam2[i]) then
					resetplayerbomberman(BomberTeam2[i])
					BomberTeam2[i]:setOutfit(BombermanOutfit[BomberTeam2[i]:getGuid()])
					BomberTeam2[i]:sendTextMessage(MESSAGE_INFO_DESCR, "Seu time Venceu. Parabens!")
					--BomberTeam2[i]:addItem(2160) TIME B: Exemplo de recompensa que cada ganhador ganharia
					end
					BomberTeam2[i]:teleportTo(Position(exitPosition))
				end
			end
			BomberTeam1, BomberTeam2 = {}, {} 
			for i = 1, #BlockListBomberman do
				local powerItens = {2684, 4852, 2642}
				for pointer = 1, 3 do
				if Tile(BlockListBomberman[i]):getItemById(powerItens[pointer]) then
					remover = Tile(BlockListBomberman[i]):getItemById(powerItens[pointer])
					remover:remove()
				end
				end
				if not Tile(BlockListBomberman[i]):getItemById(9421) then
				Game.createItem(9421, 1, BlockListBomberman[i])
				end 
			end
		BlockListBomberman = {}
		BombermanPortal = 0
		item:remove()
		else
			-- o portal so pode ser usado se o time adversario estiver morto
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Restam integrantes do time adversario.")
		end
	end
	return true
end

function resetplayerbomberman(player)
	local player = Player(player)
		player:setStorageValue(Storage.bomberman.activebombs, -1)
		player:setStorageValue(Storage.bomberman.maxbombammount, -1)
		player:setStorageValue(Storage.bomberman.bombermanspeed, -1)
		doChangeSpeed(player, getCreatureBaseSpeed(player)-player:getSpeed())
end