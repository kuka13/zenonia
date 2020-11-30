function onModalWindow(player, modalWindowId, buttonId, choiceId)
	player:unregisterEvent('reset')
	if modalWindowId == 1127 then
	
	if buttonId == 100 then
	
	local inicialResetValue = 50000000
	local newLevelAfterReset = 30
	local resetValueGain = 50
	local playerResets = player:getStorageValue(Storage.ResetSystem.amount)
	
	local newResetValue = inicialResetValue + ((inicialResetValue*resetValueGain/100)*playerResets)
		
	if player:removeMoney(newResetValue) then
	
	player:setStorageValue(Storage.ResetSystem.amount, playerResets + 1)
	-- aqui redefinir hp, mana e cap
	--primeiro calcular o ganho
	local hpGain = 200
	local manaGain = 200
	local capGain = 100
	
		local vocation = player:getVocation()
	local hpBase = 185
	local manaBase = 185
	local capBase = 100000

	
	local mul = 1
	if playerResets > 0 then
		mul = mul + playerResets
	end
		
	local newHp = hpBase+((hpBase*hpGain/100)*mul)
	local newMana = manaBase+((manaBase*manaGain/100)*mul)
	local newCap = capBase+((capBase*capGain/100)*mul)
	--end of calcular ganho
	
	player:setMaxHealth(newHp)
	player:addHealth(player:getMaxHealth())
	player:setMaxMana(newMana)
	player:addMana(player:getMaxMana())
	player:setCapacity(newCap)
	--
	-- AQUI MOVER A BP PRO DEPOT
	local inbox = player:getInbox()
	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
	if backpack then
	backpack:moveTo(inbox)
	end
	-- END
	
	local resultId = db.storeQuery("SELECT `id` FROM `players` WHERE `name` = " .. db.escapeString(player:getName():lower()))
	local accountId = result.getDataInt(resultId, "id")
	local newResets = player:getStorageValue(Storage.ResetSystem.amount)
	player:remove()
	
	db.query("UPDATE `players` SET `level` = '30', `experience` = '368300' WHERE `players`.`id` = " .. accountId)
	
	
	end
	
	
	
	
	
	end
	
	end
end