function onSay(player, words, param)
	local config = {
		[1385] = { -- STAIRS DAWNPORT
			Position(32075, 31900, 6)},
		[9486] = { -- GATE ROOK
			Position(32096, 32215, 7),
			Position(32097, 32215, 7),
			Position(32098, 32215, 7)} 
	}
	
	
	local escada = config[1385]
	local gates = config[9486]
	
	if param == 'fechado' then
		for i = 1, #escada do
			local position = escada[i]
			--Game.createItem(1385, 1, position)
			doRemoveItem(getTileItemById(position, 1385).uid, 1)
		end
		
		for i = 1, #gates do
			local position = gates[i]
			Game.createItem(9486, 1, position)
		end
	end
	
	if param == 'aberto' then
		for i = 1, #escada do
			local position = escada[i]
			--doRemoveItem(getTileItemById(position, 1385).uid, 1)
			Game.createItem(1385, 1, position)
		end
		
		for i = 1, #gates do
			local position = gates[i]
			doRemoveItem(getTileItemById(position, 9486).uid, 1)
		end
	end
	
	
	
	return false
end
