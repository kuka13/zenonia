function onUse(player, item)
	local items = {
		{action = 59223, days = 3},
		{action = 59224, days = 7},
		{action = 59225, days = 15},
	}
	
	for i = 1, #items do
		if item.actionid == items[i].action then
			local tempo = 60 * 60 * 24 * items[i].days
			local message = 'Ativou '..items[i].days..' dias de regenboost.'
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
			
			
			
			local check = player:getStorageValue(25896)
			local regentime = check - os.time()
			if regentime > 0 then
				setPlayerStorageValue(player, 25896, os.time()+tempo+regentime)
				else
				setPlayerStorageValue(player, 25896, os.time()+tempo)
			end
		end
	end
	
    return false
end