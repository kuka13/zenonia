function onUse(player, item)
	local items = {
		{action = 59226, horas = 3},
		{action = 59227, horas = 7},
		{action = 59228, horas = 15},
	}
	
	for i = 1, #items do
		if item.actionid == items[i].action then
			local tempo = 60 * 60 * 24 * items[i].horas
			local message = '[LootBoost] Ativou '..items[i].horas..' horas de LootBoost.'
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
			setPlayerStorageValue(player, 25894, os.time()+tempo)			
		end
	end
	
    return false
end