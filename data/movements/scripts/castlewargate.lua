	function onStepIn(creature, item, position, fromPosition)
		local player = creature:getPlayer()
		if not player then
			return
		end

		if not player:getGuild():getId() then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar] Para participar precisa pertencer a uma guild.")
			player:teleportTo(fromPosition)
		end

		if castleWarGateLock == 0 or player:getGuild():getId() == castleWarlastGuildId then --executar quando o gate esta liberado, ou se e da guild dona do castle
			if item.itemid == 426 then
				item:transform(item.itemid - 1)
			end
		

		else

		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:teleportTo(fromPosition)
		if Guild(castleWarlastGuildId) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar]: Somente membros da guild "..Guild(castleWarlastGuildId):getName().." podem passar. Aguarde o inicio do evento as 21 horas.")
		else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar]: Aguarde o inicio do evento as 21 horas.")
		end
		
		

		end

		return true
	end


	function onStepOut(creature, item, position, fromPosition)
		local player = creature:getPlayer()
		if not player then
			return
		end

		if item.itemid == 425 then
		item:transform(item.itemid + 1)
		end

		return true
	end