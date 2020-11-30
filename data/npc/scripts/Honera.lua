 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)


function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
	local player = Player(cid)
	if(not(npcHandler:isFocused(cid))) then
		return false
	end
	local points = player:getStorageValue(25799)
	--points = 173
	if(msgcontains(msg, "points")) then
		if(points >= 5) then
		local aux, canremove, canpay = 0, 0, 0
		for i = 1, points do
		aux = aux + 1
		if aux == 5 then
			aux = 0
			canremove = canremove + 5
			canpay = canpay + 1
		end
		end
			npcHandler:say("voce tem "..points..". Posso te pagar "..canpay.." Tibia Coins em troca de "..canremove.." pontos. Voce quer continuar?", cid)
			npcHandler.topic[cid] = 1
		else
			npcHandler:say("Sorry, you dont have points.", cid)
		end
	elseif(msgcontains(msg, "yes")) then
		if(npcHandler.topic[cid] == 1) then
			local aux, canremove, canpay = 0, 0, 0
		for i = 1, points do
		aux = aux + 1
		if aux == 5 then
			aux = 0
			canremove = canremove + 5
			canpay = canpay + 1
		end
		end
			selfSay("aqui esta.", cid)
			--setar novamente os points
			player:setStorageValue(25799, player:getStorageValue(25799) - canremove)
			--dar os tibia coins
			player:setCoinsBalance(player:getCoinsBalance() + canpay)
			npcHandler.topic[cid] = 0
			
		end
	end

	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
