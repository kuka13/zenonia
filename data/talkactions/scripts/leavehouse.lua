function onSay(player, words, param)
	local position = player:getPosition()
	local tile = Tile(position)
	local house = tile and tile:getHouse()
	if house == nil then
		player:sendCancelMessage("You are not inside a house.")
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	if house:getOwnerGuid() ~= player:getGuid() then
		player:sendCancelMessage("You are not the owner of this house.")
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	local tiles = house:getTiles()
	local inbox = player:getInbox()
	
	-- primeiro tentar mover para o inbox
	for i = 1, #tiles do
		local pos = tiles[i]:getPosition()
		local items = Tile(pos):getItems()
		for b = 1, #items do
			if ItemType(items[b]:getId()):isMovable() then
				pos:sendMagicEffect(CONST_ME_POFF)
				
				if items[b]:getType():getDecayId() >= 0 or ItemType(items[b]:getId()):isCorpse() then
				items[b]:remove()
				end
				
				items[b]:moveTo(inbox)
				
				
			end
		end
	end
	-- se tiver algum item teimoso deletar
	for i = 1, #tiles do
		local pos = tiles[i]:getPosition()
		local items = Tile(pos):getItems()
		for b = 1, #items do
			if ItemType(items[b]:getId()):isMovable() then
				pos:sendMagicEffect(CONST_ME_POFF)
				items[b]:remove()
			end
		end
	end
	
	
	
	house:setOwnerGuid(0)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have successfully left your house.")
	position:sendMagicEffect(CONST_ME_POFF)
	return false
end
