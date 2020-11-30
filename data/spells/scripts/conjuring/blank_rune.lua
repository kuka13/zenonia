function onCastSpell(creature, variant)
	--bloqueio de runas
	if globalwarmodeRunas == 1 then
	for i = 1, #warmodeKillAux do
	if creature:getGuid() == warmodeKillAux[i] then
	return creature:sendCancelMessage('Desativado durante essa war.')
	end
	end
	end
	-- end of bloqueio de runas
	return creature:conjureItem(0, 2260, 1)
end



