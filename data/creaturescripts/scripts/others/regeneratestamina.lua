function onLogin(player)
	if not configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
		return true
	end

	local lastLogout = player:getLastLogout()
	local offlineTime = lastLogout ~= 0 and math.min(os.time() - lastLogout, 86400 * 21) or 0
	offlineTime = offlineTime - 600

	if offlineTime < 120 then
		return true
	end

	local staminaMinutes = player:getStamina()
	local maxNormalStaminaRegen = 2400 - math.min(2400, staminaMinutes)

	local regainStaminaMinutes = offlineTime / 120
	if regainStaminaMinutes > maxNormalStaminaRegen then
		local happyHourStaminaRegen = (offlineTime - (maxNormalStaminaRegen * 120)) / 600
		staminaMinutes = math.min(2520, math.max(2400, staminaMinutes) + happyHourStaminaRegen)
	else
		staminaMinutes = staminaMinutes + regainStaminaMinutes
	end

	player:setStamina(staminaMinutes)
	return true
end