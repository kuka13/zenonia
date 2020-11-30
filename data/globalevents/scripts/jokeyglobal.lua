function onThink(interval)
	if #apostadores >= 1 then
		for i = 1, #apostadores do
			player = Player(apostadores[i])
			pBetPos[getPlayerGUID(player)] = player:getPosition()
			player:setGhostMode(true)
			player:teleportTo(Position(1064, 900, 5))
		end
	end
    
	local positions = {Position(1066, 904, 5), Position(1066, 902, 5), Position(1066, 900, 5), Position(1066, 898, 5), Position(1066, 896, 5)}
	local horses = {Game.createNpc("jokey1", positions[1]), Game.createNpc("jokey1", positions[2]), Game.createNpc("jokey1", positions[3]), Game.createNpc("jokey1", positions[4]), Game.createNpc("jokey1", positions[5])}
	vencedores = {}
	
	local spectators = Game.getSpectators(Position(1074, 901, 5), false, true, 7, 7, 5, 5)
	for i = 1, #spectators do
		for p = 1, 5 do
			spectators[i]:say(''..HorseNames[p]..'', TALKTYPE_MONSTER_SAY, false, spectators[i], positions[p])
		end
	end
	
	for i = 1, 5 do
		horses[i]:setDirection(DIRECTION_EAST)
		doChangeSpeed(horses[i], getCreatureBaseSpeed(horses[i]))
		local color = {114, 0, 113, 107, 79}
		horses[i]:setOutfit({lookBody = color[i], lookAddons = 2, lookType = 128, lookHead = 97, lookMount = 392, lookLegs = 95, lookFeet = 115})
	end
	
	local speed, delay = 450, 1
	for run = 1, 14 do
		local xa, xb = -15, 15
		for h = 1, 5 do
			speed = speed + math.random(xa, xb)
			addEvent(jokeyRun, speed*delay, horses[h].uid, positions[h], run, h, vencedores)
		end
		delay = delay + 1
	end
	addEvent(jokey, (450*delay)+1000, horses, vencedores)   
	return true
end

function jokey(horses, vencedores)
	for i = 1, 5 do
		horses[i]:remove()
	end
	
	if #vencedores >= 1 then
		local vencedor = vencedores[1]
		jokeywin[vencedor] = jokeywin[vencedor] + 1
		if #apostadores >= 1 then
		if math.random(1, 2) == 2 then
		broadcastMessage("Corrida de cavalos: O cavalo "..vencedor.." "..HorseNames[vencedor].." venceu!", MESSAGE_EVENT_ADVANCE)
		end
		end
		if #vencedores >= 1 and #apostadores >= 1 then
			for i = 1, #apostadores do
				p = Player(apostadores[i])   
				local premios = {pBet1[getPlayerGUID(p)], pBet2[getPlayerGUID(p)], pBet3[getPlayerGUID(p)], pBet4[getPlayerGUID(p)], pBet5[getPlayerGUID(p)]}
				local valor = premios[vencedor]
				valor = valor * 2
				p:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Sua aposta no vencedor '..HorseNames[vencedor]..' foi: '..premios[vencedor]..' e seu premio: '..valor..'')
				doPlayerAddMoney(p, valor)
				p:teleportTo(pBetPos[getPlayerGUID(p)])
				p:setGhostMode(false)
			end	
			pBet1, pBet2, pBet3, pBet4,	pBet5, apostadores = {}, {}, {}, {}, {}, {}
		end
	end
end	

function jokeyRun(horses, pos, run, seq, vencedores, ganhou)	
	local nextpos = pos
	nextpos.x = nextpos.x + 1
	local cavalo = Creature(horses)
	if cavalo then
		cleanTilejokey(nextpos)
		local path = cavalo:getPathTo(nextpos, 0, 0, true, true)
		doMoveCreature(cavalo, path[1])
		if run == 7 and seq == 1 then
			if #apostadores >= 1 then
				for u = 1, #apostadores do
					player = Player(apostadores[u])
					player:setGhostMode(true)
					player:teleportTo(Position(1081, 900, 5))
				end
			end
		end
		if run == 14 then
			table.insert(vencedores, seq)
			if #vencedores == 1 then
				cavalo:getPosition():sendMagicEffect(CONST_ME_TUTORIALARROW)	
			end
		end
	end
end	

function cleanTilejokey(position)
	local creature = Creature(getTopCreature(position).uid)
	if creature then
		creature:teleportTo(Position(1081, 900, 5))
	end
	local items = position:getTile():getItems()
	if items then
		for i = 1, #items do
			local item = items[i]
			item:remove()
		end
	end
end