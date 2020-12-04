local StaminaConfig = {
	StaminaTime = 60000,
	StaminaRegen = 10,
	UseTime = 120
}
local function getTimeToUse(self)
  local storage = self:getStorageValue(16657)
  if storage <= 0 then
	return 0
  end	 
  return storage - os.time()
end
  
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
    addOutfitCondition(Nadar, {lookTypeEx = 29323})

function onStepIn(creature, position, fromPosition, toPosition)
    if not creature:isPlayer() then
    return false
    end
    if getTimeToUse(creature) >= 1 then
	creature:sendCancelMessage("You need to wait to use again.")
    return false
    end
	creature:setStorageValue(16656, 1)
    creature:getPosition():sendMagicEffect(54)
    creature:addCondition(Nadar)
    creature:sendCancelMessage("You entered the bath tube.")
	RegenerateStamina(creature, StaminaConfig.StaminaRegen, StaminaConfig.StaminaTime)
	creature:setStorageValue(16657, StaminaConfig.UseTime + os.time())
    return true
end

function onStepOut(creature, position, fromPosition, toPosition)
    if not creature:isPlayer() then
    return false
    end
    
    creature:sendCancelMessage("You left the bath tube.")
	creature:setStorageValue(16656, -1)
    creature:getPosition():sendMagicEffect(54)
    creature:removeCondition(CONDITION_OUTFIT)
return true
end