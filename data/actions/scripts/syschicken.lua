local function doFight(a, b)
	--print('funcaodofight')
	local randomSeed = math.random(1, 3)
	print(randomSeed)
	local galinha1, galinha2 = Monster(a), Monster(b)
	if galinha1 and galinha2 then
	if randomSeed == 1  then
	--galinha1:getPosition():sendMagicEffect(CONST_ME_POFF)
	if math.random(100) > 90 then
	doTargetCombatHealth(0, galinha1, COMBAT_PHYSICALDAMAGE, -1, -1, CONST_ME_POFF)
	end
	elseif randomSeed == 2 then
	--galinha2:getPosition():sendMagicEffect(CONST_ME_POFF)
	if math.random(100) > 90 then
	doTargetCombatHealth(0, galinha2, COMBAT_PHYSICALDAMAGE, -1, -1, CONST_ME_POFF)
	end
	elseif randomSeed == 3 then
	--galinha1:getPosition():sendMagicEffect(CONST_ME_POFF)
	--galinha2:getPosition():sendMagicEffect(CONST_ME_POFF)
	if math.random(100) > 90 then
	doTargetCombatHealth(0, galinha1, COMBAT_PHYSICALDAMAGE, -1, -1, CONST_ME_POFF)
	doTargetCombatHealth(0, galinha2, COMBAT_PHYSICALDAMAGE, -1, -1, CONST_ME_POFF)
	end
	end
	end
if Monster(galinha1) and Monster(galinha2) then
addEvent(doFight, 1000, galinha1.uid, galinha2.uid)
end
end
function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	local chickens, Pchickens = {}, {}
	if item.actionid == 25902 then
		local entradapositions = {Position(32476, 32208, 8), Position(32478, 32208, 8)}
		local arenapositions = {Position(32474, 32199, 8), Position(32480, 32199, 8)}
		local galinhapositions = {Position(32476, 32202, 8), Position(32477, 32196, 8)}
		if Tile(entradapositions[1]):getTopCreature() or Tile(entradapositions[2]):getTopCreature() then
			for i = 1, #entradapositions do
				local position = entradapositions[i]
				local playerTile = Tile(position):getTopCreature()
				
				if playerTile and playerTile:isPlayer() then 					
					playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
					playerTile:teleportTo(arenapositions[i])
					playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					local lutador = Game.createMonster("Chicken", galinhapositions[i])
					table.insert(chickens, lutador.uid)
					table.insert(Pchickens, playerTile.uid)
					lutador:setMaster(playerTile)
				end
				
			end
			for i = 1, 2 do
			local galinha1, galinha2
			if i == 1 then
			galinha1, galinha2 = Monster(chickens[1]), Monster(chickens[2])
			else
			galinha1, galinha2 = Monster(chickens[2]), Monster(chickens[1])
			end
				galinha1:setTarget(galinha2)
			end
			if Monster(chickens[1]) and Monster(chickens[2]) then
			doFight(Monster(chickens[1]), Monster(chickens[2]))
			addEvent(doFight, 1000, Monster(chickens[1]).uid, Monster(chickens[2]).uid)
			end
			item:transform(item.itemid == 1945 and 1946 or 1945)
			else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'precisa de mais um')
		end	
	end
	
	
	if item.actionid == 25903 then
		
		local createPos, novoitem
		if fromPosition == Position(32480, 32198, 8) then
			createPos = Position(32480, 32200, 8)
			else
			createPos = Position(32474, 32200, 8)
		end
		
		local potion2 = Tile(createPos):getItemById(7618)
		local food2 = Tile(createPos):getItemById(2666)
		local pinga2 = Tile(createPos):getItemById(15465)
		
		if potion2 then
			potion2:remove()
			if player:getStorageValue(Storage.Galinhas.Food) > 0 then
				novoitem = Game.createItem(2666, 1, createPos)--criar comida
				novoitem:setActionId(25904)
				createPos:sendMagicEffect(CONST_ME_TUTORIALARROW)
			end
			elseif food2 then
			food2:remove()
			if player:getStorageValue(Storage.Galinhas.Pinga) > 0  then
				novoitem = Game.createItem(15465, 1, createPos)--criar pinga
				novoitem:setActionId(25904)
				createPos:sendMagicEffect(CONST_ME_TUTORIALARROW)
			end
			elseif pinga2 then
			pinga2:remove()
			if player:getStorageValue(Storage.Galinhas.Potion) > 0 then
				novoitem = Game.createItem(7618, 1, createPos)--criar potion
				novoitem:setActionId(25904)
				createPos:sendMagicEffect(CONST_ME_TUTORIALARROW)
			end
			else 
			if player:getStorageValue(Storage.Galinhas.Food) > 0 then
				novoitem = Game.createItem(7618, 1, createPos)
				novoitem:setActionId(25904)
				createPos:sendMagicEffect(CONST_ME_TUTORIALARROW)
				else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Ainda nao tem itens')
			end
		end
		item:transform(item.itemid == 1945 and 1946 or 1945)
	end
	
	
	if item.actionid == 25904 then
		local summs = player:getSummons()
		print(item.itemid)
		-- itens meat 2666, pinga 15465, potion 7618
		local consId = item.itemid
		local efeito, chickenMessage
		
		
		
		if #summs > 0 then
			for i = 1, #summs do
				if consId == 7618 then --se for potion
					efeito, chickenMessage = CONST_ME_PURPLEENERGY, "Ahhh!"
					doCreatureAddHealth(summs[i], 1)
					elseif consId == 2666 then -- se for food
					efeito, chickenMessage = CONST_ME_HEARTS, "Chomp! nhoc! nhac! nhec!"
					doCreatureAddHealth(summs[i], 2)
					else -- esperado pinga
					efeito, chickenMessage =  CONST_ME_BUBBLES, "Gulp! glup! Pfft! pfft! phfpt! Meow!"
					doCreatureAddHealth(summs[i], 3)
				end
				
				
				
				summs[i]:getPosition():sendMagicEffect(efeito)
				doCreatureSay(summs[i], chickenMessage, TALKTYPE_ORANGE_1)
				
			end
		end
		
		
		item:remove()
		return false
		
	end
	
	
	
	
	return true
end