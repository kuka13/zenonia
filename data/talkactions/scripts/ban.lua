function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    local split = param:split(",")
    if not split[4] then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Utilize /ban type(days/hours),nome,tempo,motivo.')
        return false
    end

    local banType = split[1]:trim()
    local name = split[2]:trim()
    local time = split[3]:trim()
    local reason = split[4]:trim()

    local accountId = getAccountNumberByPlayerName(name)
    if accountId == 0 then
        return false
    end
   
    time = tonumber(time)
    if not time then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O tempo precisam estar em números.")
        return false
    end
    
	local target = Player(name)
	local targetName = nil
	if not target then
		local resultId = db.storeQuery("SELECT `name`, `lastip` FROM `players` WHERE `name` = " .. db.escapeString(name) .. " AND `group_id` < " .. player:getGroup():getId())
		if not resultId then
			player:sendCancelMessage("This player doesn't exist.")
			return false
		end

		targetName = result.getString(resultId, "name")
		result.free(resultId)
	else  
		if target:getGroup():getAccess() then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você não pode banir banir um membro da Staff.")
			return false
		end

		targetName = target:getName()
	end

    local resultId = db.storeQuery("SELECT 1 FROM `account_bans` WHERE `account_id` = " .. accountId)
    if resultId then
        result.free(resultId)
        return false
    end

    if not banType:lower() == 'hours' or not banType:lower() == 'days' then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "As opções de banimento são apenas entre 'hours' e 'days'.")
        return false
    end

    local timeNow = os.time()
    local banTime
    if banType:lower() == 'hours' then
        banTime = time * 60
    elseif banType:lower() == 'days' then
        banTime = time * 86400
    end    
    
    db.query("INSERT INTO `account_bans` (`account_id`, `reason`, `banned_at`, `expires_at`, `banned_by`) VALUES (" .. accountId .. ", " .. db.escapeString(reason) .. ", " .. timeNow .. ", " .. timeNow + banTime .. ", " .. player:getGuid() .. ")")
	db.query(string.format('INSERT INTO `bans` (`account_id`, `player`, `reason`, `banned_at`, `expires_at`, `banned_by`) VALUES (%d, %s, %s, %d, %d, %s)', accountId, db.escapeString(targetName), db.escapeString(reason), timeNow, timeNow + banTime, db.escapeString(player:getName())))
    
    if target then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, targetName .. " has been banned.")
        target:remove()
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, name .. " has been banned.")
    end
    
    return false
end