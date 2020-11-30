function onSay(cid, words, param)
	

local player = cid:getPlayer()
player:registerEvent('reset')
	local title = "Welcome to Advanced Reborn System!"
	
	local firstResetLevel = 800
	local increaseLevels = 50
	local newLevelAfterReset = 30
	
	local inicialResetValue = 50000000
	local resetValueGain = 50
	
	
	
	if player:getStorageValue(Storage.ResetSystem.amount) < 0 then
	player:setStorageValue(Storage.ResetSystem.amount, 0)
	end
	
	local playerResets = player:getStorageValue(Storage.ResetSystem.amount)
	
	
	local resetLevel = firstResetLevel + (increaseLevels * playerResets)
	
	local canReset = 0
	local newResetValue = inicialResetValue + ((inicialResetValue*resetValueGain/100)*playerResets)
	
	
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
	
	
	if player:getLevel() >= resetLevel and player:getMoney() >= newResetValue then
	canReset = 1
	end
	
	
    
local message = "Atualmente voce possui "..playerResets.." Reborns. \n\nValor necessario para o proximo reborn: "..newResetValue.." gp.\nLevel necessario para o proximo reborn: "..resetLevel.."\n\nQuando atingir o level e possuir o valor necessario o botao de Reborn aparecera. \n\nAo resetar voce voltara ao level "..newLevelAfterReset..", porem seu HP, Mana e Cap aumentam  em 100% da base atual a cada Reborn (VOCE NAO PERDERA SEUS SKILLS ATUAIS)\n\nINFO:\nHEALTH Level 30: "..hpBase.." hp > Depois do proximo Reborn: ".. newHp .." hp\nMANA Level 30: "..manaBase.." mp > Depois do proximo Reborn: "..newMana.." mp\nCAP Level 30: ".. capBase/100 .." oz > Depois do proximo Reborn: ".. newCap/100 .." oz\n\n Voce sera deslogado automaticamente ao Resetar e sua BACKPACK sera movida para o DEPOT INBOX."
  
    local window = ModalWindow(1127, title, message)
	
	if canReset == 1 then
    window:addButton(100, "Reborn")
    end
	window:addButton(101, "Cancel")
  
   
  
    window:sendToPlayer(player)


	
	
	return false
end
