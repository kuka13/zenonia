function onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	
	for attackerUid, damage in pairs(creature:getDamageMap()) do
        local player = Creature(attackerUid)
        if player then
            local playerKiller = nil
            if player:isPlayer() then
                playerKiller = player
            elseif player:getMaster() then
                playerKiller = player:getMaster()
            end
            if playerKiller and playerKiller:isPlayer() then
                --playerKiller:teleportTo(posFinal)
				playerKiller:sendTextMessage(MESSAGE_STATUS_DEFAULT, "Matou o HotWorm")
				
				if playerKiller:hasMount(170) then
					playerKiller:getPosition():sendMagicEffect(CONST_ME_POFF)
					playerKiller:sendTextMessage(MESSAGE_INFO_DESCR, "You already have this mount.")
				end

				playerKiller:addMount(170) -- Id da Mount
				playerKiller:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				playerKiller:say('You received Rotworm.', TALKTYPE_ORANGE_1)
    				
            end
        end
    end   
	
	targetMonster:unregisterEvent("hotwormDeath")
	
	return true
end