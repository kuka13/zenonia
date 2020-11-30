function onStartup()
	megaplayer = {}
	megabilhete1 = {}
	megabilhete2 = {}
	megabilhete3 = {}
	megavalor = {}
    megatemp1 = {}
	megatemp2 = {}
	megatemp3 = {}
	print('[SISTEMA DE LOTERIA] OPERANTE')
	return true
end


function onThink(interval)
if #megabilhete1 < 1 then
	--print('Sem apostas')
	return true
end
--[[
local sorteio1 = math.random(0, 9)
local sorteio2 = math.random(0, 9)
local sorteio3 = math.random(0, 9)]]

local sorteio1 = 1
local sorteio2 = 2
local sorteio3 = 3


print('sorteou: '..sorteio1..''..sorteio2..''..sorteio3..'')
for i = 1, #megabilhete1 do
	local bil1 = megabilhete1[i]
	local bil2 = megabilhete2[i]
	local bil3 = megabilhete3[i]
	local acertos = 0
	if bil1 == sorteio1 then
	acertos = acertos + 1
	end
	if bil2 == sorteio2 then
	acertos = acertos + 1
	end
	if bil3 == sorteio3 then
	acertos = acertos + 1
	end
	
	
	print(acertos)
	if acertos > 0 then
	local player = Player(megaplayer[i])
	local valoraposta = megavalor[i]
	local coinplayer = player:getCoinsBalance()
	
	if acertos == 1 then
	player:addItem(25172, 10)
	
	elseif acertos == 2 then
	player:addItem(25377, 10)
	coinplayer = coinplayer+valoraposta
	player:setCoinsBalance(coinplayer)
	elseif acertos == 3 then
	coinplayer = coinplayer+(valoraposta*100)
	player:setCoinsBalance(coinplayer)
	
	broadcastMessage("Parabens ao player "..player:getName().." por ter acertado todos os numeros da loteria.", MESSAGE_EVENT_ADVANCE)
	
	end
	
	end
	
end

--LIMPAR TUDO

	megaplayer = {}
	megabilhete1 = {}
	megabilhete2 = {}
	megabilhete3 = {}
	megavalor = {}
    megatemp1 = {}
	megatemp2 = {}
	megatemp3 = {}


return true
end 