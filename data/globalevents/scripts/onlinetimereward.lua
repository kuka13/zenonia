function onThink(interval)
	local playersPorIp = 3 -- Setando 1 aqui, somente 1 jogador por ip ganhará os coins.. setando mais, mais jogadores ganharão o bonus...
	local coins = 1 -- Setando 1 aqui, o player ganhará 1 coin, a cada timeMinutes (60 minutos)
	local timeMinutes = 60 --Quando o player atingir esse valor em minutos online, dar o premio e reiniciar a contagem.
	
	local ipList = {}
	for _, player in ipairs(Game.getPlayers()) do
		local playerIp = player:getIp()
		if (playerIp ~= 0) then
			if not table.contains(ipList, playerIp) then
				table.insert(ipList, playerIp)
			end
		else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Possuimos um sistema de online points a cada 60 minutos online, porem o seu ip retornou inválido.')
		print('ip inválido')
		end
	end
	for i = 1, #ipList do
		local players = getPlayersByIPAddress(ipList[i])
		for b = 1, #players do
			if b <= playersPorIp then
				local player = Player(players[b])
				if os.time() - player:getLastLoginSaved() > 60 then -- executar se a mais de 60s online.
					local check = player:getStorageValue(25898)
					if check < 1 then --storage nao utilizada, ou 0
						player:setStorageValue(25898, 1)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Fique online e ganhe 1 Online Points por hora!')
					elseif check >= 1 and check < timeMinutes then --aumentando contagem
						player:setStorageValue(25898, check + 1)
					
						if check == 10 then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Fique mais 50 minutos e ganhe 1 online point!')
						elseif check == 20 then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Fique mais 40 minutos e ganhe 1 online point!')
						elseif check == 30 then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Fique mais 30 minutos e ganhe 1 online point!')
						elseif check == 40 then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Fique mais 20 minutos e ganhe 1 online point!')
						elseif check == 50 then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Fique mais 10 minutos e ganhe 1 online point!')
						end
					
					elseif check >= timeMinutes then --se atingiu o tempo em minutos, dar o premio e reiniciar o timer
						player:setStorageValue(25898, 0) -- aqui vai ate 60 e volta pra 0
						if player:getStorageValue(25798) < 0 then
						player:setStorageValue(25798, 0)
						end
						player:setStorageValue(25798, player:getStorageValue(25798) + 1)-- aqui soma uma hora no total de horas online
						
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Ficou uma hora online, parabens, ganhou 1 online point!!!')
						--Aqui a função de Aumentar os coins, dependendo do servidor pode ter diferenças
						if player:getStorageValue(25799) < 0 then
						player:setStorageValue(25799, 0)
						end
						player:setStorageValue(25799, player:getStorageValue(25799) + 1)
					end
				end
			end
		end
	end
	return true
end