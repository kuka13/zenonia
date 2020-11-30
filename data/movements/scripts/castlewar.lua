	local function contagem(cid, num)

		local player = Player(cid)
		local tronoPos = Position(32273, 32192, 7)
		if player then

			local guild = player:getGuild()
			if guild then
				local guildName, guildId = guild:getName(), guild:getId()
				
				if not table.contains(castleWarGuildId, guildId) then
					table.insert(castleWarGuildId, guildId)
					castleWarGuildTimer[guildId] = 0
				end
					

				if player:getPosition() == tronoPos or castleWarLastPlayer == player:getGuid() then
					local tempo = 1
					castleWarGuildTimer[guildId] = castleWarGuildTimer[guildId] + 1
					for i = 1, #castleWarGuildId do
						
						if castleWarGuildId[i] == guildId then
							tempo = castleWarGuildTimer[guildId]
						end
					end
					
					local spectators = Game.getSpectators(tronoPos, false, true, 7, 7, 5, 5)

	        		if #spectators > 0 then	
	               		for i = 1, #spectators do
	                   		spectators[i]:say("[GuildWar] Guild: "..guildName.." Tempo: "..tempo.."", TALKTYPE_MONSTER_SAY, false, spectators[i], tronoPos)
	                	end
	        		end

	        		if castleWarGateLock == 0 then
	        			addEvent(contagem, 1000, player.uid, num)
					end		
				end
			end
		end
	end

	function onStepIn(creature, item, position, fromPosition)
		local player = creature:getPlayer()
		if not player then
			return
		end

		if not player:getGuild() then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar] Para participar precisa pertencer a uma guild.")
			player:teleportTo(fromPosition)
		end

		local modo
		if castleWarMode1 >	castleWarMode2 then
		modo = 1
		else
		modo = 2
		end


		if castleWarGateLock == 0 then --executar quando o gate esta liberado
			if castleWarLastPlayer ~= player:getGuid() and player:getGuild():getId() ~= castleWarLastPlayerGuild then
				castleWarLastPlayer = player:getGuid()
				castleWarLastPlayerGuild = player:getGuild():getId()
			if modo == 1 then
				addEvent(contagem, 1000, player.uid, 1)
				broadcastMessage("[CastleWar] O jogador "..player:getName() .." da guild "..player:getGuild():getName().." dominou o castelo! As outras guilds têm até às 22:00 para conseguir tirar o domínio deles, não desistam!", MESSAGE_EVENT_ADVANCE)
				player:teleportTo(fromPosition)
			elseif modo == 2 then
				
				broadcastMessage("[CastleWar] O jogador "..player:getName() .." da guild "..player:getGuild():getName().." dominou o castelo! As outras guilds têm até às 22:00 para conseguir tirar o domínio deles, não desistam!", MESSAGE_EVENT_ADVANCE)
				player:teleportTo(fromPosition)
				local playerGuild = player:getGuild()
				local playerGuildId = playerGuild:getId()
				if playerGuildId then
				castleWarlastGuildId = playerGuildId
				castleWarLastPlayerGuild = player:getGuild():getId()
				end

			end
			else
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[CastleWar] Sua guild ja esta dominando.")
				player:teleportTo(fromPosition)
			end
			
		end

		return true
	end

	function onStepOut(creature, item, position, fromPosition)
		local player = creature:getPlayer()
		if not player then
			return
		end


		return true
	end