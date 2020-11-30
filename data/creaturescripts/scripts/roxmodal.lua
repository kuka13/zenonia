function onModalWindow(player, modalWindowId, buttonId, choiceId)
	if buttonId == 102 then
		if modalWindowId == 175 then
			local valores = {1,3,5}
			
			local coinplayer = player:getCoinsBalance()
			if coinplayer < valores[choiceId] then
			 player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Saldo insuficiente de tibia coins.")
			 return true
			else
			player:setCoinsBalance(coinplayer-valores[choiceId])
			end
			
			
			
			
			local title, message = 'Confirmado', 'Sua aposta foi de '..valores[choiceId]..' tibia coins no bilhete '..megatemp1[player:getGuid()]..''..megatemp2[player:getGuid()]..''..megatemp3[player:getGuid()]..''
			local window = ModalWindow(modalWindowId+1, title, message)
			window:addButton(102, "Ok")
			window:sendToPlayer(player)
			player:unregisterEvent('roxmodal')
			
			megaplayer[#megaplayer+1] = player:getGuid()
			megabilhete1[#megabilhete1+1] = megatemp1[player:getGuid()]
			megabilhete2[#megabilhete2+1] = megatemp2[player:getGuid()]
			megabilhete3[#megabilhete3+1] = megatemp3[player:getGuid()]
			megavalor[#megavalor+1] = valores[choiceId]
			print(#megabilhete1)
			return true
		end
		player:unregisterEvent('roxmodal')
		return true
	end
	
	local mul = 1
	if buttonId == 100 and choiceId >= 1 then
		if modalWindowId == 172 then
			megatemp1[player:getGuid()] = choiceId
			elseif modalWindowId == 173 then
			megatemp2[player:getGuid()] = choiceId
			elseif modalWindowId == 174 then
		megatemp3[player:getGuid()] = choiceId
		end
		
		
	end
	
	local title = "Sistema de apostas!"
	local message = ""
	
	
	
	if modalWindowId >= 171 then
		message = "Faca o seu Bilhete: Escolha o ".. modalWindowId-170 .." numero"
	end
	
	
	
	local window = ModalWindow(modalWindowId+1, title, message)
	window:addButton(100, "Apostar")
	window:addButton(102, "Cancel")
	window:addChoice(1, "1")
	window:addChoice(2, "2")
	window:addChoice(3, "3")
	window:addChoice(4, "4")
	window:addChoice(5, "5")
	window:addChoice(6, "6")
	window:addChoice(7, "7")
	window:addChoice(8, "8")
	window:addChoice(9, "9")
	window:addChoice(10, "0")
		
	if modalWindowId == 174 or  buttonId == 102 then
		--player:unregisterEvent('roxmodal')
		title = 'OK'
		message = 'Bilhete '..megatemp1[player:getGuid()]..''..megatemp2[player:getGuid()]..''..megatemp3[player:getGuid()]..' \n Escolha agora o valor da aposta:'
		
		
		local window = ModalWindow(modalWindowId+1, title, message)
		window:addButton(102, "ok")
		
		window:addChoice(1, "1 Tibia Coin")
		window:addChoice(2, "3 Tibia Coins")
		window:addChoice(3, "5 Tibia Coins")
		
		window:sendToPlayer(player)
		--return true
	end	
	
	window:sendToPlayer(player)
	
	
	
end
