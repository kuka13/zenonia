function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType , origin)
  local staminaRegen = 20
  
  if attacker:isPlayer() then
	attacker:setStamina(attacker:getStamina() + staminaRegen)
  end
	
  return primaryDamage, primaryType, secondaryDamage, secondaryType
end
