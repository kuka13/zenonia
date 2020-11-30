function onStartup()
	print('[STAMINA]')
	StaminaTreiner = {}
end


function onThink(interval)
		for i = 1, #StaminaTreiner do
		player = Player(StaminaTreiner[i])
		if player then
		player:setStamina(player:getStamina() + 1)
		
		else
		table.remove(StaminaTreiner, i)
		end
		
		
		
		end
	return true
end
