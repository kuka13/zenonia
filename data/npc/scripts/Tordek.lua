local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local voices = {
	{ text = 'Anita, Amarelinha, Caramela, Lindinha, Lulu, Marota e Pipoca.' },
	{ text = 'Anita, Amarelinha, Caramela, Lindinha, Lulu, Marota e Pipoca.' }
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
	local missionProgress = player:getStorageValue(Storage.Galinhas.Tordek)
	if msgcontains(msg, 'chicken') then
		if player:getStorageValue(Storage.Galinhas.Diesa) == 1 then
			if missionProgress < 1 then
				npcHandler:say({
					'Vi que vc falou com a Diesa...',
					'Ela disse que vc ja possui uma house e gostaria de ter uma galinha...',
					'Esta pronto?'
				}, cid)
				npcHandler.topic[cid] = 1

			elseif missionProgress == 1 then
				npcHandler:say('voce ja tem galinha.', cid)
				npcHandler.topic[cid] = 1

			elseif missionProgress == 2 then
				npcHandler:say('galinha?', cid)
				npcHandler.topic[cid] = 2
			else
				npcHandler:say('galinha.', cid)
			end
		else
			npcHandler:say({
				'I don\'t know what you\'re talking about. There are no chickens here...',
				'Unless you\'re friends with Diesa. Talk to her first..'
			}, cid)
		end

	elseif npcHandler.topic[cid] == 1 then
		if msgcontains(msg, 'yes') then
			npcHandler:say({
				'Voce agora possui uma galinha..',
				'Lembre sempre de alimentar ela...',
				'pode falar com a Diesa para adquirir upgrades ...',
				'Voce podera ver a sua galinha dentro da arena de batalha ...',
				'Volte logo'
			}, cid)
			player:setStorageValue(Storage.Galinhas.Tordek, 1)
			

		elseif msgcontains(msg, 'no') then
			npcHandler:say('Your choice.', cid)
			npcHandler.topic[cid] = 0
		end

	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, 'yes') then
			npcHandler:say({
				'galinha...',
				'galinha...',
				'galinha...',
				'galinha...',
				'galinha...',
				'galinha!'
			}, cid)
			--player:setStorageValue(Storage.DjinnWar.EfreetFaction.Mission03, 3)
			--player:setStorageValue(Storage.DjinnWar.EfreetFaction.DoorToMaridTerritory, 1)
			--player:addAchievement('Efreet Ally')
			addEvent(releasePlayer, 1000, cid)

		elseif msgcontains(msg, 'no') then
			npcHandler:say('Just do it!', cid)
		end
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Greetings, |PLAYERNAME|. I\'ll tell you that I don\'t sell {CHICKEN}.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Farewell.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Farewell.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

local focusModule = FocusModule:new()
focusModule:addGreetMessage('hi')
focusModule:addGreetMessage('hello')
npcHandler:addModule(focusModule)
