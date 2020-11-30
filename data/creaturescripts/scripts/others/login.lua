function Player.sendTibiaTime(self, hours, minutes)
	local msg = NetworkMessage()
	msg:addByte(0xEF)
	msg:addByte(hours)
	msg:addByte(minutes)
	msg:sendToPlayer(self)
	msg:delete()
	return true
end

local events = {
    'ParasiteWarzone',
    'ElementalSpheresOverlords',
    'BigfootBurdenVersperoth',
    'BigfootBurdenWiggler',
    'SvargrondArenaKill',
    'NewFrontierShardOfCorruption',
    'NewFrontierTirecz',
    'ServiceOfYalaharDiseasedTrio',
    'ServiceOfYalaharAzerus',
    'ServiceOfYalaharQuaraLeaders',
    'InquisitionBosses',
    'InquisitionUngreez',
    'KillingInTheNameOfKills',
	'KillingInTheNameOfKillss',
	'KillingInTheNameOfKillsss',
    'MastersVoiceServants',
    'SecretServiceBlackKnight',
    'ThievesGuildNomad',
    'WotELizardMagistratus',
    'WotELizardNoble',
    'WotEKeeper',
    'WotEBosses',
    'WotEZalamon',
    'WarzoneThree',
    'PlayerDeath',
    'AdvanceSave',
    'bossesWarzone',
    'AdvanceRookgaard',
    'PythiusTheRotten',
    'DropLoot',
    'Yielothax',
    'BossParticipation',
    'Energized Raging Mage',
    'Raging Mage', 
    'DeathCounter',
    'KillCounter',
    'bless1',
	'lowerRoshamuul',
	'SpikeTaskQuestCrystal',
	'SpikeTaskQuestDrillworm',
	'petlogin',
	'petthink',
	'petdeath',
	'UpperSpikeKill',
	'MiddleSpikeKill',
	'LowerSpikeKill',
	'BossesForgotten',
	'ReplicaServants',
	'EnergyPrismDeath',
	'AstralPower',
	'BossesKill',
	'TheShattererKill',
	'BossesHero',
	'DragonsKill',
    'deeplingBosses',
	'modalAD',
    'modalMD',
    'imbueDamage',
	'autolootkill',
	'autoloot',
	'Critical'
}

local function onMovementRemoveProtection(cid, oldPosition, time)
    local player = Player(cid)
    if not player then
        return true
	end
	
    local playerPosition = player:getPosition()
    if (playerPosition.x ~= oldPosition.x or playerPosition.y ~= oldPosition.y or playerPosition.z ~= oldPosition.z) or player:getTarget() then
        player:setStorageValue(Storage.combatProtectionStorage, 0)
        return true
	end
	
    addEvent(onMovementRemoveProtection, 1000, cid, oldPosition, time - 1) 
end

function onLogin(player)
	
	
	regenBoost(player:getGuid())
	
	
	local loginStr = 'Welcome to ' .. configManager.getString(configKeys.SERVER_NAME) .. '!'
	---if (player:getAccountType() == ACCOUNT_TYPE_NORMAL) then
    ---player:startLiveCast()
	---player:sendTextMessage(MESSAGE_INFO_DESCR, "You have started casting your gameplay. Commands: !spectators - !stopcast")
    ---end
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. ' Please choose your outfit.'		
		player:setBankBalance(0)
		
		if player:getSex() == 1 then
			player:setOutfit({lookType = 128, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 76})		
			else
			player:setOutfit({lookType = 136, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 76})	
		end
		
		player:sendTutorial(1)
		else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end
		
		loginStr = string.format('Your last visit was on %s.', os.date('%a %b %d %X %Y', player:getLastLoginSaved()))
	end
	
    player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
	player:openChannel(10) -- LOOT CHANNEL
	
    local playerId = player:getId()
	
	DailyReward.init(playerId)    
	
    player:loadSpecialStorage()
	
    --[[-- Maintenance mode
		if (player:getGroup():getId() < 2) then
        return false
		else
        
	end--]]
	
    if (player:getGroup():getId() >= 4) then
        player:setGhostMode(true)
	end
	if player:getStorageValue(STORAGE_PLAYER_IN_ARENA) == 1 then
		player:setStorageValue(STORAGE_PLAYER_IN_ARENA, 0)
		player:setStorageValue(STORAGE_PLAYER_WAR_TYPE, 0)
		player:setStorageValue(STORAGE_POTION, 0)
		player:setStorageValue(STORAGE_SSAEXAUST, 0)
		local templePosition = player:getTown():getTemplePosition()
		player:teleportTo(templePosition)
		templePosition:sendMagicEffect(CONST_ME_TELEPORT)
	end
    -- Stamina
    nextUseStaminaTime[playerId] = 1
	
    -- EXP Stamina
    nextUseXpStamina[playerId] = 1
	
    -- Prey Stamina
    nextUseStaminaPrey[playerId+1] = {Time = 1}
    nextUseStaminaPrey[playerId+2] = {Time = 1}
    nextUseStaminaPrey[playerId+3] = {Time = 1}
	
    -- Prey Data
    if (player:getVocation():getId() ~= 0) then
        --[[local columnUnlocked = getUnlockedColumn(player)
			if (not columnUnlocked) then
            columnUnlocked = 0
			end
			
			for i = 0, columnUnlocked do
            sendPreyData(player, i)
		end]]
	end
	
    if (player:getAccountType() == ACCOUNT_TYPE_TUTOR) then
        local msg = [[:: Regras Tutor ::
            1*>3 Advertencias voce perde o cargo.
            2*>Sem conversas paralelas com jogadores no Help, se o player comeÃ§ar a ofender, voce simplesmente o mute.
            3*>Seja educado com os player no Help e principalmente no Privado, tenta ajudar o maximo possivel.
            4*>Sempre logue no seu horario, caso nao tiver uma justificativa voce sera removido da staff.
            5*>Help eh somente permitido realizar dÃºvidas relacionadas ao tibia.
            6*>Nao eh Permitido divulgar time pra upar ou para ajudar em quest.
            7*>Nao eh permitido venda de itens no Help.
            8*>Caso o player encontre um bug, peca para ir ao site mandar um ticket e explicar em detalhes.
            9*>Mantenha sempre o Chat dos Tutores aberto. (obrigatorio).
            10*>Voce terminou de cumprir seu horario, viu que nao tem nenhum tutor Online, voce comunica com algum CM in-game ou ts e fica no help ate alguem logar, se der.
            11*>Mantenha sempre um otimo portugues no Help, queremos tutores que deem suporte, nao que fiquem falando um ritual satanico.
            12*>Se ver um tutor fazendo algo que infrinja as regras, tire uma print e envie aos superiores."
            -- Comandos --
            Mutar Player: /mutex nick,90. (90 segundos)
            Desmutar Player: /unmute nick.
		-- Comandos --]]
        player:popupFYI(msg)
	end
	
 	-- OPEN CHANNERLS (ABRIR CHANNELS)
	if table.contains({"Rookgaard", "Dawnport"}, player:getTown():getName())then
		--player:openChannel(7) -- help channel
		player:openChannel(3) -- world chat
		player:openChannel(6) -- advertsing rook main
		else
		--player:openChannel(7) -- help channel
		player:openChannel(3) -- world chat
		player:openChannel(5) -- advertsing main
	end
	
	--
    -- Rewards
    local rewards = #player:getRewardList()
    if(rewards > 0) then
        player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You have %d %s in your reward chest.", rewards, rewards > 1 and "rewards" or "reward"))
	end
	
	-- dar a regen boost gratis
	local tempo = 60 * 60 * 24 * 7
			
	local check = player:getStorageValue(25896)
	local regentime = check - os.time()
	if regentime > 0 then
	--setPlayerStorageValue(player, 25896, os.time()+tempo+regentime)
	else
	
	setPlayerStorageValue(player, 25896, os.time()+tempo)
	end
	
	--end of free regen boost
	
	
	
	
	local check = player:getStorageValue(25896)
	local regentime = check - os.time()
	if regentime > 0 then
	local horas = math.floor(regentime/3600)
    local minutos = math.floor((regentime - (horas * 3600))/60)
		player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Voce tem ".. horas .." horas e ".. minutos .." minutos restantes de regeneration boost"))
	end
	
	
    -- Update player id
    local stats = player:inBossFight()
    if stats then
        stats.playerId = player:getId()
	end
	
	--player:sendTextMessage(messageType or MESSAGE_STATUS_CONSOLE_ORANGE, '[SITE] http://honera.com.br/')
	--player:sendTextMessage(messageType or MESSAGE_STATUS_CONSOLE_ORANGE, '[DONATE] PagSeguro, PayPal, Picpay, NuBank, Santander e Caixa, acima de R$ 20,00 e receba 2x em coins imediatamente.')
	--player:sendTextMessage(messageType or MESSAGE_STATUS_CONSOLE_ORANGE, '[DONATE] PagSeguro, PayPal, Picpay, NuBank, Santander e Caixa, acima de R$ 100,00 e receba 3x em coins imediatamente.')
	player:sendTextMessage(messageType or MESSAGE_STATUS_CONSOLE_ORANGE, '[STAMINA] Ataque nossos Treiners Online e receba 1 de Stamina a cada 2 minuto.')
	
    -- Events
    for i = 1, #events do
        player:registerEvent(events[i])
		player:registerEvent("tasksystem")
	end
	player:registerEvent("autolootkill")
	
	
 	if player:getStorageValue(Storage.combatProtectionStorage) < 1 then
        player:setStorageValue(Storage.combatProtectionStorage, 1)
        onMovementRemoveProtection(playerId, player:getPosition(), 10)
	end
	
	if player:getClient().version > 1110 then
		local worldTime = getWorldTime()
		local hours = math.floor(worldTime / 60)
		local minutes = worldTime % 60
		player:sendTibiaTime(hours, minutes)
	end
	
	-- check de ip
	if player:getIp() == 0 then
		local title = "OH NO!"
		local message = "?_?\n\nPossuimos diversos sistemas que fazem o check de ip, como a recompensa por tempo online, alem da check de limite de players por ip, porem seu ip retornou 0. \nEnquanto o ip estiver inválido vc nao poderá ganhar os beneficios. Por favor verifique suas configurações de proxy."  
		local window = ModalWindow(1952, title, message)
		window:addButton(100, "Confirm")
		window:setDefaultEnterButton(100)
		window:sendToPlayer(player)
		-- check de ip
	end
	
	
	
	
    return true
end
