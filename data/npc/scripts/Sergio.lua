local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Eu vou te julgar seu prisioneiro, infligindo as leis warzona!'} }
npcHandler:addModule(VoiceModule:new(voices))

-- Travel
local function addTravelKeyword(keyword, cost, destination, action, condition)
	if condition then
		keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry but I don\'t sail there.'}, condition)
	end
	
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Vai pagar a fian�a no valor de |TRAVELCOST|?', cost = 100000000, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, cost = cost, discount = 'postman', destination = destination}, nil, action)
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'Ent�o vai apodrecer ai man�!', reset = true})
end

addTravelKeyword('sair', 80000000, Position(32326, 31994, 7))
addTravelKeyword('exit', 80000000, Position(32326, 31994, 7))

 
-- Basic
keywordHandler:addKeyword({'trip'}, StdModule.say, {npcHandler = npcHandler, text = 'Onde voce deseja ir prisioneiro? Para {Sair} ou {Exit} ?'})
keywordHandler:addKeyword({'route'}, StdModule.say, {npcHandler = npcHandler, text = 'Onde voce deseja ir prisioneiro?? Para {Sair} ou {Exit} ?'})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Onde voce deseja ir prisioneiro?? Para {Sair} ou {Exit} ?'})
keywordHandler:addKeyword({'town'}, StdModule.say, {npcHandler = npcHandler, text = 'Onde voce deseja ir prisioneiro?? Para {Sair} ou {Exit} ?'})
keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, text = 'Onde voce deseja ir prisioneiro?? Para {Sair} ou {Exit} ?'})
keywordHandler:addKeyword({'sail'}, StdModule.say, {npcHandler = npcHandler, text = 'Onde voce deseja ir prisioneiro?? Para {Sair} ou {Exit} ?'})
keywordHandler:addKeyword({'go'}, StdModule.say, {npcHandler = npcHandler, text = 'Onde voce deseja ir prisioneiro?? Para {Sair} ou {Exit} ?'})

npcHandler:setMessage(MESSAGE_GREET, 'Bem vindo a pris�o man�, |PLAYERNAME|. Ta gostando? espero que fique bastante!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Vacil�o. Olha pra baixo e abaixa sua bola!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Vlw.')

npcHandler:addModule(FocusModule:new())


