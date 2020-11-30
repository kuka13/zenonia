function onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Ataque o Monk e voce vai receber 1 de stamina a cada 2 minutos treinando aqui.')
		--creature:stopLiveCast()
		local guid = creature:getGuid()
		if not table.contains(StaminaTreiner, guid) then
		table.insert(StaminaTreiner, guid)
		end
		
	end
	return true
end

function onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	local guid = creature:getGuid()
	if table.contains(StaminaTreiner, guid) then
		for i = 1, #StaminaTreiner do
		if guid == StaminaTreiner[i] then
			table.remove(StaminaTreiner, i)
		end
		end
	end
	

	return true
end