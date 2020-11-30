function onSay(player, words, param)

	local id = param

	if not player:getGuild() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar] Para participar precisa pertencer a uma guild.")
	end

	if castleWarVotation ~= 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar] No momento as votacoes estao encerradas.")
	end
	
	if not table.contains(castleWarVotePlayers, player:getGuid()) and castleWarGateLock == 1 then --o portao esta trancado e ainda nao teve evento

	if param == '1' then
	castleWarMode1 = castleWarMode1+1
	table.insert(castleWarVotePlayers, player:getGuid())
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar] Votou no modo 1.")

	elseif param == '2' then
	castleWarMode2 = castleWarMode2+1
	table.insert(castleWarVotePlayers, player:getGuid())
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar] Votou no modo 2.")
	else
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar] Erro: Vote em 1 ou 2.")
	end

	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar] Voce ja votou.")
	end
	return false
end