local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

-- Travel
local function addTravelKeyword(keyword, cost, destination, action, condition)
	if condition then
		keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry but I don\'t sail there.'}, condition)
	end
	
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a passage to ' .. keyword:titleCase() .. ' for |TRAVELCOST|?', cost = cost, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, cost = cost, discount = 'postman', destination = destination}, nil, action)
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to serve you some time.', reset = true})
end

-- Basic
keywordHandler:addKeyword({'halloween'}, StdModule.say, {npcHandler = npcHandler, text = 'Visite www.warzona.com para ficar por dentro do nosso evento de Halloween!'})

npcHandler:setMessage(MESSAGE_GREET, 'Ora ora... Mas já era hora de aparecer por aqui meu caro, |PLAYERNAME|. Gostaria de saber mais sobre nosso evento de {Halloween} ?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Espero ver você por lá...')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Não me de as costas! Vou lembrar de você!')

npcHandler:addModule(FocusModule:new())
