local fromx, fromy, fromz = 32273, 32185, 7
local tox, toy, toz = 32287, 32199, 7

local function castleWarEnd(num)
	local tileSaida = Position(32290, 32192, 7) -- Pos teleportado pra FORA do castelo
	print('castleWar Encerrado')
	castleWarGateLock = 3 -- nao vai ter mais castle hoje...
	
	local modo
	if castleWarMode1 >	castleWarMode2 then
		modo = 1
		else
		modo = 2
	end
	
	if modo == 1 then
		local guildId = 0
		local tempo = 0
		local guilds = {}
		
		for i = 1, #castleWarGuildId do
			local tempGuild = castleWarGuildId[i]
			if castleWarGuildTimer[tempGuild] > tempo then
				tempo = castleWarGuildTimer[tempGuild]
				guildId = tempGuild
			end
			table.insert(guilds, tempGuild)
		end
		
		if guildId > 0 then
			local guild = Guild(guildId)
			local guildName, guildId = guild:getName(), guild:getId()
			print(guildName, guildId)
			broadcastMessage("[CastleWar] Parabens a Guild Vencedora: "..guildName.."!!!", MESSAGE_STATUS_WARNING)
			castleWarlastGuildId = guildId -- guardar a ultima guild pra usar no gate
			db.query("DELETE FROM `castle_war`")
			db.query("INSERT INTO `castle_war` (`lastwinnerguild`) VALUES (".. guildId ..")")
			
			for x = fromx, tox do
					for y = fromy, toy do
						local position = Position(x, y, fromz)
						local creature = Tile(position):getTopCreature()
						if position then
							if creature then
								if isPlayer(creature.uid) and creature.uid ~= 0 then
									doSendMagicEffect(getCreaturePosition(creature), 2)
									if creature:getGuild() then
										local playerguild = creature:getGuild():getId()
										if playerguild ~= guildId then
											creature:teleportTo(tileSaida)
										end
										else
										creature:teleportTo(tileSaida)
									end
								end
							end
						end
					end
				end	
			
		end
	end
	
	if modo == 2 then
		if castleWarlastGuildId > 0 then
			local guildId = castleWarlastGuildId
			if guildId > 0 then
				local guild = Guild(guildId)
				local guildName, guildId = guild:getName(), guild:getId()
				print(guildName, guildId)
				broadcastMessage("[CastleWar] Parabens a Guild Vencedora: "..guildName.."!!!", MESSAGE_STATUS_WARNING)
				--limpar ultimo result
				
				db.query("DELETE FROM `castle_war`")
				db.query("INSERT INTO `castle_war` (`lastwinnerguild`) VALUES (".. guildId ..")")
				
				for x = fromx, tox do
					for y = fromy, toy do
						local position = Position(x, y, fromz)
						local creature = Tile(position):getTopCreature()
						if position then
							if creature then
								if isPlayer(creature.uid) and creature.uid ~= 0 then
									doSendMagicEffect(getCreaturePosition(creature), 2)
									if creature:getGuild() then
										local playerguild = creature:getGuild():getId()
										if playerguild ~= guildId then
											creature:teleportTo(tileSaida)
										end
										else
										creature:teleportTo(tileSaida)
									end
								end
							end
						end
					end
				end	
				
			end
			
		end
	end
	
	
end

local function castleWarVotesEnd(random)
	castleWarVotation = 0 -- votacao acabou
	--liberar a porta para os times entrar no castelo
	castleWarGateLock = 0
	
	if castleWarMode1 == 0 and castleWarMode2 == 0 then
		if random == 1 then
			castleWarMode1 = 1
			elseif random == 2 then
			castleWarMode2 = 1
		end
	end
	
	local modo, text
	if castleWarMode1 >	castleWarMode2 then
		modo = 1
		text = '(Dominar o castelo por mais tempo)'
		else
		modo = 2
		text = '(Ultimo a Dominar o castelo)'
	end
	
	broadcastMessage("[CastleWar] Atencao, O CASTELO esta aberto para batalha, junte-se com sua guild e  conquiste-o. O castelo encerra em 1 hora. Resultado das votacoes: First: "..castleWarMode1.." Second: "..castleWarMode2.." Resultado: "..text.." foi escolhido", MESSAGE_STATUS_WARNING)
	
	
	local tempo = 1 --minutos para dominar o trono.
	addEvent(castleWarEnd, 1000*60*tempo, 1)
end

function onStartup()
	print('[Castle War]')
	-- trancar o portao
	castleWarGateLock = 1
	castleWarGuildId = {}
	castleWarGuildTimer = {}
	castleWarLastPlayer = nil
	castleWarLastPlayerGuild = nil
	castleWarMode1 = 0
	castleWarMode2 = 0
	castleWarlastGuildId = 0
	castleWarVotePlayers = {}
	castleWarVotation = 0
	
	db.query("CREATE TABLE IF NOT EXISTS `castle_war` (`lastwinnerguild` TINYINT(1) NOT NULL DEFAULT 0) ENGINE = InnoDB")
	
	local resultId = db.storeQuery("SELECT `lastwinnerguild` FROM `castle_war` ORDER BY lastwinnerguild DESC LIMIT 1")
	if resultId then
		if result.getNumber(resultId, "lastwinnerguild") >= 0 then
			castleWarlastGuildId = result.getNumber(resultId, "lastwinnerguild")
			print('[Castle War] Carregada a guild '..castleWarlastGuildId..' como dominante do castelo')
		end
		result.free(resultId)
	end
end


function onTime(interval)
	print('[Castle War votacao aberta]')
	local tempovoto = 1 -- aqui quantos minutos podera ficar votando
	local random = math.random(1,2)
	broadcastMessage("[Castle War]: Foi iniciada a votação para decidir o objetivo do castelo que abre em alguns minutos. Use !castle1 para votar no objetivo (Dominar o castelo por mais tempo). Use !castle2 para votar no objetivo (Ultimo que dominar o castelo). Caso não haja votações, o objetivo será aleatorio.", MESSAGE_STATUS_WARNING)
	addEvent(castleWarVotesEnd, 1000*60*tempovoto, random)
	castleWarVotation = 1
end