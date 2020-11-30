local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, "apostar") then
		if player then
			npcHandler:say("Grande apostador voce, ne? Se voce ganhar, Te darei ate 100x o valor da sua aposta. Hehehe! Diga {Yes} para prosseguir.", cid)
			npcHandler.topic[cid] = 1
		end		
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 1 then
		npcHandler:say("Mnjam.", cid)
		player:registerEvent('roxmodal')
		local title = "Rox Apostador!"
		local message = "Bem vindo ao sistema de apostas: \n\nComo Jogar: Monte um bilhete selecionando tres numeros de 0 a 9. Apos selecione a quantidade de Tibia Coins.\n\nExemplo: Bilhete 579, 1 tibia coin.\n\nPremios: \nAcertou 1 Numero: Ganha 10 Silver Token. \nAcertou 2 numeros: Recupera seus Tibia coins apostados + 10 Gold Token.\nAcertou todos os numeros: Ganha o valor da aposta x100."
		local window = ModalWindow(171, title, message)
		window:addButton(103, "OK")
		window:sendToPlayer(player)
	end
	return true
end




npcHandler:setMessage(MESSAGE_WALKAWAY, "Espera! Nao saia! Eu quero te falar sobre numeros surreais nas apostas.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Proxima vez nos podemos falar sobre os meus numeros surreais.")
npcHandler:setMessage(MESSAGE_GREET, "Ahn? O que? Ah sim, estou vendo! Uau! Um apostador. Voce gostaria de Apostar? Diga {Apostar}")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
