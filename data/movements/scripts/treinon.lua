local StaminaConfig = {
	StaminaTime = 120000,
	StaminaRegen = 5
}

local function RegenerateStamina(player, stamina, time)
	if player:getStorageValue(16656) == 1 then
	player:setStamina(player:getStamina() + stamina)
	addEvent(function(player)
	local player = Player(player)
	if not player then
	return true
	end
	RegenerateStamina(player, stamina, time)
	end, time, player:getId())
	end
end

local Nadar = 
    createConditionObject(CONDITION_OUTFIT)
    setConditionParam(Nadar, CONDITION_PARAM_TICKS, - 1)
    addOutfitCondition(Nadar, {lookTypeEx = 27098})

function onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Ataque o Monk e voce vai receber 5 de stamina a cada 2 minutos treinando aqui.')
		--creature:stopLiveCast()
		local guid = creature:getGuid()
		if not table.contains(StaminaTreiner, guid) then
		table.insert(StaminaTreiner, guid)
		end
		
	end
		creature:setStorageValue(16656, 1)
		RegenerateStamina(creature, StaminaConfig.StaminaRegen, StaminaConfig.StaminaTime)
	return true
end

function onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	local guid = creature:getGuid()
	if table.contains(StaminaTreiner, guid) then
		for i = 15, #StaminaTreiner do
		if guid == StaminaTreiner[i] then
			table.remove(StaminaTreiner, i)
		end
		end
	end
		creature:setStorageValue(16656, -1)

	return true
end