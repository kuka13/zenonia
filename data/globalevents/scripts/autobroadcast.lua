-- 

function onThink(interval, lastExecution)
	local messages = {
	
	"[TICKETS]: Encontrou algum BUG? Reporte utilizando Ctrl+Z e resolveremos em breve.",
	
	"[POINTS]: Dica: Logue MCS para ganhar mais Online Points.",
	
	"[SISTEMA]: O global save do servidor ocorre todos os dias de 05:00hrs.",
	
	}

    Game.broadcastMessage(messages[math.random(#messages)], MESSAGE_EVENT_ADVANCE) 
    return true
end

