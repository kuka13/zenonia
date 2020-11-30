function onModalWindow(player, modalWindowId, buttonId, choiceId)
	local title = "Sistema de apostas!"
	
	if pBet1[getPlayerGUID(player)] == nil then
		pBet1[getPlayerGUID(player)], pBet2[getPlayerGUID(player)], pBet3[getPlayerGUID(player)], pBet4[getPlayerGUID(player)], pBet5[getPlayerGUID(player)] = 0,0,0,0,0
	end
	
	if buttonId == 100 and choiceId > 0 then
		local valores = {1000, 10000, 100000, 1000000}
		if choiceId >= 1 and choiceId < 6 then
			question(player, choiceId)
		elseif choiceId >= 11 and choiceId < 20 and getPlayerMoney(player) >= valores[choiceId-10] then
			doPlayerRemoveMoney(player, valores[choiceId-10])
			pBet1[getPlayerGUID(player)] = pBet1[getPlayerGUID(player)] + valores[choiceId-10]
		elseif choiceId >= 21 and choiceId < 30 and getPlayerMoney(player) >= valores[choiceId-20] then
			doPlayerRemoveMoney(player, valores[choiceId-20])
			pBet2[getPlayerGUID(player)] = pBet2[getPlayerGUID(player)] + valores[choiceId-20]
		elseif choiceId >= 31 and choiceId < 40 and getPlayerMoney(player) >= valores[choiceId-30] then
			doPlayerRemoveMoney(player, valores[choiceId-30])
			pBet3[getPlayerGUID(player)] = pBet3[getPlayerGUID(player)] + valores[choiceId-30]
		elseif choiceId >= 41 and choiceId < 50 and getPlayerMoney(player) >= valores[choiceId-40]then
			doPlayerRemoveMoney(player, valores[choiceId-40])
			pBet4[getPlayerGUID(player)] = pBet4[getPlayerGUID(player)] + valores[choiceId-40]
		elseif choiceId >= 51 and choiceId < 60 and getPlayerMoney(player) >= valores[choiceId-50] then
			doPlayerRemoveMoney(player, valores[choiceId-50])
			pBet5[getPlayerGUID(player)] = pBet5[getPlayerGUID(player)] + valores[choiceId-50]	
		end
	end
	
	local bid1, bid2, bid3, bid4, bid5 = pBet1[getPlayerGUID(player)], pBet2[getPlayerGUID(player)], pBet3[getPlayerGUID(player)], pBet4[getPlayerGUID(player)], pBet5[getPlayerGUID(player)]
	local totalcorridas = jokeywin[1]+jokeywin[2]+jokeywin[3]+jokeywin[4]+jokeywin[5]
	
	local message = "Estatisticas: \nCorridas atualmente realizadas: "..totalcorridas.."\n1: "..HorseNames[1].." > "..jokeywin[1].." Vitorias: "..string.format("%.0f", jokeywin[1]/totalcorridas*100).."%\n2: "..HorseNames[2].." > "..jokeywin[2].." Vitorias: "..string.format("%.0f", jokeywin[2]/totalcorridas*100).."%\n3: "..HorseNames[3].." > "..jokeywin[3].." Vitorias: "..string.format("%.0f", jokeywin[3]/totalcorridas*100).."%\n4: "..HorseNames[4].." > "..jokeywin[4].." Vitorias: "..string.format("%.0f", jokeywin[4]/totalcorridas*100).."%\n5: "..HorseNames[5].." > "..jokeywin[5].." Vitorias: "..string.format("%.0f", jokeywin[5]/totalcorridas*100).."%\n\nEscolha seu cavalo:\n(Gold disponivel: "..getPlayerMoney(player)..")"
	
	local window = ModalWindow(152, title, message)
	window:addChoice(1, "1: "..HorseNames[1].." - Gold: "..bid1.."")
	window:addChoice(2, "2: "..HorseNames[2].." - Gold: "..bid2.."")
	window:addChoice(3, "3: "..HorseNames[3].." - Gold: "..bid3.."")
	window:addChoice(4, "4: "..HorseNames[4].."  - Gold: "..bid4.."")
	window:addChoice(5, "5: "..HorseNames[5].."  - Gold: "..bid5.."")
	window:addButton(100, "Apostar")
	window:addButton(101, "Ok")
	window:addButton(102, "Cancel")
	
	if buttonId == 102 or buttonId == 101 then
		player:unregisterEvent('jokey')
	else
		window:sendToPlayer(player)
	end
		
	local wager = bid1+bid2+bid3+bid4+bid5
	if not table.contains(apostadores, player.uid) and wager > 0 then
		table.insert(apostadores, player.uid)
	end
end

function question(player, var)
	local offers = {{11,12,13,14}, {21,22,23,24}, {31,32,33,34}, {41,42,43,44}, {51,52,53,54}}
	local choices = offers[var]
	local window = ModalWindow(152, 'Sistema de apostas!', 'Selecione a quantidade:')
	window:addButton(100, "Apostar")
	window:addButton(102, "Cancel")
	window:addChoice(choices[1], "1000 gp (1k)")
	window:addChoice(choices[2], "10000 gp (10k)")
	window:addChoice(choices[3], "100000 gp (100k)")
	window:addChoice(choices[4], "1000000 gp (1kk)")
	window:sendToPlayer(player)
end