local shutdownAtServerSave = true
local cleanMapAtServerSave = true


local function checkvipName()
	-- Tirando o VIP: string.gsub("[VIP]Marson", "%[VIP]", "")
	-- Adicionando o vip: local string = 'Marson' >>> string = '[VIP]'+string
	
	print('eu sou o checkname')
end

local function serverSave()
	saveServer()
	updateGlobalStorage(DailyReward.storages.lastServerSave, os.time())

	if shutdownAtServerSave then
		Game.setGameState(GAME_STATE_SHUTDOWN)
		checkvipName()
	else
		Game.setGameState(GAME_STATE_CLOSED)

		if cleanMapAtServerSave then
			--cleanMap()
		end

		Game.setGameState(GAME_STATE_CLOSED)
	end
end

local function secondServerSaveWarning()
	Game.broadcastMessage("Server Save em 1 minuto. Por favor va para um local seguro e aguarde. Vamos reiniciar e voltamos em 3 minutos.", MESSAGE_EVENT_ADVANCE)
	addEvent(serverSave, 60000)
end 
 
local function firstServerSaveWarning()
	Game.broadcastMessage("Server Save in 3 minutes. Please go to a safe place and wait.", MESSAGE_EVENT_ADVANCE)
	addEvent(secondServerSaveWarning, 120000)
end


function onTime(interval)
	Game.broadcastMessage("Server Save em 5 minutes. Por favor va para um local seguro e aguarde.", MESSAGE_EVENT_ADVANCE)
	addEvent(firstServerSaveWarning, 120000)
	return not shutdownAtServerSave
end
