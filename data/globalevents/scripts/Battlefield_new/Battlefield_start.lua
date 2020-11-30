local TELEPORT_POSITION = Position(32007, 32069, 6)
local TELEPORT_ACTIONID = 4500
local TELEPORT_ITEMID = 1387

local config = {
	semana_mes = "semana",
    days = {1, 2, 3, 4, 5, 6, 7}, -- Cada número representa um dia da semana. Ex.: 2 = segunda-feira
}

local function warnEvent(i, minutes)
	Game.broadcastMessage("[Battlezona] O evento vai Startar em ".. minutes .. " minutos! O portal esta localizado na sala Events do templo.")
	if i > 1 then
		addEvent(warnEvent, 2 * 60 * 1000, i - 1, minutes - 2)
	end
end

local function removeTeleport()
local teleport = Tile(TELEPORT_POSITION):getItemById(TELEPORT_ITEMID)
	if teleport then
		teleport:remove()
	else
		error("Não havia teleport.")
	end	
end

local function openBattlefield()
	Battlefield:Open()
end

local function closeBattlefield()
	Battlefield:Close()
end

local function openChannel()
	Game.openEventChannel("Battlefield")
end

function onTime(interval)
local time = os.date("*t")
	if (config.semana_mes == "semana" and isInArray(config.days,time.wday)) or (config.semana_mes == "mes" and isInArray(config.days,time.day)) or config.semana_mes == "" then
		Game.broadcastMessage("[Battlezona] O evento vai Startar em 10 minutos! O portal esta localizado na sala Events do templo.")
		local teleport = Game.createItem(TELEPORT_ITEMID, 1, TELEPORT_POSITION)	
		if teleport then
			teleport:setActionId(TELEPORT_ACTIONID)
		else
			error("ERROR AO CRIAR TELEPORT")
		end
		addEvent(openChannel, 1000 * 10 * 60) 
		addEvent(warnEvent, 2 * 60 * 1000, 4, 8) 
		addEvent(removeTeleport, 10 * 60 * 1000) 
		addEvent(openBattlefield, 10 * 60 * 1000) 
		addEvent(closeBattlefield, (30 + 10) * 60 * 1000)
	end
	return true
end
