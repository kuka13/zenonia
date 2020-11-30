local mult1 = 2 -- aqui e o tempo em segundos que vai demorar pra tartaruga posXdar
local repet = 10 -- aqui quantos sqm ela vai andar pra frente
local posX, posY, posZ = 32256, 32227, 7 -- aqui onde a cabeca da tartaruga vai aparecer

local function functionBack(oldMatriz, positions)
	Game.createItem(oldMatriz, 1, positions)
end

local function functionWork(a)
	local p1, p2, p3 = Position(posX, posY, posZ), Position(posX+1, posY, posZ), Position(posX+2, posY, posZ)
	local p4, p5, p6 = Position(posX, posY+1, posZ), Position(posX+1, posY+1, posZ), Position(posX+2, posY+1, posZ)
	local p7, p8, p9 = Position(posX, posY+2, posZ), Position(posX+1, posY+2, posZ), Position(posX+2, posY+2, posZ)

	local t1, t2, t3 = 4613, 5757, 4611 -- aqui os itens que compoem a tartaruga
	local t4, t5, t6 = 5758, 5756, 5759 -- aqui os itens que compoem a tartaruga
	local t7, t8, t9 = 5761, 5755, 5760 -- aqui os itens que compoem a tartaruga

	local tortoiseMatriz = {t1, t2, t3, t4, t5, t6, t7, t8, t9}
	local oldMatriz = {}
	local positions = {p1, p2, p3, p4, p5, p6, p7, p8, p9}

	for i = 1, #positions do
		local position = positions[i]
		position.y = position.y - a

		--local tile = Tile(position)
		--local item = tile:getGround()
		local itemId = Tile(position):getGround():getId()

		table.insert(oldMatriz, itemId)
		Game.createItem(tortoiseMatriz[i], 1, positions[i])
		addEvent(functionBack, 1 * (1000*mult1)-25, oldMatriz[i], positions[i])
	end
end

function onSay(player, words, param)

	for timer = 1, repet do
		local a = timer
		addEvent(functionWork, timer * 1000*mult1, a)
	end

	return true
end