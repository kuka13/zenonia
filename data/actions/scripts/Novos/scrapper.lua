function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player then
		local arenaId = player:getStorageValue(Storage.SvargrondArena.Arena)
		if arenaId < 1 then
			arenaId = 1
			player:setStorageValue(Storage.SvargrondArena.Arena, arenaId)
		end
		if ARENA[arenaId] then
			doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "Ainda nao completou.")
		else
			--abrir a porta e teleportar o player
			item:transform(item.itemid + 1)
			player:teleportTo(toPosition)
		end
		
		
		
	end
	
    return true
end