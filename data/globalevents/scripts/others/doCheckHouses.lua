local function doCheckHouses()
	
    local dias = 7
    local tempo = os.time() - (dias * 24 * 60 * 60) 
    local registros = db.storeQuery("SELECT `houses`.`owner`, `houses`.`id` FROM `houses`,`players` WHERE `houses`.`owner` != 0 AND `houses`.`owner` = `players`.`id` AND `players`.`lastlogin` <= " .. tempo .. ";")
    
    if registros ~= false then
		
        local count = 0
        
        print('house leave code')
        
        repeat
            count = count + 1
            
            local owner = result.getNumber(registros, "owner")
            local houseId = result.getNumber(registros, "id")
            local house = House(houseId)
            local player = Player(owner)
           
		   if house and (owner > 0) then
                print(house:getName())
                
				
				local tiles = house:getTiles()
				local inbox = player:getInbox()
				-- primeiro tentar mover para o inbox
				for i = 1, #tiles do
					local pos = tiles[i]:getPosition()
					local items = Tile(pos):getItems()
					for b = 1, #items do
						if ItemType(items[b]:getId()):isMovable() then
							pos:sendMagicEffect(CONST_ME_POFF)
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
			end
            
		until not result.next(registros)
        
        print('house leave house count:' .. count)
        
        result.free(registros)
	end
end

function onStartup()
    addEvent(doCheckHouses, 60 * 1000)
    
    return true
end