local function clean(items)
	for i = 1, #items do
		local clean = Item(items[i])
	if clean then
	clean:remove()
	end
	end
end

local function removetp(teleport)
	local tp = Item(teleport)
	if tp then
	tp:remove()
	end
end

local function createtp(aux)
	local numero = aux
	local tp = doCreateTeleport(1387, {x=32368, y=32182, z=6}, {x=32369, y=32183, z=6})
	doSetItemActionId(tp, 53161)
	addEvent(removetp, 5*60*1000, tp)
end

local function minigame(round)
	print(round)
	local items = {}

	fromx,fromy,fromz=32363,32181,6
	tox, toy, toz = 32375,32184,6
	
	for a = fromx, tox do
	for b = fromy, toy do
	for c = fromz, toz do
	
	
	if math.random(1, 50) > 40 then
	local item = Game.createItem(2160, 1, Position(a, b, c))
	doSetItemActionId(item, 53162)
	table.insert(items, item.uid)
	end
	
	end
	end
	end
	
	
	
	addEvent(clean, 1*60*1000, items)
end


local function broadcast(minutes)
	if minutes >= 1 then
	broadcastMessage("O evento comecara em "..minutes.." minutos.", MESSAGE_EVENT_ADVANCE)
	else
	broadcastMessage("O evento comecou", MESSAGE_EVENT_ADVANCE)
	local a, b, c, d = 1, 2, 3, 4
	addEvent(minigame, 5*1000, a) --primeiro round imediatamente >> delay de 5 segundos
	addEvent(minigame, 2*60*1000, b) --segundo round 2 minutos depois
	addEvent(minigame, 4*60*1000, c) --terceiro round 4 minutos depois
	addEvent(minigame, 6*60*1000, d) --segundo round 6 minutos depois
	end
end







--function onThink(interval, lastExecution)
function onTime(interval)
    print('clickupevent')
	local zero, um, tres, cinco = 0, 1, 3, 5
	--criar tp para entrar, adicionar rotina para deletar em 5 minutos
	addEvent(createtp, 1000, um)
	--iniciar que o evento vai começar em 5 minutos
	addEvent(broadcast, 1000, cinco)
	--iniciar que o evento vai começar em 3 minutos
	addEvent(broadcast, 2*60*1000, tres)
	--iniciar que o evento vai começar em 1 minutos
	addEvent(broadcast, 4*60*1000, um)
	--anunciar que o evento começou, iniciar o round1
	addEvent(broadcast, 5*60*1000, zero)
	
	--apos soltar o 5 addevent (	
	--dentro do evento *criar itens para clicar, e armazenar os mesmos, para deletar, caso nao sejam pegos )
	--remover itens que nao foram usados, e repetir o loop acima	
    return true
end 
