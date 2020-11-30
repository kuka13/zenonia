local cleanMapAtSave = false

local function serverSave(interval)
	if cleanMapAtSave then
		cleanMap()
	end

	saveServer()
	Game.broadcastMessage('Auto Save finalizado, o proximo vai ocorrer em ' .. math.floor(interval / 60000) .. ' minutos!', MESSAGE_STATUS_WARNING)
end

function onThink(interval)
	Game.broadcastMessage('Salvaremos todas as contas em 60 segundos.', MESSAGE_STATUS_WARNING)
	addEvent(serverSave, 60000, interval)
	return true
end