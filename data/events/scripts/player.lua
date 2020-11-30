-- Internal Use
-- Internal Use
STONE_SKIN_AMULET = 2197
GOLD_POUCH = 26377
ITEM_STORE_INBOX = 26052

DISABLE_CONTAINER_WEIGHT = 0 -- 0 = ENABLE CONTAINER WEIGHT CHECK | 1 = DISABLE CONTAINER WEIGHT CHECK
CONTAINER_WEIGHT = 1000000 -- 1000000 = 10k = 10000.00 oz | this function is only for containers, item below the weight determined here can be moved inside the container, for others items look game.cpp at the src

-- Items sold on the store that should not be moved off the store container
local storeItemID = {32384,32385,32386,32387,32388,32389,32124,32125,32126,32127,32128,32129,32109,33299,26378,29020}

-- No move/trade items with actionID 8000
BLOCK_ITEM_WITH_ACTION = 8000

-- Capacity imbuement store
local STORAGE_CAPACITY_IMBUEMENT = 42154

-- Players cannot throw items on teleports if set to true
local blockTeleportTrashing = true

local titles = {
	{storageID = 14960, title = " Scout"},
	{storageID = 14961, title = " Sentinel"},
	{storageID = 14962, title = " Steward"},
	{storageID = 14963, title = " Warden"},
	{storageID = 14964, title = " Squire"},
	{storageID = 14965, title = " Warrior"},
	{storageID = 14966, title = " Keeper"},
	{storageID = 14967, title = " Guardian"},
	{storageID = 14968, title = " Sage"},
	{storageID = 14969, title = " Tutor"},
	{storageID = 14970, title = " Senior Tutor"},
	{storageID = 14971, title = " King"},
}

local function getTitle(uid)
	local player = Player(uid)
	if not player then return false end
	
	for i = #titles, 1, -1 do
		if player:getStorageValue(titles[i].storageID) == 1 then
			return titles[i].title
		end
	end
	
	return false
end

function Player:onBrowseField(position)
	return true
end

local function getHours(seconds)
	return math.floor((seconds/60)/60)
end

local function getMinutes(seconds)
	return math.floor(seconds/60)
end

local function getSeconds(seconds)
	return seconds%60
end

local function getTime(seconds)
	local hours, minutes = getHours(seconds), getMinutes(seconds)
	if (minutes > 59) then
		minutes = minutes-hours*60
	end
	
	if (minutes < 10) then
		minutes = "0" ..minutes
	end
	
	return hours..":"..minutes.. "h"
end

local function getTimeinWords(secs)
	local hours, minutes, seconds = getHours(secs), getMinutes(secs), getSeconds(secs)
	if (minutes > 59) then
		minutes = minutes-hours*60
	end
	
	local timeStr = ''
	
	if hours > 0 then
		timeStr = timeStr .. ' hours '
	end
	
	timeStr = timeStr .. minutes .. ' minutes and '.. seconds .. 'seconds.'
	
	return timeStr
end

function Player:onLook(thing, position, distance)
	local description = "You see "
	if thing:isItem() then
		if thing.actionid == 5640 then
			description = description .. "a honeyflower patch."
			elseif thing.actionid == 5641 then
			description = description .. "a banana palm."
			elseif thing.itemid >= ITEM_HEALTH_CASK_START and thing.itemid <= ITEM_HEALTH_CASK_END
			or thing.itemid >= ITEM_MANA_CASK_START and thing.itemid <= ITEM_MANA_CASK_END
			or thing.itemid >= ITEM_SPIRIT_CASK_START and thing.itemid <= ITEM_SPIRIT_CASK_END
			or thing.itemid >= ITEM_KEG_START and thing.itemid <= ITEM_KEG_END then
			description = description .. thing:getDescription(distance)
			local charges = thing:getCharges()
			if charges then
				description = string.format("%s\nIt has %d refillings left.", description, charges)
			end
			else
			description = description .. thing:getDescription(distance)
		end
		
		local itemType = thing:getType()
		if (itemType and itemType:getImbuingSlots() > 0) then
			local imbuingSlots = "Imbuements: ("
			for slot = 0, itemType:getImbuingSlots() - 1 do
				if slot > 0 then
					imbuingSlots = string.format("%s, ", imbuingSlots)
				end
				local duration = thing:getImbuementDuration(slot)
				if duration > 0 then
					local imbue = thing:getImbuement(slot)
					imbuingSlots = string.format("%s%s %s %s", imbuingSlots, imbue:getBase().name, imbue:getName(), getTime(duration))
					else
					imbuingSlots = string.format("%sEmpty Slot", imbuingSlots)
				end
			end
			imbuingSlots = string.format("%s).", imbuingSlots)
			description = string.gsub(description, "It weighs", imbuingSlots.. "\nIt weighs")
		end
		else
		description = description .. thing:getDescription(distance)
		if thing:isMonster() then
			local master = thing:getMaster()
			if master and table.contains({'thundergiant','grovebeast','emberwing','skullfrost'}, thing:getName():lower()) then
				description = description..' (Master: ' .. master:getName() .. '). It will disappear in ' .. getTimeinWords(master:getStorageValue(Storage.PetSummon) - os.time())
			end
		end
	end
	
	if self:getGroup():getAccess() then
		if thing:isItem() then
			description = string.format("%s\nItem ID: %d", description, thing:getId())
			
			local actionId = thing:getActionId()
			if actionId ~= 0 then
				description = string.format("%s, Action ID: %d", description, actionId)
			end
			
			local uniqueId = thing:getAttribute(ITEM_ATTRIBUTE_UNIQUEID)
			if uniqueId > 0 and uniqueId < 65536 then
				description = string.format("%s, Unique ID: %d", description, uniqueId)
			end
			
			local itemType = thing:getType()
			
			local transformEquipId = itemType:getTransformEquipId()
			local transformDeEquipId = itemType:getTransformDeEquipId()
			if transformEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onEquip)", description, transformEquipId)
				elseif transformDeEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onDeEquip)", description, transformDeEquipId)
			end
			
			local decayId = itemType:getDecayId()
			if decayId ~= -1 then
				description = string.format("%s\nDecays to: %d", description, decayId)
			end
			elseif thing:isCreature() then
			local str = "%s\nHealth: %d / %d"
			if thing:isPlayer() and thing:getMaxMana() > 0 then
				str = string.format("%s, Mana: %d / %d", str, thing:getMana(), thing:getMaxMana())
			end
			description = string.format(str, description, thing:getHealth(), thing:getMaxHealth()) .. "."
		end
		
		local position = thing:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)
		
		if thing:isCreature() then
			if thing:isPlayer() then
				description = string.format("%s\nIP: %s.", description, Game.convertIpToString(thing:getIp()))
			end
		end
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInBattleList(creature, distance)
	local description = "You see " .. creature:getDescription(distance)
	if creature:isMonster() then
		local master = creature:getMaster()
		if master and table.contains({'thundergiant','grovebeast','emberwing','skullfrost'}, creature:getName():lower()) then
			description = description..' (Master: ' .. master:getName() .. '). It will disappear in ' .. getTimeinWords(master:getStorageValue(Storage.PetSummon) - os.time())
		end
	end
	if self:getGroup():getAccess() then
		local str = "%s\nHealth: %d / %d"
		if creature:isPlayer() and creature:getMaxMana() > 0 then
			str = string.format("%s, Mana: %d / %d", str, creature:getMana(), creature:getMaxMana())
		end
		description = string.format(str, description, creature:getHealth(), creature:getMaxHealth()) .. "."
		
		local position = creature:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)
		
		if creature:isPlayer() then
			description = string.format("%s\nIP: %s", description, Game.convertIpToString(creature:getIp()))
		end
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInTrade(partner, item, distance)
	self:sendTextMessage(MESSAGE_INFO_DESCR, "You see " .. item:getDescription(distance))
end

function Player:onLookInShop(itemType, count)
	return true
end

local config = {
	maxItemsPerSeconds = 1,
	exhaustTime = 2000,
}

if not pushDelay then
	pushDelay = { }
end

local function antiPush(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if toPosition.x == CONTAINER_POSITION then
		return true
	end
	
	local tile = Tile(toPosition)
	if not tile then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end
	
	local cid = self:getId()
	if not pushDelay[cid] then
		pushDelay[cid] = {items = 0, time = 0}
	end
	
	pushDelay[cid].items = pushDelay[cid].items + 1
	
	local currentTime = os.mtime()
	if pushDelay[cid].time == 0 then
		pushDelay[cid].time = currentTime
		elseif pushDelay[cid].time == currentTime then
		pushDelay[cid].items = pushDelay[cid].items + 1
		elseif currentTime > pushDelay[cid].time then
		pushDelay[cid].time = 0
		pushDelay[cid].items = 0
	end
	
	if pushDelay[cid].items > config.maxItemsPerSeconds then
		pushDelay[cid].time = currentTime + config.exhaustTime
	end
	
	if pushDelay[cid].time > currentTime then
		self:sendCancelMessage("You can't move that item so fast.")
		return false
	end
	
	return true
end



function Player:onMoveItem(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	
	-- FIX MILAGROSO DA IGREJA DO MARSON E DO JHON
	if self:getName() and self:isPlayer() then
		--item, count, fromPosition, toPosition, fromCylinder, toCylinder
		local debugA, debugB, debugC, debugD, debugE, debugF, texto = '', '1', '', '', '', '', ''
		local debugG, debugH, debugI = '', '', ''
		if item then
			debugA = item:getId()
			if ItemType(item.itemid):isCorpse() then
				debugA = 'corpo'
			end
		end
		local containerTo = self:getContainerById(toPosition.y-64)
		if (containerTo) then
			if containerTo:getId() then
				debugG = containerTo:getId()
				if ItemType(containerTo:getId()):isCorpse() then
					debugG = 'dentro de corpo'
					if ItemType(item:getId()):isContainer() or item:getType():getDecayId() >= 0 then
						self:sendCancelMessage("Nao pode colocar container dentro de corpses")
						self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "ret1")
						return false
					end
				end
			end
		end
		if containerTo then
			if containerTo:getId() then
				if (ItemType(containerTo:getId()):isCorpse()) then
					if ItemType(item.itemid):isCorpse() or item:getType():getDecayId() >= 0 then
						self:sendCancelMessage("Sorry.")
						self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "ret2")
						return false
					end
				end
			end
		end
		local containerIdFrom = fromPosition.y - 64
		local containerFrom = self:getContainerById(containerIdFrom)
		if (containerFrom) then
			if (containerFrom:getId()) then
				debugI = containerFrom:getId()
			end
		end
		if fromPosition.x and fromPosition.y then
			debugC = ''..fromPosition.x..','..fromPosition.y..', '..fromPosition.z..''
		end
		
		if toPosition.x and toPosition.y then
			debugH = ''..toPosition.x..','..toPosition.y..', '..toPosition.z..''
		end
		local bugpos = fromCylinder:getPosition()
		debugE = ''..bugpos.x..','..bugpos.y..''
		
		local containerIdFrom = fromPosition.y - 64
		local containerFrom = self:getContainerById(containerIdFrom)
		if (containerFrom) then
			if (ItemType(containerFrom:getId()):isCorpse() and toPosition.y >= 1 and toPosition.y <= 11 and toPosition.y ~= 3) then
				self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "ret3")
				return false
			end
		end
		
		if toPosition then
			debugD = ''..toPosition.x..','..toPosition.y..','..toPosition.z..''
		end
		
		local corpo = 0
		if toPosition.y >= 64 and toPosition.y < 80 and ItemType(item.itemid):isCorpse() then
			local texto = 'item: '..debugA..' count: '..debugB..' fromposition: '..debugC..' toposition: '..debugD..' fromcylinder: '..debugE..' tocylinder: '..debugF..' containerTo:'..debugG..' POS'..debugH..'containerfrom:'..debugI..''
			if self:getName() == 'Dev Marson' or self:getName() == 'Cassiano' then
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ferramenta de debugar movimentos."..texto.."")
			end
			if toPosition.z >= 0 and toPosition.z < 255 then
				if containerTo then
					if containerTo:getId() then
						if ItemType(item.itemid):isCorpse() then
							self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "ret4")
							return false
							else
							corpo = 2
						end
					end
				end
				if corpo == 0 then
					self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "ret5")
					return false
				end
			end
		end	
		
		if toPosition.x then --== CONTAINER_POSITION then
			local containerId = toPosition.y - 64
			local container = self:getContainerById(containerId)
			if container then
				local newid = container:getId()
				if ItemType(newid):isCorpse() and ItemType(item.itemid):isCorpse() then
					self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "ret6")
					return false
				end
			end
		end
		--checar aqui o conteudo de parcel
		if item:getId() == 2595 then
			if Tile(toPosition) then
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "movendo parcel")
				if Tile(toPosition):getItemById(2593) or Tile(toPosition):getItemById(3981) or Tile(toPosition):getItemById(26055) or Tile(toPosition):getItemById(26056) or Tile(toPosition):getItemById(26057) or Tile(toPosition):getItemById(26058) then
					--varrer o conteudo
					local containers = {}
					local items = {}
					table.insert(containers, item.uid)
					while #containers > 0 do
						for k = (getContainerSize(containers[1]) - 1), 0, -1 do
							local tmp = getContainerItem(containers[1], k)
							if isContainer(tmp.uid) then
								table.insert(containers, tmp.uid)	
							end	
							table.insert(items, tmp.uid)	
						end
						table.remove(containers, 1)
					end
					for i = 1, #items do
						local nitem = Item(items[i])
						if nitem then
							-- remover se for corpo, ou se tem decay, ou se for um container com decay
							if ItemType(nitem:getId()):isCorpse() or nitem:getType():getDecayId() >= 0 then
								nitem:remove()
							end
						end
					end
				end
			end
		end
		--end of check de parcels
		--check nao colocar corpses e itens com decay no depot
		--containers: 2594 > depotchest
		-- lockers: 25453 ate 25469
		
		if ItemType(item:getId()):isCorpse() or item:getType():getDecayId() >= 0 then
			if (containerTo) then
			if containerTo:getId() == 2594 or (containerTo:getId() >= 25453 and containerTo:getId() <= 25469) then
			return false
			end
			if containerTo:getId() then
			local topParent = containerTo:getTopParent()
			if topParent:isItem() then
			if topParent:getId() == 2594 or (topParent:getId() >= 25453 and topParent:getId() <= 25469) then
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nao e possivel mover itens decay por dentro de containers no depot.")
			return false
			end
			end
			end
			
			
			end
		end
		
		--check nao colocar corpses e itens com decay no depot
		
		
		local texto = 'item: '..debugA..' count: '..debugB..' fromposition: '..debugC..' toposition: '..debugD..' fromcylinder: '..debugE..' tocylinder: '..debugF..' containerTo:'..debugG..' POS'..debugH..' containerfrom:'..debugI..''
		if self:getName() == 'Dev Marson' or self:getName() == 'Cassiano' then
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ferramenta de debugar movimentos."..texto.."")
		end
	end
	-- FIX MILAGROSO DA IGREJA DO MARSON E DO JHON
	
	-- No move items with actionID = 8000
	--[[local itemboost = 0
	if item.itemid == 1998 and itemboost == 1 then
		
		
		local condition = createConditionObject(CONDITION_ATTRIBUTES)
		setConditionParam(condition, CONDITION_PARAM_TICKS, -1)
		setConditionParam(condition, CONDITION_PARAM_STAT_MAXHITPOINTS, 500)
		setConditionParam(condition, CONDITION_PARAM_STAT_MAXMANAPOINTS, 500)
		setConditionParam(condition, CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, 50)
		setConditionParam(condition, CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, 50)
		setConditionParam(condition, CONDITION_PARAM_STAT_CAPACITYPERCENT, 150)
		
		
		if toPosition.x == CONTAINER_POSITION then
			--self:sendCancelMessage('botou na bp')
			doAddCondition(self, condition)
			doSendMagicEffect(getCreaturePos(self), 10)
			doPlayerAddMana(self, getPlayerMaxMana(cid))
			self:addHealth(self:getMaxHealth())
			elseif self:getItemCount(1998) == 1 and toPosition.x ~= CONTAINER_POSITION then
			--self:sendCancelMessage('tirou da bp')
			doRemoveCondition(self, CONDITION_ATTRIBUTES)
		end
	end
	]]
	if ItemType(item.itemid):isCorpse() then
		--print('moveu corpo')
		--return false
	end
	
	
	if item.itemid == 2595 then
		if Tile(toPosition) then
			if Tile(toPosition):getItemById(2593) or Tile(toPosition):getItemById(3981) or Tile(toPosition):getItemById(26055) or Tile(toPosition):getItemById(26056) or Tile(toPosition):getItemById(26057) or Tile(toPosition):getItemById(26058) then
				--self:sendCancelMessage('Disabled.')
				print('MAILSYSTEM '.. self:getName() ..'')
				--return false
			end
		end
	end
	
	if item:getActionId() == BLOCK_ITEM_WITH_ACTION then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end
	-- Store Items
	if isInArray(storeItemID,item.itemid) then
		self:sendCancelMessage('You cannot move this item outside this container.')
		return false
	end
	-- No move if item count > 20 items
	local tile = Tile(toPosition)
	if tile and tile:getItemCount() > 20 then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end
	
	-- No move parcel very heavy
	if DISABLE_CONTAINER_WEIGHT == 0 and ItemType(item:getId()):isContainer() and item:getWeight() > CONTAINER_WEIGHT then
		self:sendCancelMessage("Your cannot move this item too heavy.")
		return false
	end
	
	-- Loot Analyser apenas 11.x+
	if self:getClient().os == CLIENTOS_NEW_WINDOWS then
		local t = Tile(fromCylinder:getPosition())
		local corpse = t:getTopDownItem()
		if corpse then
			local itemType = corpse:getType()
			if itemType:isCorpse() and toPosition.x == CONTAINER_POSITION then
				self:sendLootStats(item)
			end
		end
	end
	
	-- Cults of Tibia begin
	local frompos = Position(33023, 31904, 14) -- Checagem
	local topos = Position(33052, 31932, 15) -- Checagem
	if self:getPosition():isInRange(frompos, topos) and item:getId() == 26397 then
		local tileBoss = Tile(toPosition)
		if tileBoss and tileBoss:getTopCreature() and tileBoss:getTopCreature():isMonster() then
			if tileBoss:getTopCreature():getName():lower() == 'the remorseless corruptor' then
				tileBoss:getTopCreature():addHealth(-17000)
				item:remove(1)
				if tileBoss:getTopCreature():getHealth() <= 300 then
					tileBoss:getTopCreature():remove()
					local monster  = Game.createMonster('the corruptor of souls', toPosition)
					monster:registerEvent('checkPiso')
					if Game.getStorageValue('healthSoul') > 0 then
						monster:addHealth(-(monster:getHealth() - Game.getStorageValue('healthSoul')))
					end
					Game.setStorageValue('checkPiso', os.time()+30)
				end
				elseif tileBoss:getTopCreature():getName():lower() == 'the corruptor of souls' then
				Game.setStorageValue('checkPiso', os.time()+30)
				item:remove(1)
			end
		end
	end
	-- Cults of Tibia end
	
	--- LIONS ROCK START
	if self:getStorageValue(lionrock.storages.playerCanDoTasks) - os.time() < 0 then
		local p, i = lionrock.positions, lionrock.items
		local checkPr = false
		if item:getId() == 2147 and toPosition.x == 33069 and toPosition.y == 32298  and toPosition.z == 9 then
			-- Ruby
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You place the ruby on the small socket. A red flame begins to burn.")
			checkPr = true
			if lionrock.taskactive.ruby ~= true then
				lionrock.taskactive.ruby = true
			end
			
			local item = Tile(Position(33069, 32298, 9))
			if (item:getItemCountById(1488) > 0) then
				local flameruby = Game.createItem(1488, 1, Position(33069, 32298, 9))
			end
		end
		
		if item:getId() == 2146 and toPosition.x == 33069 and toPosition.y == 32302  and toPosition.z == 9 then
			-- Sapphire
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You place the sapphire on the small socket. A blue flame begins to burn.")
			checkPr = true
			if lionrock.taskactive.sapphire ~= true then
				lionrock.taskactive.sapphire = true
			end
			
			local item = Tile(Position(33069, 32302, 9))
			if (item:getItemCountById(8058) > 0) then
				local flamesapphire = Game.createItem(8058, 1, Position(33069, 32302, 9))
			end
		end
		
		if item:getId() == 2150 and toPosition.x == 33077 and toPosition.y == 32302  and toPosition.z == 9 then
			-- Amethyst
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You place the amethyst on the small socket. A violet flame begins to burn.")
			checkPr = true
			if lionrock.taskactive.amethyst ~= true then
				lionrock.taskactive.amethyst = true
			end
			
			local item = Tile(Position(33077, 32302, 9))
			if (item:getItemCountById(1500) > 0) then
				local flameamethyst = Game.createItem(1500, 1, Position(33077, 32302, 9))
			end
		end
		
		if item:getId() == 9970 and toPosition.x == 33077 and toPosition.y == 32298  and toPosition.z == 9 then
			-- Topaz
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You place the topaz on the small socket. A yellow flame begins to burn.")
			checkPr = true
			if lionrock.taskactive.topaz ~= true then
				lionrock.taskactive.topaz = true
			end
			
			local item = Tile(Position(33077, 32298, 9))
			if (item:getItemCountById(7473) > 0) then
				local flametopaz = Game.createItem(7473, 1, Position(33077, 32298, 9))
			end
		end
		
		if checkPr == true then
			-- Adding the Fountain which gives present
			if lionrock.taskactive.ruby == true and lionrock.taskactive.sapphire == true and lionrock.taskactive.amethyst == true and lionrock.taskactive.topaz == true then
				local fountain = Game.createItem(6390, 1, Position(33073, 32300, 9))
				fountain:setActionId(41357)
				local stone = Tile(Position(33073, 32300, 9)):getItemById(3608)
				if stone ~= nil then
					stone:remove()
				end
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Something happens at the centre of the room ...");
			end
			
			-- Removing Item
			item:remove(1)
		end
	end
	---- LIONS ROCK END
	
	-- SSA exhaust
	local exhaust = { }
	if toPosition.x == CONTAINER_POSITION and toPosition.y == CONST_SLOT_NECKLACE and item:getId() == STONE_SKIN_AMULET then
		local pid = self:getId()
		if exhaust[pid] then
			self:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
			return false
			else
			exhaust[pid] = true
			addEvent(function() exhaust[pid] = false end, 2000, pid)
			return true
		end
	end
	
	-- Store Inbox
	local containerIdFrom = fromPosition.y - 64
	local containerFrom = self:getContainerById(containerIdFrom)
	if (containerFrom) then
		if (containerFrom:getId() == ITEM_STORE_INBOX and toPosition.y >= 1 and toPosition.y <= 11 and toPosition.y ~= 3) then
			self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
			return false
		end
	end
	
	local containerTo = self:getContainerById(toPosition.y-64)
	if (containerTo) then
		if ItemType(containerTo:getId()):isCorpse() and ItemType(item.itemid):isCorpse() then
			self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			print(''..self:getName()..' moveu corpo dentro de corpo')
			--item, count, fromPosition, toPosition, fromCylinder, toCylinder
			--id do rato morto 3073
			return false
		end
		if containerTo:getId() == 2595 and ItemType(item.itemid):isCorpse() then
			self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			--print('moveu corpo dentro da parcel')
			--return false
		end
		if ItemType(containerTo:getId()):isCorpse() and ItemType(item.itemid):isCorpse() then
			self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			print('moveu corpo dentro de corpo')
			
			return false
		end
		if (toPosition.x == CONTAINER_POSITION or toPosition.y == CONST_SLOT_BACKPACK)and ItemType(item.itemid):isCorpse() then
			local tileBoss = Tile(toPosition)
			if tileBoss and tileBoss:getTopDownItem() then
				local item = tileBoss:getTopDownItem()
				if item and ItemType(item:getId()):isCorpse() then
					self:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
				else
				--if (containerTo) then
				--if ItemType(containerTo:getId()):isCorpse() then
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "1.")
				--return false
				end
				else
				
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "2.")
				--return false
				end
				--end
				--end
				end
				if (containerFrom) and (containerTo) then
				if ItemType(containerTo:getId()):isCorpse() and ItemType(containerFrom:getId()):isCorpse() then
				self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
				return false
				end
				end
				local tileBoss = Tile(toPosition)
				if tileBoss and tileBoss:getTopCreature() and tileBoss:getTopCreature():isMonster() then
				if (containerTo) then
				if ItemType(containerTo:getId()):isContainer() or ItemType(item:getId()):isContainer() then
				self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
				return false
				end 
				if ItemType(containerFrom:getId()):isCorpse() then
				self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
				return false
				end
				end
				end
				
				--if item:getTopParent() ~= self or item:getParent() == self then //TODO//
				if (containerTo:getId() == ITEM_STORE_INBOX) then --or (containerTo:getParent():getId() == ITEM_STORE_INBOX and containerTo:getId() ~= GOLD_POUCH) then
				self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
				return false
				end
				-- Gold Pouch
				if (containerTo:getId() == GOLD_POUCH) then
				if (not (item:getId() == ITEM_CRYSTAL_COIN or item:getId() == ITEM_PLATINUM_COIN or item:getId() == ITEM_GOLD_COIN)) then
				--self:sendCancelMessage("You can move only money to this container.")
				--return false
				end
				end
				end
				
				-- No move gold pouch
				if item:getId() == GOLD_POUCH then
				--self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				--return false
				end
				
				-- Check two-handed weapons
				if toPosition.x ~= CONTAINER_POSITION then
				return true
				end
				
				
				
				
				if item:getTopParent() == self and bit.band(toPosition.y, 0x40) == 0 then
				local itemType, moveItem = ItemType(item:getId())
				if bit.band(itemType:getSlotPosition(), SLOTP_TWO_HAND) ~= 0 and toPosition.y == CONST_SLOT_LEFT then
				moveItem = self:getSlotItem(CONST_SLOT_RIGHT)
				elseif itemType:getWeaponType() == WEAPON_SHIELD and toPosition.y == CONST_SLOT_RIGHT then
				moveItem = self:getSlotItem(CONST_SLOT_LEFT)
				if moveItem and bit.band(ItemType(moveItem:getId()):getSlotPosition(), SLOTP_TWO_HAND) == 0 then
				return true
				end
				end
				
				if moveItem then
				local parent = item:getParent()
				if parent:getSize() == parent:getCapacity() then
				self:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM))
				return false
				else
				return moveItem:moveTo(parent)
				end
				end
				end
				
				-- Reward System
				if toPosition.x == CONTAINER_POSITION then
				local containerId = toPosition.y - 64
				local container = self:getContainerById(containerId)
				if not container then
				return true
				end
				
				-- Do not let the player insert items into either the Reward Container or the Reward Chest
				local itemId = container:getId()
				if itemId == ITEM_REWARD_CONTAINER or itemId == ITEM_REWARD_CHEST then
				self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				return false
				end
				
				-- The player also shouldn't be able to insert items into the boss corpse
				local tile = Tile(container:getPosition())
				for _, item in ipairs(tile:getItems() or { }) do
				if item:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2^31 - 1 and item:getName() == container:getName() then
				self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				return false
				end
				end
				end
				
				-- Do not let the player move the boss corpse.
				if item:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2^31 - 1 then
				self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				return false
				end
				
				-- Players cannot throw items on reward chest
				local tile = Tile(toPosition)
				if tile and tile:getItemById(ITEM_REWARD_CHEST) then
				self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				self:getPosition():sendMagicEffect(CONST_ME_POFF)
				return false
				end
				
				-- Players cannot throw items on teleports
				if blockTeleportTrashing and toPosition.x ~= CONTAINER_POSITION then
				local thing = Tile(toPosition):getItemByType(ITEM_TYPE_TELEPORT)
				if thing then
				self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				self:getPosition():sendMagicEffect(CONST_ME_POFF)
				return false
				end
				end
				
				if tile and tile:getItemById(370) then -- Trapdoor
				self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				self:getPosition():sendMagicEffect(CONST_ME_POFF)
				return false
				end
				
				if not antiPush(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder) then
				return false
				end
				
				return true
				end
				
				function Player:onItemMoved(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
				end
				
				function Player:onMoveCreature(creature, fromPosition, toPosition)
				return true
				end
				
				local function hasPendingReport(name, targetName, reportType)
				local f = io.open(string.format("data/reports/players/%s-%s-%d.txt", name, targetName, reportType), "r")
				if f then
				io.close(f)
				return true
				else
				return false
				end
				end
				
				function Player:onReportRuleViolation(targetName, reportType, reportReason, comment, translation)
				local name = self:getName()
				if hasPendingReport(name, targetName, reportType) then
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your report is being processed.")
				return
				end
				
				local file = io.open(string.format("data/reports/players/%s-%s-%d.txt", name, targetName, reportType), "a")
				if not file then
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There was an error when processing your report, please contact a gamemaster.")
				return
				end
				
				io.output(file)
				io.write("------------------------------\n")
				io.write("Reported by: " .. name .. "\n")
				io.write("Target: " .. targetName .. "\n")
				io.write("Type: " .. reportType .. "\n")
				io.write("Reason: " .. reportReason .. "\n")
				io.write("Comment: " .. comment .. "\n")
				if reportType ~= REPORT_TYPE_BOT then
				io.write("Translation: " .. translation .. "\n")
				end
				io.write("------------------------------\n")
				io.close(file)
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Thank you for reporting %s. Your report will be processed by %s team as soon as possible.", targetName, configManager.getString(configKeys.SERVER_NAME)))
				return
				end
				
				function Player:onReportBug(message, position, category)
				local name = self:getName()
				local file = io.open("data/reports/bugs/" .. name .. " report.txt", "a")
				
				if not file then
				self:sendTextMessage(MESSAGE_EVENT_DEFAULT, "There was an error when processing your report, please contact a gamemaster.")
				return true
				end
				
				io.output(file)
				io.write("------------------------------\n")
				io.write("Name: " .. name)
				if category == BUG_CATEGORY_MAP then
				io.write(" [Map position: " .. position.x .. ", " .. position.y .. ", " .. position.z .. "]")
				end
				local playerPosition = self:getPosition()
				io.write(" [Player Position: " .. playerPosition.x .. ", " .. playerPosition.y .. ", " .. playerPosition.z .. "]\n")
				io.write("Comment: " .. message .. "\n")
				io.close(file)
				
				self:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Your report has been sent to " .. configManager.getString(configKeys.SERVER_NAME) .. ".")
				return true
				end
				
				function Player:onTurn(direction)
				if self:getGroup():getAccess() and self:getDirection() == direction then
				local nextPosition = self:getPosition()
				nextPosition:getNextPosition(direction)
				
				self:teleportTo(nextPosition, true)
				end
				
				return true
				end
				
				function Player:onTradeRequest(target, item)
				-- No trade items with actionID = 8000
				if item:getActionId() == BLOCK_ITEM_WITH_ACTION then
				return false
				end
				
				if isInArray(storeItemID,item.itemid) then
				return false
				end
				return true
				end
				
				function Player:onTradeAccept(target, item, targetItem)
				return true
				end
				
				local soulCondition = Condition(CONDITION_SOUL, CONDITIONID_DEFAULT)
				soulCondition:setTicks(4 * 60 * 1000)
				soulCondition:setParameter(CONDITION_PARAM_SOULGAIN, 1)
				
				local function useStamina(player)
				local staminaMinutes = player:getStamina()
				if staminaMinutes == 0 then
				return
				end
				
				local playerId = player:getId()
				local currentTime = os.time()
				local timePassed = currentTime - nextUseStaminaTime[playerId]
				if timePassed <= 0 then
				return
				end
				
				if timePassed > 60 then
				if staminaMinutes > 2 then
				staminaMinutes = staminaMinutes - 2
				else
				staminaMinutes = 0
				end
				nextUseStaminaTime[playerId] = currentTime + 120
				else
				staminaMinutes = staminaMinutes - 1
				nextUseStaminaTime[playerId] = currentTime + 60
				end
				player:setStamina(staminaMinutes)
				end
				
				local function useStaminaXp(player)
				local staminaMinutes = player:getExpBoostStamina() / 60
				if staminaMinutes == 0 then
				return
				end
				
				local playerId = player:getId()
				local currentTime = os.time()
				local timePassed = currentTime - nextUseXpStamina[playerId]
				if timePassed <= 0 then
				return
				end
				
				if timePassed > 60 then
				if staminaMinutes > 2 then
				staminaMinutes = staminaMinutes - 2
				else
				staminaMinutes = 0
				end
				nextUseXpStamina[playerId] = currentTime + 120
				else
				staminaMinutes = staminaMinutes - 1
				nextUseXpStamina[playerId] = currentTime + 60
				end
				player:setExpBoostStamina(staminaMinutes * 60)
				end
				
				-- Prey slots consumption
				local function preyTimeLeft(player, slot)
				local timeLeft = player:getPreyTimeLeft(slot) / 60
				local monster = player:getPreyCurrentMonster(slot)
				if (timeLeft > 0) then
				local playerId = player:getId()
				local currentTime = os.time()
				local timePassed = currentTime - nextPreyTime[playerId][slot]
				if timePassed >= 59 then
				timeLeft = timeLeft - 1
				nextPreyTime[playerId][slot] = currentTime + 60
				else
				timeLeft = timeLeft - 0
				end
				-- Expiring prey as there's no timeLeft
				if (timeLeft < 1) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Your %s's prey has expired.", monster:lower()))
				player:setPreyCurrentMonster(slot, "")
				end
				-- Setting new timeLeft
				player:setPreyTimeLeft(slot, timeLeft * 60)
				else
				-- Expiring prey as there's no timeLeft
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Your %s's prey has expired.", monster:lower()))
				player:setPreyCurrentMonster(slot, "")
				end
				return player:sendPreyData(slot)
				end
				
				function Player:onGainExperience(source, exp, rawExp)
				if not source or source:isPlayer() then
				return exp
				end
				
				-- Soul Regeneration
				local vocation = self:getVocation()
				if self:getSoul() < vocation:getMaxSoul() and exp >= self:getLevel() then
				soulCondition:setParameter(CONDITION_PARAM_SOULTICKS, vocation:getSoulGainTicks() * 1000)
				self:addCondition(soulCondition)
				end
				
				
				-- Experience Stage Multiplier
				exp = exp * Game.getExperienceStage(self:getLevel())
				
				
				
				baseExp = rawExp * Game.getExperienceStage(self:getLevel())
				if Game.getStorageValue(GlobalStorage.XpDisplayMode) > 0 then
				displayRate = Game.getExperienceStage(self:getLevel())
				else
				displayRate = 1
				end
				
				-- Prey Bonus
				--for slot = CONST_PREY_SLOT_FIRST, CONST_PREY_SLOT_THIRD do
				--if (self:getPreyCurrentMonster(slot) == source:getName() and self:getPreyBonusType(slot) == CONST_BONUS_XP_BONUS) then
				--exp = exp + math.floor(exp * (self:getPreyBonusValue(slot) / 100))
				--preyTimeLeft(self, slot) -- slot consumption
				--break
				--end
				--end
				
				-- Store Bonus
				local Boost = self:getExpBoostStamina()
				useStaminaXp(self) -- Use store boost stamina
				self:setStoreXpBoost(Boost > 0 and 50 or 0)
				if (self:getExpBoostStamina() <= 0 and self:getStoreXpBoost() > 0) then
				self:setStoreXpBoost(0) -- Reset Store boost to 0 if boost stamina has ran out
				end
				if (self:getStoreXpBoost() > 0) then
				exp = exp + (baseExp * (self:getStoreXpBoost()/100)) -- Exp Boost
				
				displayRate = displayRate * ((self:getStoreXpBoost()+100)/100)
				end
				
				-- Stamina Bonus
				if configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
				useStamina(self)
				local staminaMinutes = self:getStamina()
				if staminaMinutes > 2400 and self:isPremium() then
				exp = exp + exp * 0.5
				
				displayRate = displayRate + Game.getExperienceStage(self:getLevel()) * 0.5
				self:setStaminaXpBoost(150)
				elseif staminaMinutes <= 840 then
				exp = exp * 0.5
				self:setStaminaXpBoost(50)
				displayRate = displayRate * 0.5
				else
				self:setStaminaXpBoost(100)
				end
				--for slot = CONST_PREY_SLOT_FIRST, CONST_PREY_SLOT_THIRD do
				--if self:getPreyState(slot) == 2 then
				--preyTimeLeft(self, slot) -- slot consumption
				--end
				--end
				end
				displayRate = Game.getExperienceStage(self:getLevel())
				self:setBaseXpGain(displayRate * 100)
				return exp
				end
				
				function Player:onLoseExperience(exp)
				return exp
				end
				
				
				function getMagicLevelStage(a)
				local b = 1
				if a >= 0 and a <= 20 then
				b = 24
				elseif a >= 21 and a <= 40 then
				b = 20	
				elseif a >= 41 and a <= 60 then
				b = 16
				elseif a >= 61 and a <= 80 then
				b = 12
				elseif a >= 81 and a <= 90 then
				b = 8
				elseif a >= 91 and a <= 99 then
				b = 4
				elseif a >= 100 then
				b = 2
				end
				
				return b
				end
				
				function getSkillStage(a)
				local b = 1
				if a >= 0 and a <= 20 then
				b = 25
				elseif a >= 21 and a <= 40 then
				b = 20
				elseif a >= 41 and a <= 60 then
				b = 16
				elseif a >= 61 and a <= 80 then
				b = 12
				elseif a >= 81 and a <= 99 then
				b = 8
				elseif a >= 100 then
				b = 4
				end
				
				return b
				end
				
				
				function Player:onGainSkillTries(skill, tries)
				if not tries then
				local tries = 1
				end
				
				if APPLY_SKILL_MULTIPLIER == false then
				return tries
				end
				
				if skill == SKILL_MAGLEVEL then
				--print(tries, getMagicLevelStage(self:getMagicLevel(skill)))
				return tries * getMagicLevelStage(self:getMagicLevel(skill))
				end
				
				--return tries * configManager.getNumber(configKeys.RATE_SKILL) * Game.getSkillStage(2)
				--print(getSkillStage(tries, self:getSkillLevel(skill)))
				return tries * getSkillStage(self:getSkillLevel(skill))
				
				
				end
				
				function Player:onRemoveCount(item)
				-- Apenas cliente 11.x
				if self:getClient().os == CLIENTOS_NEW_WINDOWS then
				self:sendWaste(item:getId())
				end
				end
				
				function Player:onRequestQuestLog()
				self:sendQuestLog()
				end
				
				function Player:onRequestQuestLine(questId)
				self:sendQuestLine(questId)
				end
				
				function Player:onStorageUpdate(key, value, oldValue, currentFrameTime)
				self:updateStorage(key, value, oldValue, currentFrameTime)
				end
				
				function Player:canBeAppliedImbuement(imbuement, item)
				local categories = {}
				local slots = ItemType(item:getId()):getImbuingSlots()
				if slots > 0 then
				for slot = 0, slots - 1 do
				local duration = item:getImbuementDuration(slot)
				if duration > 0 then
				local imbue = item:getImbuement(slot)
				local catid = imbue:getCategory().id
				table.insert(categories, catid)
				end
				end
				end
				
				if isInArray(categories, imbuement:getCategory().id) then
				return false
				end
				
				if imbuement:isPremium() and self:getPremiumDays() < 1 then
				return false
				end
				
				if not self:canImbueItem(imbuement, item) then
				return false
				end
				
				return true
				end
				
				function Player:onApplyImbuement(imbuement, item, slot, protectionCharm)
				for _, pid in pairs(imbuement:getItems()) do
				if self:getItemCount(pid.itemid) < pid.count then
				self:sendImbuementResult(MESSAGEDIALOG_IMBUEMENT_ROLL_FAILED, "You don't have all necessary items.")
				return false
				end
				end
				
				if item:getImbuementDuration(slot) > 0 then
				self:sendImbuementResult(MESSAGEDIALOG_IMBUEMENT_ERROR, "An error ocurred, please reopen imbuement window.")
				return false
				end
				local base = imbuement:getBase()
				local price = base.price + (protectionCharm and base.protection or 0)
				
				local chance = protectionCharm and 100 or base.percent
				if math.random(100) > chance then
				self:sendImbuementResult(MESSAGEDIALOG_IMBUEMENT_ROLL_FAILED, "Item failed to apply imbuement.")
				return false
				end
				
				-- Removing items
				for _, pid in pairs(imbuement:getItems()) do
				if not self:removeItem(pid.itemid, pid.count) then
				self:sendImbuementResult(MESSAGEDIALOG_IMBUEMENT_ROLL_FAILED, "You don't have all necessary items.")
				return false
				end
				end
				
				if not self:removeMoneyNpc(price) then
				self:sendImbuementResult(MESSAGEDIALOG_IMBUEMENT_ROLL_FAILED, "You don't have enough money " ..price.. " gps.")
				return false
				end
				
				if not item:addImbuement(slot, imbuement:getId()) then
				self:sendImbuementResult(MESSAGEDIALOG_IMBUEMENT_ROLL_FAILED, "Item failed to apply imbuement.")
				return false
				end
				
				-- Update item
				local nitem = Item(item.uid)
				self:sendImbuementPanel(nitem)
				return true
				end
				
				function Player:clearImbuement(item, slot)
				local slots = ItemType(item:getId()):getImbuingSlots()
				if slots < slot then
				self:sendImbuementResult(MESSAGEDIALOG_CLEARING_CHARM_ERROR, "Sorry, not possible.")
				return false
				end
				
				if item:getTopParent() ~= self or item:getParent() == self then
				self:sendImbuementResult(MESSAGEDIALOG_CLEARING_CHARM_ERROR, "An error occurred while applying the clearing charm to the item.")
				return false
				end
				
				-- slot is not used
				local info = item:getImbuementDuration(slot)
				if info == 0 then
				self:sendImbuementResult(MESSAGEDIALOG_CLEARING_CHARM_ERROR, "An error occurred while applying the clearing charm to the item.")
				return false
				end
				
				local imbuement = item:getImbuement(slot)
				if not self:removeMoneyNpc(imbuement:getBase().removecust) then
				self:sendImbuementResult(MESSAGEDIALOG_CLEARING_CHARM_ERROR, "You don't have enough money " ..imbuement:getBase().removecust.. " gps.")
				return false
				end
				
				if not item:cleanImbuement(slot) then
				self:sendImbuementResult(MESSAGEDIALOG_CLEARING_CHARM_ERROR, "An error occurred while applying the clearing charm to the item.")
				return false
				end
				
				-- Update item
				local nitem = Item(item.uid)
				self:sendImbuementResult(MESSAGEDIALOG_CLEARING_CHARM_SUCCESS, "Congratulations! You have successfully applied the clearing charm to your item.");
				self:sendImbuementPanel(nitem)
				
				return true
				end
				
				function Player:onCombat(target, item, primaryDamage, primaryType, secondaryDamage, secondaryType)
				if not item or not target then
				return primaryDamage, primaryType, secondaryDamage, secondaryType
				end
				
				local slots = ItemType(item:getId()):getImbuingSlots()
				if slots > 0 then
				for i = 0, slots - 1 do
				local imbuement = item:getImbuement(i)
				if imbuement then
				local percent = imbuement:getElementDamage()
				if percent and percent > 0 then
				if primaryDamage ~= 0 then
				secondaryDamage = primaryDamage*math.min(percent/100, 1)
				secondaryType = imbuement:getCombatType()
				primaryDamage = primaryDamage - primaryDamage*math.min(percent/100, 1)
				elseif secondaryDamage ~= 0 then
				primaryDamage = secondaryDamage*math.min(percent/100, 1)
				primaryType = imbuement:getCombatType()
				secondaryDamage = secondaryDamage - secondaryDamage*math.min(percent/100, 1)
				end
				end
				end
				end
				end
				
				return primaryDamage, primaryType, secondaryDamage, secondaryType
				end
								