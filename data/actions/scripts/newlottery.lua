local decayItems = {
	[1945] = 1946, [1946] = 1945
}
local slots = {
	Position(32364, 32231, 5), Position(32365, 32231, 5), Position(32366, 32231, 5), Position(32367, 32231, 5),	Position(32368, 32231, 5),
	Position(32369, 32231, 5), Position(32370, 32231, 5), Position(32371, 32231, 5), Position(32372, 32231, 5),	Position(32373, 32231, 5),
	Position(32374, 32231, 5)
}

local itemtable = {
	[1] = {id = 2148, chance = 1},
	[2] = {id = 2398, chance = 10},
	
	[3] = {id = 2386, chance = 15},
	[4] = {id = 2643, chance = 20},
	[5] = {id = 2461, chance = 25},
	[6] = {id = 2510, chance = 30},
	[7] = {id = 2649, chance = 40},
	[8] = {id = 2643, chance = 45},
	
	[9] = {id = 2647, chance = 50},
	[10] = {id = 9078, chance = 60},
	[11] = {id = 2490, chance = 70},
	[12] = {id = 2457, chance = 75},
	
	[13] = {id = 2152, chance = 80},
	[14] = {id = 2160, chance = 90},
	[15] = {id = 2159, chance = 95}
}

local function ender(cid, position)
	local player = Player(cid)
	local posicaofim = Position(32369, 32231, 5)
	local item = Tile(posicaofim):getTopDownItem()
	if item then
		local itemId = item:getId()
		posicaofim:sendMagicEffect(CONST_ME_TUTORIALARROW)
		if player then
		player:addItem(itemId, 1)
		end
	end
	local alavanca = Tile(position):getTopDownItem()
	if alavanca then
		alavanca:setActionId(18563)
	end
	if itemId == 2159 then --checar se é o ID do item LENDARIO
		broadcastMessage("O player "..player:getName().." ganhou "..item:getName().."", MESSAGE_EVENT_ADVANCE)
		
		for _, pid in ipairs(getPlayersOnline()) do
			if pid ~= cid then
				pid:say("O player "..player:getName().." ganhou "..item:getName().."", TALKTYPE_MONSTER_SAY)
			end
		end
	end
end

local function delay(position, aux)
	local item = Tile(position):getTopDownItem()
	if item then
		local slot = aux + 1
		item:moveTo(slots[slot])
	end	
end

local function exec(cid)
	--calcular uma chance e atribuir um item
	local rand = math.random(1, 100)
	local aux, memo = 0, 0
	if rand >= 1 then
		for i = 1, #itemtable do
			local randitemid = itemtable[i].id
			local randitemchance = itemtable[i].chance
			if rand >= randitemchance then
				aux = aux + 1
				memo = randitemchance
			end
			
		end
	end
	
	local item = Tile(slots[#slots]):getTopDownItem()
	if item then
		item:remove()
	end
		
	local var1 = #slots
	for i = 1, #slots do
		var1 = var1 -1
		
		if slots[var1] then
		local item = Tile(slots[var1]):getTopDownItem()
	if item then
		item:moveTo(slots[var1+1])
	end	
	end
	end
	Game.createItem(itemtable[aux].id, 1, slots[1])
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	if not player then
		return false
	end
	if not player:removeItem(5091, 1) then -- esse item é o bilhete pra participar
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Ainda nao tem o bilhete.")
		return false
	end
	
	item:transform(decayItems[item.itemid])
	item:decay()	
	--muda actionid do item para nao permitir executar duas instancias
	item:setActionId(0)
	
	local speed = 60 -- aqui é a velocidade... quanto menor, mais rapido vai executar...
	local slowdown = 10 -- a cada execucao, esse valor de desaceleraçao vai aumentando. deixando a roleta mais lenta.. 
	local segundos = 20 -- quanto maior o tempo aqui, mais tempo vai ficar roletando os itens...
	
	
	local loopsize = segundos*2
	
	local totaltimer = 0
	for i = 1, loopsize do
		addEvent(exec, ((1*i*speed)), cid.uid)
		speed = speed + slowdown
		totaltimer =  1 * i * speed
	end
	addEvent(ender, (totaltimer)+1000, cid.uid, fromPosition)
	
	return true
end
