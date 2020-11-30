function onSay(player, words, param)
    if player:getStorageValue(Storage.Exaust.tempo) >= os.time() then
	player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You are exhausted.')
	return true
    end
	
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Server Info:"
					.. "\nExp rate: " .. Game.getExperienceStage(player:getLevel())
					.. "\nSkill rate: " .. configManager.getNumber(configKeys.RATE_SKILL)
					.. "\nMagic rate: " .. configManager.getNumber(configKeys.RATE_MAGIC)
					.. "\nLoot rate: " .. configManager.getNumber(configKeys.RATE_LOOT))
	return false
end
