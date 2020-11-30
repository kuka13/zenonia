local config = {
autolootear = true
}

function onModalWindow(player, modalWindowId, buttonId, choiceId)
	player:unregisterEvent('autoloot')	
	local limiteAutoloot = 100
	local autolootlist, sum = {}, 1
	local soma = {}
	local number = 1
	if buttonId == 102 and modalWindowId == 1000 then
		local playerlist = player:getAutoLootList()
		if playerlist then
			table.sort(playerlist, function(a, b) return ItemType(a):getName() < ItemType(b):getName() end)
			for _, item in ipairs(playerlist) do
				table.insert(autolootlist, "".. item .."")
			end
			local itemType = ItemType(tonumber(autolootlist[choiceId]))
			player:sendTextMessage(MESSAGE_INFO_DESCR,'Removed '.. string.gsub(" "..ItemType(tonumber(autolootlist[choiceId])):getName(), "%W%l", string.upper):sub(2, 21)..' from autoloot list!')
			db.query('DELETE FROM `player_autoloot_persist` WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. itemType:getId() .. '')
			player:removeAutoLootItem(itemType:getId())
			call(player, 'remove')
		end
		elseif buttonId == 102 and modalWindowId == 1001 or buttonId == 103 or buttonId == 107 then
		local lootBlockList = lootBlockListm[getPlayerGUID(player)]
		if lootBlockList == nil or lootBlockList == -1 then
			return false
		end
		for _, loot in pairs(lootBlockList) do
			table.insert(autolootlist, lootBlockList[sum].itemId) 
			sum = sum + 1
		end
		local itemType = ItemType(tonumber(autolootlist[choiceId]))
		if buttonId == 102 then	
			player:sendTextMessage(MESSAGE_INFO_DESCR,'Removed '.. string.gsub(" "..ItemType(itemType:getId()):getName(), "%W%l", string.upper):sub(2, 21)..' from autoloot list!')
			db.query('DELETE FROM `player_autoloot_persist` WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. itemType:getId() .. '')
			player:removeAutoLootItem(itemType:getId())
			elseif buttonId == 103 then	
			if player:getAutoLootList() then
				local playerlist = player:getAutoLootList()
			end
			if player:getAutoLootList() then
				
				for _, item in ipairs(player:getAutoLootList()) do
					table.insert(soma, number)
					number = number + 1
				end
			end
			if soma then
				if #soma >= limiteAutoloot then
					player:sendCancelMessage("Reached the limit <"..#soma..">for itens, first remove using !autoloot or !add <monster>, selecting option remove.")
					return false
					else
					player:sendTextMessage(MESSAGE_INFO_DESCR,'Add '.. string.gsub(" "..ItemType(lootBlockList[choiceId].itemId):getName(), "%W%l", string.upper):sub(2, 21) ..' to autoloot list!')
					player:addAutoLootItem(itemType:getId())
				end
			end
		end
		call(player, 'add')
		elseif buttonId == 105 then
		local lootBlockList = lootBlockListm[getPlayerGUID(player)]
		if lootBlockList == nil or lootBlockList == -1 then
			return false
		end
		for _, loot in pairs(lootBlockList) do
			table.insert(autolootlist, lootBlockList[sum].itemId)
			sum = sum + 1
		end
		local itemType = ItemType(tonumber(autolootlist[choiceId]))
		lastitem[getPlayerGUID(player)] = lootBlockList[choiceId].itemId
		call(player, 'backpack', modalWindowId, lastitem[getPlayerGUID(player)])
		elseif buttonId == 106 then
		local lootBlockList = player:getAutoLootList()
		table.sort(lootBlockList, function(a, b) return ItemType(a):getName() < ItemType(b):getName() end)
		if lootBlockList == nil or lootBlockList == -1 then
			return false
		end
		for _, loot in pairs(lootBlockList) do
			table.insert(autolootlist, lootBlockList[sum])
			sum = sum + 1
		end
		local itemType = ItemType(tonumber(autolootlist[choiceId]))
		lastitem[getPlayerGUID(player)] = lootBlockList[choiceId]
		call(player, 'backpack', modalWindowId, lastitem[getPlayerGUID(player)])
		elseif buttonId == 108 then
		print('108')
		local loots = lootBlockListm[getPlayerGUID(player)]
		for i = 1, #loots do
		local itemType = ItemType(tonumber(loots[i].itemId))
		db.query('DELETE FROM `player_autoloot_persist` WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. itemType:getId() .. '')
		player:removeAutoLootItem(itemType:getId())
		end
		--call(player, 'backpack', modalWindowId, lastitem[getPlayerGUID(player)])
		call(player, 'add')
		elseif buttonId == 199 then
		call(player, 'remove')
		elseif buttonId == 100 then
		if modalWindowId == 1005 then
			local container, bp, sequencer = {}, {}, 1
			local bp2 = {}
			local names2 = {}
			
			local containersx = getAllContainers(player)
			if containersx then
			
			-- add aqui na bp
			
			--print('beta', choiceId)
			if choiceId > 0 and choiceId < 50 then
			player:addAutoLootItem(lastitem[getPlayerGUID(player)])
			end
			--maverick
			--[[comecei2]]
			local backcheck = getPlayerSlotItem(player, CONST_SLOT_BACKPACK)
			if backcheck then
			--if lastitem[getPlayerGUID(player)] == 2160 or lastitem[getPlayerGUID(player)] == 2148 or lastitem[getPlayerGUID(player)] == 2152 then
			
			table.insert(names2, '1'..ItemType(backcheck.itemid):getName()..'')
			itemtester = Item(backcheck.uid)
				bp[sequencer] = itemtester
				bp2[sequencer] = 1
			--window:addChoice(0, ""..string.gsub(" "..string.lower(ItemType(pouchcheck.itemid):getName()), "%W%l", string.upper):sub(2).."")
			sequencer = sequencer + 1
			--end
			end
			--[[acabei2]]
			
			
			local pouchcheck = player:getItemById(26377, true)
			if pouchcheck then
			if lastitem[getPlayerGUID(player)] == 2160 or lastitem[getPlayerGUID(player)] == 2148 or lastitem[getPlayerGUID(player)] == 2152 then
			
			table.insert(names2, ItemType(26377):getName())
			itemtester = Item(pouchcheck.uid)
				bp[sequencer] = itemtester
				bp2[sequencer] = itemtester.itemid
			--window:addChoice(0, ""..string.gsub(" "..string.lower(ItemType(pouchcheck.itemid):getName()), "%W%l", string.upper):sub(2).."")
			sequencer = sequencer + 1
			end
			end
			
			
			for _, item in pairs(containersx) do
			
			if not table.contains(names2, ItemType(item.itemid):getName()) then
				table.insert(names2, ItemType(item.itemid):getName())
				itemtester = Item(item.uid)
				bp[sequencer] = itemtester
				bp2[sequencer] = item.itemid
			end
			sequencer = sequencer + 1
			end
			
			end
			--print('bp1')
			if sequencer >= 1 then
			
				if player:getAutoLootItem(lastitem[getPlayerGUID(player)]) then
					local resultId = db.storeQuery('SELECT `cont_id` FROM `player_autoloot_persist` WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. lastitem[getPlayerGUID(player)] .. '')
					if resultId then
						local bp_id = result.getNumber(resultId, 'cont_id')
						else
						if bp2[choiceId] then
						db.query("INSERT INTO `player_autoloot_persist` (`player_guid`, `cont_id`, `item_id`) VALUES (".. getPlayerGUID(player) ..", ".. bp2[choiceId] ..", ".. lastitem[getPlayerGUID(player)] ..") ON DUPLICATE KEY UPDATE `cont_id` = ".. bp2[choiceId])
						end
					end
					if result.getNumber(resultId, 'cont_id') and result.getNumber(resultId, 'cont_id') ~= bp2[choiceId] then
						db.query('UPDATE `player_autoloot_persist` SET `cont_id` = '..bp2[choiceId]..' WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. lastitem[getPlayerGUID(player)] .. '')
					end
				end
			end
			call(player, 'add')	
		end
		if modalWindowId == 1006 then
			local names = {}
			local container, bp, sequencer = {}, {}, 1
			local bp2 = {}
			
			
			
			
			--[[comecei2]]
			local backcheck = getPlayerSlotItem(player, CONST_SLOT_BACKPACK)
			if backcheck then
			--if lastitem[getPlayerGUID(player)] == 2160 or lastitem[getPlayerGUID(player)] == 2148 or lastitem[getPlayerGUID(player)] == 2152 then
			
			table.insert(names, '1'..ItemType(backcheck.itemid):getName()..'')
			itemtester = Item(backcheck.uid)
				bp[sequencer] = itemtester
				bp2[sequencer] = 1
			--window:addChoice(0, ""..string.gsub(" "..string.lower(ItemType(pouchcheck.itemid):getName()), "%W%l", string.upper):sub(2).."")
			sequencer = sequencer + 1
			--end
			end
			--[[acabei2]]
			
			
			
			
			
			local containersx = getAllContainers(player)
			if containersx then
			
			local pouchcheck = player:getItemById(26377, true)
			if pouchcheck then
			if lastitem[getPlayerGUID(player)] == 2160 or lastitem[getPlayerGUID(player)] == 2148 or lastitem[getPlayerGUID(player)] == 2152 then
			----print('bingo!')
			table.insert(names, ItemType(26377):getName())
			itemtester = Item(pouchcheck.uid)
				bp[sequencer] = itemtester
				bp2[sequencer] = itemtester.itemid
			--window:addChoice(0, ""..string.gsub(" "..string.lower(ItemType(pouchcheck.itemid):getName()), "%W%l", string.upper):sub(2).."")
			sequencer = sequencer + 1
			end
			end
			
			
			for _, item in pairs(containersx) do
			
			if not table.contains(names, ItemType(item.itemid):getName()) then
				table.insert(names, ItemType(item.itemid):getName())
				itemtester = Item(item.uid)
				bp[sequencer] = itemtester
				bp2[sequencer] = item.itemid
				--sequencer = sequencer + 1
			end
			sequencer = sequencer + 1
			end
			
			end
			--print('bp2')
			if sequencer >= 1 then
				local resultId = db.storeQuery('SELECT `cont_id` FROM `player_autoloot_persist` WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. lastitem[getPlayerGUID(player)] .. '')
				if resultId then
					local bp_id = result.getNumber(resultId, 'cont_id')
					else
					db.query("INSERT INTO `player_autoloot_persist` (`player_guid`, `cont_id`, `item_id`) VALUES (".. getPlayerGUID(player) ..", ".. bp2[choiceId] ..", ".. lastitem[getPlayerGUID(player)] ..") ON DUPLICATE KEY UPDATE `cont_id` = ".. bp2[choiceId])
				end
				if result.getNumber(resultId, 'cont_id') and result.getNumber(resultId, 'cont_id') ~= bp2[choiceId] then
					db.query('UPDATE `player_autoloot_persist` SET `cont_id` = '..bp2[choiceId]..' WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. lastitem[getPlayerGUID(player)] .. '')
				end
			end
			call(player, 'remove')
			
		end
	end
end

function call(player, param, param2, tobpid)
	player:registerEvent('autoloot')	
	local title = "Autoloot Helper!"
	if param == 'add' then
		local lootBlockList = lootBlockListm[getPlayerGUID(player)]
		local message = "Loots of "..string.gsub(" "..string.lower(lootBlockListn[getPlayerGUID(player)]), "%W%l", string.upper):sub(2)..":"
		local window = ModalWindow(1001, title, message)
		local check, sum = {}, 1
		for _, loot in pairs(lootBlockList) do
			local status = ''
			if player:getAutoLootItem(lootBlockList[sum].itemId) then
				status = '*'
			end
			if not table.contains(check, ItemType(lootBlockList[sum].itemId):getName()) then
				table.insert(check, ItemType(lootBlockList[sum].itemId):getName())
				local resultId = db.storeQuery('SELECT `cont_id` FROM `player_autoloot_persist` WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. lootBlockList[sum].itemId .. '')
				if resultId then
					local bp_id = result.getNumber(resultId, 'cont_id')
				end
				local backvinculo
				if result.getNumber(resultId, 'cont_id') and result.getNumber(resultId, 'cont_id') > 0 then
					if result.getNumber(resultId, 'cont_id') and result.getNumber(resultId, 'cont_id') == 1 then
					backvinculo = '| MAIN'
					else
					backvinculo = '| '..ItemType(result.getNumber(resultId, 'cont_id')):getName()..''
					end
					else
					backvinculo = ''
				end
				--window:addChoice(sum, "".. string.gsub(" "..status..""..ItemType(lootBlockList[sum].itemId):getName(), "%W%l", string.upper):sub(2, 21) .." | "..lootBlockList[sum].maxCount.." | "..(lootBlockList[sum].chance/1000).."% "..string.gsub(" "..string.lower(backvinculo), "%W%l", string.upper):sub(2).."")
				window:addChoice(sum, "".. string.gsub(" "..status..""..ItemType(lootBlockList[sum].itemId):getName(), "%W%l", string.upper):sub(2, 21) .." | "..lootBlockList[sum].maxCount.." "..string.gsub(" "..string.lower(backvinculo), "%W%l", string.upper):sub(2).."")
				
			end
			sum = sum + 1
		end
		if autolootBP == 1 then
			window:addButton(105, "Backpack")
		end
		callwindow(window, player, 1)
		elseif param == 'remove' then
		local message = "You are currently looting the following items:"
		local window = ModalWindow(1000, title, message)
		local check, sum = player:getAutoLootList(), 1
		if check then
			table.sort(check, function(a, b) return ItemType(a):getName() < ItemType(b):getName() end)
			for _, item in ipairs(check) do
				local resultId = db.storeQuery('SELECT `cont_id` FROM `player_autoloot_persist` WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. ItemType(check[sum]):getId() .. '')
				if resultId then
					local bp_id = result.getNumber(resultId, 'cont_id')
				end
				local backvinculo
				if result.getNumber(resultId, 'cont_id') and result.getNumber(resultId, 'cont_id') > 0 then
					if result.getNumber(resultId, 'cont_id') and result.getNumber(resultId, 'cont_id') == 1 then
					backvinculo = '| MAIN'
					else
					backvinculo = '| '..ItemType(result.getNumber(resultId, 'cont_id')):getName()..''
					end
					else
					backvinculo = ''
				end
				window:addChoice(sum, "".. string.gsub(" "..(ItemType(item)):getName(), "%W%l", string.upper):sub(2, 21) .." "..string.gsub(" "..string.lower(backvinculo), "%W%l", string.upper):sub(2).."")
				sum = sum + 1
			end
			else
			player:sendCancelMessage("The list is empty.")
			return false
		end
		if autolootBP == 1 then
			window:addButton(106, "Backpack")
		end
		callwindow(window, player, 2)
		elseif param == 'backpack' then
		local lootBlockList = lootBlockListm[getPlayerGUID(player)]
		
		local modalcode
		if param2 and param2 == 1001 then
			modalcode = 1005
			else
			modalcode = 1006
		end
		local message = "Choose a Backpack:"
		local window = ModalWindow(modalcode, title, message)
		local sum = 1
		local container, names = {}, {}
		
			
			local containersx = getAllContainers(player)
			if containersx then
			--[[ Comecei aqui]]
			--getContainerSize(getPlayerSlotItem(player, CONST_SLOT_BACKPACK).uid)
			local backcheck = getPlayerSlotItem(player, CONST_SLOT_BACKPACK)
			
			if backcheck and getContainerSize(getPlayerSlotItem(player, CONST_SLOT_BACKPACK).uid) then
			
			--if tobpid == 2148 or tobpid == 2152 or tobpid == 2160 then
			table.insert(names, '1'..ItemType(backcheck.itemid):getName()..'')
			window:addChoice(1, "Main - "..string.gsub(" "..string.lower(ItemType(backcheck.itemid):getName()), "%W%l", string.upper):sub(2).."")
			sum = sum + 1
			--end
			end	
			
			--[[ acabei aqui]]
			local pouchcheck = player:getItemById(26377, true)
			if pouchcheck then
			
			if tobpid == 2148 or tobpid == 2152 or tobpid == 2160 then
			table.insert(names, ItemType(26377):getName())
			window:addChoice(2, ""..string.gsub(" "..string.lower(ItemType(26377):getName()), "%W%l", string.upper):sub(2).."")
			sum = sum + 1
			end
			end
			
			for _, item in pairs(containersx) do
			
			if not table.contains(names, ItemType(item.itemid):getName()) then --and not item.itemid == 23782 then
				if item.itemid ~= 23782 then
				table.insert(names, ItemType(item.itemid):getName())
				
				if item.itemid == 26377 then
					if tobpid == 2148 or tobpid == 2152 or tobpid == 2160 then 
						window:addChoice(sum, ""..string.gsub(" "..string.lower(ItemType(item.itemid):getName()), "%W%l", string.upper):sub(2).."")
					end
				else 
					
						window:addChoice(sum, ""..string.gsub(" "..string.lower(ItemType(item.itemid):getName()), "%W%l", string.upper):sub(2).."")
					
				end
				end
				
			end
			sum = sum + 1
			end
			
			else
			player:sendCancelMessage("Not find main backpack.")
			return false
		end
		if sum == 80 then
			player:sendCancelMessage("Not find sub-backpacks.")
			return false
		end
		callwindow(window, player, 3)
	end
end

function callwindow(window, player, param)
	if param == 3 then
		window:addButton(100, "Confirm")
		else
		window:addButton(100, "Confirm")
		window:addButton(102, "Clear")
		if param == 1 then
			window:addButton(108, "Clear All")
		end
	end
	window:sendToPlayer(player)		
end

function scanContainer(cid, position)
    local player = Player(cid)
    if not player then
        return
	end
	
    local corpse = Tile(position):getTopDownItem()
    if not corpse or not corpse:isContainer() then
        print('algo com o corpse')
		return
	end
	
	local logic, contlogic, bplogica = 1, {}, {}
	if getContainerSize(getPlayerSlotItem(player, CONST_SLOT_BACKPACK).uid) then
		for i = 0, getContainerSize(getPlayerSlotItem(player, CONST_SLOT_BACKPACK).uid) do
			contlogic[logic] = getContainerItem(getPlayerSlotItem(player, CONST_SLOT_BACKPACK).uid, i)
			
			if isContainer(contlogic[logic].uid) then
				bplogica[logic] = contlogic[logic]
				logic = logic + 1
			end
			
		end
	end
	
    if corpse:getType():isCorpse() and corpse:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == cid then
        
		for i = corpse:getSize() - 1, 0, -1 do
            local containerItem = corpse:getItem(i)
            if containerItem then
				
				if player:getAutoLootItem(containerItem:getId()) then	
					local itemcorpse = containerItem
					local slotgg
					local localizou
					local resultId = db.storeQuery('SELECT `cont_id` FROM `player_autoloot_persist` WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. itemcorpse:getId() .. '')
					if resultId then
						local bp_id = result.getNumber(resultId, 'cont_id')
					end
					for i = 1, #bplogica do
						local tempitem = Item(bplogica[i].uid)
						if tempitem:getId() == result.getNumber(resultId, 'cont_id') and localizou ~= 1 then
							local bp = bplogica[i].uid
							local freeSlotsInBp = math.max(0, getContainerCap(bp) - getContainerSize(bp))
							if freeSlotsInBp and freeSlotsInBp > 0 then
								slotgg = bplogica[i].uid
								localizou = 1
							end
						end
					end
					local weight = itemcorpse:getWeight()
					
			localizou = 1
			local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
			local items = getAllItemsById2(player, result.getNumber(resultId, 'cont_id'))
		
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
			
			for k = (getContainerSize(testecontainers[1]) - 1), 0, -1 do
			
			local tmp = getContainerItem(testecontainers[1], k)
			local auxtop = Item(tmp.uid)
			local auxtop2 = auxtop:getId()
			local auxtop3 = auxtop.type
			
			
			if ItemType(auxtop2):isStackable() and auxtop3 < 100 then
			
			--tmp.uid
			if auxtop2 == bp3 then
			--print(auxtop, auxtop2, auxtop3, 'menor que 100', bp3)
			auxtop:moveTo(corpse)
			end
			end
			
			end
			
			end

			
			
			print('bool...', getContainerCap(bp2), getContainerSize(bp2))
			if getContainerCap(bp2) and getContainerSize(bp2) then
			
			
			
			local freeSlotsInBp2 = math.max(0, getContainerCap(bp2) - getContainerSize(bp2))
		
			print(freeSlotsInBp2)

			
			local resultId = db.storeQuery('SELECT `cont_id` FROM `player_autoloot_persist` WHERE `player_guid` = ' .. getPlayerGUID(player) .. ' AND `item_id` = ' .. bp3 .. '')
			if resultId then
					local bp_id = result.getNumber(resultId, 'cont_id')
					--print(bp3, bp_id)
				end
			if freeSlotsInBp2 > 0 or ((bp3 == 2148 or bp3 == 2160 or bp3 == 2152) and result.getNumber(resultId, 'cont_id') == 26377) then
				if Item(item.uid) then
				slotgg = item.uid
				localizou = 2
				print('bingo', player:getFreeCapacity(), weight)
				if player:getFreeCapacity() >= weight then
					itemcorpse:moveTo(Item(item.uid))
				end
				end
			end
			
			
			end
			end
			end	
			end
			
			local destination = Item(slotgg)
					
					
					if destination and destination:getTopParent() == player then
						
						if player:getFreeCapacity() >= weight then
							--itemcorpse:moveTo(destination)
						end
						else
						if player:getFreeCapacity() >= weight then
							containerItem:moveTo(player)
						end
					end
				end
				
			end
		end
	end
end

function onKill(player, target)
    if not target:isMonster() then
        return true
	end
	
    if config.autolootear == true then
	--addEvent(scanContainer, 100, player:getId(), target:getPosition()) --(essa linha faz com que o loot seja catado ao matar o monstro, sem abrir o corpo)
	addEvent(doautoLoot, 100, player:getId(), target:getPosition()) --(essa linha faz com que o loot seja catado ao matar o monstro, sem abrir o corpo)
	end
	return true
end

function doautoLoot(cid, toPosition)
	local player = Player(cid)
    if not player then
        return
	end
	local executar, notopen = 1, 0
	
	while executar >= 1 do 
		
		local issue = {}
		local bodycontainer, slot, msg = {}, 0, ''
		
		
		if Tile(toPosition) == nil then
			
			--return false
			--toPosition = item:getPosition()
		end
		local monstercheck = Tile(toPosition):getTopVisibleThing()
		local corpsecheck = getTileItemById(toPosition, monstercheck:getId()).uid
		
		local corpse = corpsecheck
		local slots = getContainerSize(corpse)
		
		if corpsecheck ~= corpse then
			print('foi pelo browsefield')
			notopen = 1
			
		end
		
		if not corpse or not slots then
		--print('erro2')
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
													--print(auxtop, auxtop2, auxtop3, 'menor que 100', bp3)
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

function getAllItemsById2(cid, id)
    local containers = {}
    local items = {}
   
    for i = 1, 11 do
        local sitem = getPlayerSlotItem(cid, i)
        if sitem.uid > 0 then
            if isContainer(sitem.uid) then
                table.insert(containers, sitem.uid)
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

function getAllContainers(cid)
    local containers = {}
    local items = {}
   
    for i = 1, 11 do
        local sitem = getPlayerSlotItem(cid, i)
        if sitem.uid > 0 then
            if isContainer(sitem.uid) then
                table.insert(containers, sitem.uid)
				--table.insert(items, tmp)
            end
        end
    end

    while #containers > 0 do
        for k = (getContainerSize(containers[1]) - 1), 0, -1 do
            local tmp = getContainerItem(containers[1], k)
            if isContainer(tmp.uid) then
                table.insert(containers, tmp.uid)
			
				table.insert(items, tmp)
			
            
            end
        end
        table.remove(containers, 1)
    end
	
    return items
end