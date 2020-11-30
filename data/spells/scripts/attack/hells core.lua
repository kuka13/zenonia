local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 8) + 50
	local max = (level / 5) + (magicLevel * 12) + 75
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
		--bloqueio de spells
	if globalwarmodeUE == 1 then
	for i = 1, #warmodeKillAux do
	if creature:getGuid() == warmodeKillAux[i] then
	return creature:sendCancelMessage('Desativado durante essa war.')
	end
	end
	end
	-- end of bloqueio de spells
	return combat:execute(creature, variant)
end
