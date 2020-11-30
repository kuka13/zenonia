local attackitem, attackpricegain = 5902, 100
local defitem, defpricegain = 2152, 3
local extdefitem, extdefpricegain = 2148, 4
local armitem, armpricegain = 2159, 5

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
	local operation = 0
	local player = Player(cid)
	local itempay
	local itemPos = Npc():getPosition()
	itemPos.y = itemPos.y + 1
	
	--itemPos:sendMagicEffect(CONST_ME_TUTORIALARROW)	
	local item = Tile(itemPos):getTopDownItem()
	
	
	local itemType = ItemType(item:getId())
	
	
	
	
	if msgcontains(msg, "improve") then
		if player then
			if item then
				local options = {}
				if itemType:getAttack() > 0 then
					table.insert(options, "{Attack}")
				end
				if itemType:getDefense() > 0 then
					table.insert(options, "{Defense}")
				end
				if itemType:getExtraDefense() > 0 then
					table.insert(options, "{Extra Defense}")
				end
				if itemType:getArmor() > 0 then
					table.insert(options, "{Armor}")
				end
				local message = ""
				for i = 1, #options do
					if i == 1 then
						message = ""..message.." "..options[i]..""
						else
						message = ""..message.." and "..options[i]..""
					end
					
				end
				
				if #options < 1 then
					
						npcHandler:say("First put your item here.", cid)
						itemPos:sendMagicEffect(CONST_ME_TUTORIALARROW)	
						return
					
				end
				
				
				npcHandler:say("Very well, For this item i can improve the ".. message ..".", cid)
				npcHandler.topic[cid] = 1
			end
		end		
		elseif msgcontains(msg, "attack") and npcHandler.topic[cid] == 1 then
		
		local qtd = item:getAttribute(ITEM_ATTRIBUTE_ATTACK) - itemType:getAttack() + 1
		if qtd < 1 then
		qtd = 1
		end
		
		npcHandler:say("Okay, I can improve the attack of swords, axes and maces, as long as you have some items to pay me. To improve attack i need {".. qtd*attackpricegain .." ".. ItemType(attackitem):getName() .."}, say {yes} if you agree.", cid)
		npcHandler.topic[cid] = 2
		
		elseif msgcontains(msg, "extra defense") and npcHandler.topic[cid] == 1 then
		
		local qtd = item:getAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE) - itemType:getExtraDefense() + 1
		if qtd < 1 then
		qtd = 1
		end
		
		npcHandler:say("Okay, I can improve the extra defense, as long as you have some items to pay me. To improve attack i need {".. qtd*extdefpricegain .." ".. ItemType(extdefitem):getName() .."}, say {yes} if you agree.", cid)
		npcHandler.topic[cid] = 4
		elseif msgcontains(msg, "defense") and npcHandler.topic[cid] == 1 then
		
		local qtd = item:getAttribute(ITEM_ATTRIBUTE_DEFENSE) - itemType:getDefense() + 1
		if qtd < 1 then
		qtd = 1
		end
		
		npcHandler:say("Okay, I can improve the defense of shields, as long as you have some items to pay me. To improve attack i need {".. qtd*defpricegain .." ".. ItemType(defitem):getName() .."}, say {yes} if you agree.", cid)
		npcHandler.topic[cid] = 3
		elseif msgcontains(msg, "armor") and npcHandler.topic[cid] == 1 then
		
		local qtd = item:getAttribute(ITEM_ATTRIBUTE_ARMOR) - itemType:getArmor() + 1
		if qtd < 1 then
		qtd = 1
		end
		
		npcHandler:say("Okay, I can improve the armor of legs, armor and  helmets, as long as you have some items to pay me. To improve attack i need {".. qtd*armpricegain .." ".. ItemType(armitem):getName() .."}, say {yes} if you agree.", cid)
		npcHandler.topic[cid] = 5
		
		
		elseif msgcontains(msg, "yes") and npcHandler.topic[cid] >= 2 then
		
		local primary, current, new, tipo, cobraritem, cobrarquantidade
		
		if npcHandler.topic[cid] == 2 then
		-- attack
		tipo = ITEM_ATTRIBUTE_ATTACK
		primary = itemType:getAttack()
		current = item:getAttribute(tipo)
		cobraritem = attackitem
		cobrarquantidade = attackpricegain
		
		elseif npcHandler.topic[cid] == 3 then
		-- defense
		tipo = ITEM_ATTRIBUTE_DEFENSE
		primary = itemType:getDefense()
		current = item:getAttribute(tipo)
		cobraritem = defitem
		cobrarquantidade = defpricegain
		
		elseif npcHandler.topic[cid] == 4 then
		-- extra defense
		tipo = ITEM_ATTRIBUTE_EXTRADEFENSE
		primary = itemType:getExtraDefense()
		current = item:getAttribute(tipo)
		cobraritem = extdefitem
		cobrarquantidade = extdefpricegain
		
		elseif npcHandler.topic[cid] == 5 then
		-- armor
		tipo = ITEM_ATTRIBUTE_ARMOR
		primary = itemType:getArmor()
		current = item:getAttribute(tipo)
		cobraritem = armitem
		cobrarquantidade = armpricegain
		
		end
		
		if primary == 0 then
		npcHandler:say("Sorry! This item does not have the required attribute. Say {improve} to try another attribute.", cid)
		
		elseif primary > 0 and current - primary < 10 then
		local ammount = current - primary + 1
		if ammount < 1 then ammount = 1 end
		if getPlayerItemCount(cid, cobraritem) >= ammount*cobrarquantidade then
		if doPlayerRemoveItem(cid, cobraritem, ammount*cobrarquantidade) then 
		if current >= primary then
		new = current + 1
		else
		new = primary + 1
		end
		npcHandler:say("your item has been improved, if you want to improve it some more say {improve} again!", cid)
		itemPos:sendMagicEffect(CONST_ME_TUTORIALARROW)
		item:setAttribute(tipo, new)
		
		local textabela = {}
		local sum
		
		if itemType:getAttack() > 0 then
		sum = item:getAttribute(ITEM_ATTRIBUTE_ATTACK)
		if sum - itemType:getAttack() > 0 then
		table.insert(textabela, "Atk+ "..sum - itemType:getAttack().."")
		end
		end
		if itemType:getDefense() > 0 then
		sum = item:getAttribute(ITEM_ATTRIBUTE_DEFENSE)
		if sum - itemType:getDefense() > 0 then
		table.insert(textabela, "Def+ "..sum - itemType:getDefense().."")
		end
		end
		if itemType:getExtraDefense() > 0 then
		sum = item:getAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE)
		if sum - itemType:getExtraDefense() > 0 then
		table.insert(textabela, "ExtDef+ "..sum - itemType:getExtraDefense().."")
		end
		end
		if itemType:getArmor() > 0 then
		sum = item:getAttribute(ITEM_ATTRIBUTE_ARMOR)
		if sum - itemType:getArmor() > 0 then
		table.insert(textabela, "Arm+ "..sum - itemType:getArmor().."")
		end
		end
		local text = ''
		for n = 1, #textabela do
		text = ""..text.." "..textabela[n].." "
		end
		
		item:setAttribute(ITEM_ATTRIBUTE_NAME, "".. itemType:getName() .." ".. text .."")
		npcHandler.topic[cid] = 0
		end
		else
		npcHandler:say("dont have!", cid)
		end
		
		else
		npcHandler:say("this item has reached the maximum level of improvement, say {improve} to improve another item.", cid)
		npcHandler.topic[cid] = 0
		end
		
		
		end
		return true
		end
		
		npcHandler:setMessage(MESSAGE_WALKAWAY, "Wait, don't leave before trying on a improved item.")
		npcHandler:setMessage(MESSAGE_FAREWELL, "Next time we will try to improve you.")
		npcHandler:setMessage(MESSAGE_GREET, "Hello! I'm a Blacksmith, I can {improve} your item!")
		
		npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
		npcHandler:addModule(FocusModule:new())
				