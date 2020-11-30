local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local player = Player(cid)
	if(msgcontains(msg, "mission")) then
		if(os.date("%A") == "Monday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission01) < 1) then
				npcHandler:say("Well, you could attempt the mission to become a recognised trader, but it requires a lot of travelling. Are you willing to try?", cid)
				npcHandler.topic[cid] = 1
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission01) == 1) then
				npcHandler:say("Have you managed to obtain a rare deer trophy for my customer?", cid)
				npcHandler.topic[cid] = 3
			end
		elseif(os.date("%A") == "Tuesday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission01) == 2 and player:getStorageValue(Storage.TravellingTrader.Mission02) < 1 ) then
				npcHandler:say("So, my friend, are you willing to proceed to the next mission to become a recognised trader?", cid)
				npcHandler.topic[cid] = 4
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission02) == 4) then
				npcHandler:say("Did you bring me the package?", cid)
				npcHandler.topic[cid] = 6
			end
		elseif(os.date("%A") == "Wednesday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission02) == 5 and player:getStorageValue(Storage.TravellingTrader.Mission03) < 1 ) then
				npcHandler:say("So, my friend, are you willing to proceed to the next mission to become a recognised trader?", cid)
				npcHandler.topic[cid] = 7
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission03) == 2) then
				npcHandler:say("Have you brought the cheese?", cid)
				npcHandler.topic[cid] = 9
			end
		elseif(os.date("%A") == "Thursday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission03) == 3 and player:getStorageValue(Storage.TravellingTrader.Mission04) < 1) then
				npcHandler:say("So, my friend, are you willing to proceed to the next mission to become a recognised trader?", cid)
				npcHandler.topic[cid] = 10
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission04) == 2) then
				npcHandler:say("Have you brought the vase?", cid)
				npcHandler.topic[cid] = 12
			end
		elseif(os.date("%A") == "Friday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission04) == 3 and player:getStorageValue(Storage.TravellingTrader.Mission05) < 1) then
				npcHandler:say("So, my friend, are you willing to proceed to the next mission to become a recognised trader?", cid)
				npcHandler.topic[cid] = 13
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission05) == 2) then
				npcHandler:say("Have you brought a cheap but good crimson sword?", cid)
				npcHandler.topic[cid] = 15
			end
		elseif(os.date("%A") == "Saturday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission05) == 3 and player:getStorageValue(Storage.TravellingTrader.Mission06) < 1) then
				npcHandler:say("So, my friend, are you willing to proceed to the next mission to become a recognised trader?", cid)
				npcHandler.topic[cid] = 16
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission06) == 1) then
				npcHandler:say("Have you brought me a gold fish??", cid)
				npcHandler.topic[cid] = 18
			end
		elseif(os.date("%A") == "Sunday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission06) == 2 and player:getStorageValue(Storage.TravellingTrader.Mission07) ~= 1) then
				npcHandler:say("Ah, right. <ahem> I hereby declare you - one of my recognised traders! Feel free to offer me your wares!", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission07, 1)
				player:addAchievement('Recognised Trader')
				npcHandler.topic[cid] = 0
			end
		end
	elseif(msgcontains(msg, "yes")) then
		if(npcHandler.topic[cid] == 1) then
			npcHandler:say({
				"Very good! I need talented people who are able to handle my wares with care, find good offers and the like, so I'm going to test you. ...",
				"First, I'd like to see if you can dig up rare wares. Something like a ... mastermind shield! ...",
				"Haha, just kidding, fooled you there, didn't I? Always control your nerves, that's quite important during bargaining. ...",
				"Okay, all I want from you is one of these rare deer trophies. I have a customer here in Svargrond who ordered one, so I'd like you to deliver it tome while I'm in Svargrond. ...",
				"Everything clear and understood?"
			}, cid)

			npcHandler.topic[cid] = 2
		elseif(npcHandler.topic[cid] == 2) then
			npcHandler:say("Fine. Then get a hold of that deer trophy and bring it to me while I'm in Svargrond. Just ask me about your mission.", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission01, 1)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 3) then
			if player:removeItem(7397, 1) then
				npcHandler:say("Well done! I'll take that from you. <snags it> Come see me another day, I'll be busy for a while now. ", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission01, 2)
				npcHandler.topic[cid] = 0
			end
		elseif(npcHandler.topic[cid] == 4) then
			npcHandler:say({
				"Alright, that's good to hear. From you as my trader and deliveryman, I expect more than finding rare items. ...",
				"You also need to be able to transport heavy wares, weaklings won't get far here. I have ordered a special package from Edron. ...",
				"Pick it up from Willard and bring it back to me while I'm in Liberty Bay. Everything clear and understood?"
			}, cid)
			npcHandler.topic[cid] = 5
		elseif(npcHandler.topic[cid] == 5) then
			npcHandler:say("Fine. Then off you go, just ask Willard about the 'package for Rashid'.", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission02, 1)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 6) then
			if player:removeItem(7503, 1) then
				npcHandler:say("Great. Just place it over there - yes, thanks, that's it. Come see me another day, I'll be busy for a while now. ", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission02, 5)
				npcHandler.topic[cid] = 0
			end
		elseif(npcHandler.topic[cid] == 7) then
			npcHandler:say({
				"Well, that's good to hear. From you as my trader and deliveryman, I expect more than carrying heavy packages. ...",
				"You also need to be fast and deliver wares in time. I have ordered a very special cheese wheel made from Darashian milk. ...",
				"Unfortunately, the high temperature in the desert makes it rot really fast, so it must not stay in the sun for too long. ...",
				"I'm also afraid that you might not be able to use ships because of the smell of the cheese. ...",
				"Please get the cheese from Miraia and bring it to me while I'm in Port Hope. Everything clear and understood?"
			}, cid)
			npcHandler.topic[cid] = 8
		elseif(npcHandler.topic[cid] == 8) then
			npcHandler:say("Okay, then please find Miraia in Darashia and ask her about the {'scarab cheese'}.", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission03, 1)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 9) then
			if player:removeItem(8112, 1) then
				npcHandler:say("Mmmhh, the lovely odeur of scarab cheese! I really can't understand why most people can't stand it. Thanks, well done! ", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission03, 3)
				npcHandler.topic[cid] = 0
			end
		elseif(npcHandler.topic[cid] == 10) then
			npcHandler:say({
				"Well, that's good to hear. From you as my trader and deliveryman, I expect more than bringing stinky cheese. ...",
				"I wonder if you are able to deliver goods so fragile they almost break when looked at. ...",
				"I have ordered a special elven vase from Briasol in Ab'Dendriel. Get it from him and don't even touch it, just bring it to me while I'm in Ankrahmun. Everything clear and understood?"
			}, cid)
			npcHandler.topic[cid] = 11
		elseif(npcHandler.topic[cid] == 11) then
			npcHandler:say("Okay, then please find {Briasol} in {Ab'Dendriel} and ask for a {'fine vase'}.", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission04, 1)
			player:addMoney(1000)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 12) then
			if player:removeItem(8760, 1) then
				npcHandler:say("I'm surprised that you managed to bring this vase without a single crack. That was what I needed to know, thank you. ", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission04, 3)
				npcHandler.topic[cid] = 0
			end
		elseif(npcHandler.topic[cid] == 13) then
			npcHandler:say({
				"Fine! There's one more skill that I need to test and which is cruicial for a successful trader. ...",
				"Of course you must be able to haggle, else you won't survive long in this business. To make things as hard as possible for you, I have the perfect trade partner for you. ...",
				"Dwarves are said to be the most stubborn of all traders. Travel to {Kazordoon} and try to get the smith {Uzgod} to sell a {crimson sword} to you. ...",
				"Of course, it has to be cheap. Don't come back with anything more expensive than 400 gold. ...",
				"And the quality must not suffer, of course! Everything clear and understood?",
				"Dwarves are said to be the most stubborn of all traders. Travel to Kazordoon and try to get the smith Uzgod to sell a crimson sword to you. ..."
			}, cid)
			npcHandler.topic[cid] = 14
		elseif(npcHandler.topic[cid] == 14) then
			npcHandler:say("Okay, I'm curious how you will do with {Uzgod}. Good luck!", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission05, 1)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 15) then
			if player:removeItem(7385, 1) then
				npcHandler:say("Ha! You are clever indeed, well done! I'll take this from you. Come see me tomorrow, I think we two might get into business after all.", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission05, 3)
				npcHandler.topic[cid] = 0
			end
		elseif(npcHandler.topic[cid] == 16) then
			npcHandler:say({
				"My friend, it seems you have already learnt a lot about the art of trading. I think you are more than worthy to become a recognised trader. ...",
				"There is just one little favour that I would ask from you... something personal, actually, forgive my boldness. ...",
				"I have always dreamed to have a small pet, one that I could take with me and which wouldn't cause problems. ...",
				"Could you - just maybe - bring me a small goldfish in a bowl? I know that you would be able to get one, wouldn't you?"
			}, cid)
			npcHandler.topic[cid] = 17
		elseif(npcHandler.topic[cid] == 17) then
			npcHandler:say("Thanks so much! I'll be waiting eagerly for your return then.", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission06, 1)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 18) then
			if player:removeItem(8766, 1) then
				npcHandler:say("Thank you!! Ah, this makes my day! I'll take the rest of the day off to get to know this little guy. Come see me tomorrow, if you like.", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission06, 2)
				npcHandler.topic[cid] = 0
			end
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ah, a customer! Be greeted, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, |PLAYERNAME|, may the winds guide your way.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Come back soon!")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Take all the time you need to decide what you want!")

local function onTradeRequest(cid)
	
	return true
end

npcHandler:setCallback(CALLBACK_ONTRADEREQUEST, onTradeRequest)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
