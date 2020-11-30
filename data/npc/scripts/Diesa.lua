local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local voices = {
	{ text = 'Potions, food, drinks, anabol.' },
	{ text = 'Corn?' }
}

npcHandler:addModule(VoiceModule:new(voices))

local function releasePlayer(cid)
	if not Player(cid) then
		return
	end
	
	npcHandler:releaseFocus(cid)
	npcHandler:resetNpc(cid)
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	
	local player = Player(cid)
	local missionProgress, check = player:getStorageValue(Storage.Galinhas.Diesa), 0
	if msgcontains(msg, 'chicken') then
		local houses, house = Game.getHouses()
		for i = 1, #houses do
			house = houses[i]
			if house:getOwnerGuid() == player:getGuid() then
				check = 1
			end
		end
		if check >= 0 then
			if missionProgress < 1 then
				npcHandler:say({
					'hmmm...',
					'Chickens can be hard work, need to feed and care...',
					'Do you want to try? Say {yes}.'
				}, cid)
				npcHandler.topic[cid] = 1
				
				elseif missionProgress == 1 then
				npcHandler:say({
				'Agora que vc tem a galinha tenhos os seguintes consumiveis para venda:',
				'{Potion} custando 1k cada',
				'{Food} custando 1k cada',
				'{Pinga} custando 1k cada'
					}, cid)
				npcHandler.topic[cid] = 2
				
				else
				npcHandler:say('Fale com o papai sobre como chocar a galinha', cid)
			end
			else
			npcHandler:say({
				'You need a {house} to have a chicken.',
				'Get a house and come back here.'
			}, cid)
		end
		
		elseif npcHandler.topic[cid] == 1 then
		if msgcontains(msg, 'yes') then
			npcHandler:say({
				'talk to tordek to buy an egg and put it in your house to wait for the time of birth...',
				'my dad will give you more instructions on how to hatch the egg.'
			}, cid)
			player:setStorageValue(Storage.Galinhas.Diesa, 1)
			
			elseif msgcontains(msg, 'no') then
			npcHandler:say('Your choice.', cid)
			npcHandler.topic[cid] = 0
			
			--elseif msgcontains(msg, 'trade') then
			--npcHandler:say('Trade.', cid)
			--npcHandler.topic[cid] = 0
			
			
		end
		
		elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, 'potion') then
			npcHandler:say({
				'potion...',
				'galinha...',
				'galinha...',
				'galinha...',
				'galinha...',
				'galinha!'
			}, cid)
			local potions = player:getStorageValue(Storage.Galinhas.Potion)
			if potions < 0 then
			player:setStorageValue(Storage.Galinhas.Potion, 1)
			else
			player:setStorageValue(Storage.Galinhas.Potion, potions + 1)
			end
			--player:setStorageValue(Storage.DjinnWar.EfreetFaction.DoorToMaridTerritory, 1)
			
			--addEvent(releasePlayer, 1000, cid)
			
		elseif msgcontains(msg, 'food') then
			npcHandler:say({
				'food...',
				'galinha...',
				'galinha...',
				'galinha...',
				'galinha...',
				'galinha!'
			}, cid)
			
			local foods = player:getStorageValue(Storage.Galinhas.Food)
			if foods < 0 then
			player:setStorageValue(Storage.Galinhas.Food, 1)
			else
			player:setStorageValue(Storage.Galinhas.Food, foods + 1)
			end
			--player:setStorageValue(Storage.DjinnWar.EfreetFaction.Mission03, 3)
			--player:setStorageValue(Storage.DjinnWar.EfreetFaction.DoorToMaridTerritory, 1)
			
			--addEvent(releasePlayer, 1000, cid)
		elseif msgcontains(msg, 'pinga') then
			npcHandler:say({
				'pinga...',
				'galinha...',
				'galinha...',
				'galinha...',
				'galinha...',
				'galinha!'
			}, cid)
			--player:setStorageValue(Storage.DjinnWar.EfreetFaction.Mission03, 3)
			--player:setStorageValue(Storage.DjinnWar.EfreetFaction.DoorToMaridTerritory, 1)
			
			--addEvent(releasePlayer, 1000, cid)
			
			local pingas = player:getStorageValue(Storage.Galinhas.Pinga)
			if pingas < 0 then
			player:setStorageValue(Storage.Galinhas.Pinga, 1)
			else
			player:setStorageValue(Storage.Galinhas.Food, pingas + 1)
			end
		
		
		
		elseif msgcontains(msg, 'no') then
			npcHandler:say('Just do it!', cid)
		end
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Greetings, |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Farewell.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Farewell.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

local focusModule = FocusModule:new()
focusModule:addGreetMessage('hi')
focusModule:addGreetMessage('hello')
npcHandler:addModule(focusModule)
