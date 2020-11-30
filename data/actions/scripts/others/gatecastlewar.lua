function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local tileEntrada = Position(32287, 32191, 7) -- Pos teleportado pra DENTRO do castelo
	local tileSaida = Position(32289, 32191, 7) -- Pos teleportado pra FORA do castelo
	
	if not player:getGuild():getId() then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar] Para participar precisa pertencer a uma guild.")
			player:teleportTo(fromPosition)
	end

	if castleWarGateLock == 0 then
	
		if item.actionid == 26001 then
			player:teleportTo(tileEntrada)
		elseif item.actionid == 26002 then
			player:teleportTo(tileSaida)
		end
	
	else
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Evento Fechado.")
	end


	return true
end
