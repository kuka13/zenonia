function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	doLoot(player, item, fromPosition, target, toPosition, isHotkey)	
end

function doLoot(player, item, fromPosition, target, toPosition, isHotkey)
	local executar, notopen = 1, 0
	
	while executar >= 1 do 
		
		local issue = {}
		local bodycontainer, slot, msg = {}, 0, ''
		
		
		if Tile(toPosition) == nil then
			
			--return false
			toPosition = item:getPosition()
		end
		local monstercheck = Tile(toPosition):getTopVisibleThing()
		local corpsecheck = getTileItemById(toPosition, monstercheck:getId()).uid
		
		local corpse = item.uid
		local slots = getContainerSize(corpse)
		
		if corpsecheck ~= corpse then
			print('foi pelo browsefield')
			notopen = 1
			
		end
		
		if not corpse or not slots then
			return false
		end
		
		if true then
			for times = 1, slots do
				local addlater, addlaterid, addlaterqtd = 0, 0, 0
				bodycontainer[times] = getContainerItem(corpse, slot)
				if player:getAutoLootItem(bodycontainer[times].itemid) then
					
					local slotcorpse = bodycontainer[times].uid
					local itemcorpse = Item(slotcorpse)
					--local weight = ItemType(itemcorpse):getWeight(itemcorpse.type)
					local weight = itemcorpse:getWeight()
					local slotgg
					local localizou
					local resultId = db.storeQuery('SELECT `cont_id` FROM `player_autoloot_persist` WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. itemcorpse:getId() .. '')
					if resultId then
						local bp_id = result.getNumber(resultId, 'cont_id')
					end
					
					localizou = 1
					local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
					----print(result.getNumber(resultId, 'cont_id'))
					local items = getAllItemsById(player, result.getNumber(resultId, 'cont_id'))
					local auxnew = 1
					if #items > 0 then
						for _, item in pairs(items) do
							if localizou == 1 then
								----print(ItemType(item.itemid):getName(), auxnew)
								auxnew = auxnew + 1
								
								local bp2 = item.uid
								
								
								local bp3 = itemcorpse:getId()
								
								local testecontainers = {}
								if isContainer(item.uid) then
									
									table.insert(testecontainers, item.uid)
									
									for i = 1, #testecontainers do
										for k = (getContainerSize(testecontainers[i]) - 1), 0, -1 do
											
											local tmp = getContainerItem(testecontainers[i], k)
											local auxtop = Item(tmp.uid)
											local auxtop2 = auxtop:getId()
											local auxtop3 = auxtop.type
											
											
											if ItemType(auxtop2):isStackable() and auxtop3 < 100 then
												
												--tmp.uid
												if auxtop2 == bp3 then
													print(auxtop, auxtop2, auxtop3, 'menor que 100', bp3)
													--auxtop:moveTo(itemcorpse)
													--local slotcorpset = getContainerItem(corpse, 0)
													local idt, qtdt = auxtop2, auxtop3
													
													doAddContainerItem(corpse, auxtop2, auxtop3)
													auxtop:remove()
													executar = executar + 1
												end
											end
											
										end
									end
									
								end
								
								if getContainerCap(bp2) and getContainerSize(bp2) then
									local freeSlotsInBp2 = math.max(0, getContainerCap(bp2) - getContainerSize(bp2))
									local resultId = db.storeQuery('SELECT `cont_id` FROM `player_autoloot_persist` WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. bp3 .. '')
									if resultId then
										local bp_id = result.getNumber(resultId, 'cont_id')
									end
									if freeSlotsInBp2 and freeSlotsInBp2 > 0 or (bp3 == 2148 or bp3 == 2160 or bp3 == 2152) and result.getNumber(resultId, 'cont_id') == 26377 then
										slotgg = item.uid
										localizou = 2
									end
									
								end			
							end
						end	
					end
					
					local destination = Item(slotgg)
					if destination and destination:getTopParent() == player then
						
						if player:getFreeCapacity() >= weight then
							itemcorpse:moveTo(destination)
							if bodycontainer[times].type > 1 then
								msg = ''..msg.. ', '..bodycontainer[times].type..' '..tostring(ItemType(bodycontainer[times].itemid):getPluralName())..''
								else
								msg = ''..msg.. ', '..tostring(ItemType(bodycontainer[times].itemid):getName())..''
							end
							else
							--player:sendTextMessage(MESSAGE_INFO_DESCR,'LOW CAP1.')
						end
						else
						if not table.contains(issue, bodycontainer[times].itemid) then
							table.insert(issue, bodycontainer[times].itemid)
						end
						
						if player:getFreeCapacity() >= weight then
							
							itemcorpse:moveToSlot(player, 0)
							else
							--player:sendTextMessage(MESSAGE_INFO_DESCR,'LOW CAP2.')
						end
					end	
					else
					slot = slot + 1
				end		
			end
			executar = executar - 1
		end
		
		if msg ~= '' then
			player:sendTextMessage(MESSAGE_INFO_DESCR,'Looted:'.. string.gsub(" "..msg, "%W%l", string.lower):sub(3) ..' opening corpse')
		end
		
		if issue then
			if #issue >= 1 then
				for i = 1, #issue do
					--player:sendTextMessage(MESSAGE_INFO_DESCR,'All main '..string.gsub(" "..string.lower(ItemType(issue[i]):getName()), "%W%l", string.upper):sub(2)..' full, buy a new or move itens to sub backpacks OR LOW CAP.')
				end
			end
		end
		
		
	end
	if notopen == 1 then
		return true
	end
end

function getAllItemsById(cid, id)
	local containers = {}
	local items = {}
	
	for i = 1, 11 do
		local sitem = getPlayerSlotItem(cid, i)
		if sitem.uid > 0 then
			if isContainer(sitem.uid) then
				table.insert(containers, sitem.uid)
				--table.insert(items, sitem)
				elseif not(id) or id == sitem.itemid then
				table.insert(items, sitem)
			end
		end
	end
	
	while #containers > 0 do
		for k = (getContainerSize(containers[1]) - 1), 0, -1 do
			local tmp = getContainerItem(containers[1], k)
			if isContainer(tmp.uid) then
				table.insert(containers, tmp.uid)
				if id == tmp.itemid then
					table.insert(items, tmp)
				end
				elseif not(id) or id == tmp.itemid then
				table.insert(items, tmp)
			end
		end
		table.remove(containers, 1)
	end
	
	return items
end

