function onSay(player, words, param)
	local config ={
	showinfo = true
	}
	
	local monsterType = MonsterType(param)
	if not monsterType then
		player:sendCancelMessage("Can't find monster.")
		return false
	end
	
	player:registerEvent('autoloot')
	local title = "Autoloot Helper!"
    local lootBlockList = monsterType:getLoot()
	
	infos = {monsterType:getName(),monsterType:getArmor(),monsterType:getDefense(),monsterType:getBaseSpeed(),monsterType:getMaxHealth()}
	local voice = monsterType:getVoices()
	local allvoices = ''
	
	for i = 1, #voice do
	allvoices = ''..allvoices..''..voice[i].text..'\n'
	end
	
	local message
	if config.showinfo == true then
	message = "Monster "..infos[1].." Found! \n\nArmor:"..infos[2].."\nDefense:"..infos[3].."\nSpeed:"..infos[4].."\nHP:"..infos[5].."\nLoots:"..#lootBlockList.."\n\nVoices: "..allvoices.." "
	else
	message = "Monster "..infos[1].." Found! \n\nLoots:"..#lootBlockList.."\n\nVoices: "..allvoices.." "
	end
	
	table.sort(lootBlockList, function(a, b) return ItemType(a.itemId):getName() < ItemType(b.itemId):getName() end)
		
	lootBlockListm[getPlayerGUID(player)] = lootBlockList
	lootBlockListn[getPlayerGUID(player)] = param	

	local window = ModalWindow(1001, title, message)
	
	window:addButton(107, "OK")
	window:sendToPlayer(player)
	return false
end

