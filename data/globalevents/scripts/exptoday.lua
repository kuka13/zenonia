function onStartup()
	print('[POWERGAMERS]')
	db.query("UPDATE `player_storage` SET  `value` = 0 WHERE `key` = 25897")
	--Criar a tabela
	INIxpDiariaID, INIxpDiariaXP = {}, {}
	
	local registros = db.storeQuery("SELECT `id`, `experience` FROM `players`")
	
    if registros ~= false then
	    local count = 0
	    repeat
            count = count + 1
			local id = result.getNumber(registros, "id")
			table.insert(INIxpDiariaID, id)
			local xp = result.getNumber(registros, "experience")
            --print('Inicializaçao F1 '..id..', '..xp..'')
			table.insert(INIxpDiariaXP, xp)
		until not result.next(registros)
        result.free(registros)
	end
	--ideia >>> Fazer um select na experiencia de todos os players...Guardar esse valor em uma tabela...Após X minutos fazer um novo select e comparar com o anterior. Resultados maiores ordenarão o rank
end

function onThink(interval)
	--Calcular a xp ganha, Geraremos a xp dos players, e compareremos com a anterior, Atualizar a experiencia dos players ONLINE que tem um valor > de experiencia do que o check inicial e <> do que está no banco de dados. Comparar usando a memoria ram Table
	xpDiariaID, xpDiariaXP = {}, {}	
	local registros = db.storeQuery("SELECT `id`, `experience` FROM `players`")
    if registros ~= false then
	    local count = 0
	    repeat
            count = count + 1
			local id = result.getNumber(registros, "id")
			local xp = result.getNumber(registros, "experience")
            if Player(id) then
				--print('achei player on, pegar a exp da source')
				local ptemp = Player(id)
				xp = ptemp:getExperience()
			end
			--print('inserindo nas tabelas F1 '..id..', '..xp..'')
			table.insert(xpDiariaID, id)
			table.insert(xpDiariaXP, xp)
		until not result.next(registros)
        result.free(registros)
	end
	for i = 1 , #xpDiariaID do
		if not INIxpDiariaID[i] then
			table.insert(INIxpDiariaID, xpDiariaID[i])
			table.insert(INIxpDiariaXP, 0)
		end
		if xpDiariaXP[i] - INIxpDiariaXP[i] > 0 then
			if Player(INIxpDiariaID[i]) then --se o player estiver online usar a funcao de storage, senao query
				local playernew = Player(INIxpDiariaID[i])
				--print('achei player on, atualizar a storage')
				playernew:setStorageValue(25897, xpDiariaXP[i] - INIxpDiariaXP[i])
			else
				local Query = db.storeQuery("SELECT `value` FROM `player_storage` WHERE `player_id` = ".. INIxpDiariaID[i] .." AND `key` = ".. 25897)
				if Query ~= false then
					local xp2 = result.getNumber(Query, "value")
					if xpDiariaXP[i] - INIxpDiariaXP[i] > xp2 then
						--print('Update BD 2 ', INIxpDiariaID[i], xpDiariaXP[i] - INIxpDiariaXP[i])
						db.query("UPDATE `player_storage` SET  `value` = "..xpDiariaXP[i] - INIxpDiariaXP[i].." WHERE `player_id` = ".. INIxpDiariaID[i] .." AND `key` = "..25897)
					end
					else
					db.query("INSERT INTO `player_storage` (`player_id`, `key`, `value`) VALUES (" .. INIxpDiariaID[i] .. ", " .. 25897 .. ", " .. xpDiariaXP[i] - INIxpDiariaXP[i] .. ");")
				end
				result.free(Query)
			end
		end
	end
	return true
end

function onTime(interval)
	--Zerar o rank, atualizar a xp inicial do dia
	db.query("UPDATE `player_storage` SET  `value` = 0 WHERE `key` = 25897")
	INIxpDiariaID, INIxpDiariaXP = {}, {}
	local registros = db.storeQuery("SELECT `id`, `experience` FROM `players`")
    if registros ~= false then
	    local count = 0
	    repeat
            count = count + 1
			local id = result.getNumber(registros, "id")
			table.insert(INIxpDiariaID, id)
			local xp = result.getNumber(registros, "experience")
			table.insert(INIxpDiariaXP, xp)
		until not result.next(registros)
        result.free(registros)
	end
end