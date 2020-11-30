function onRaid()
	local monster = Game.createMonster("Kharsek", "Cachero", Position(31160, 32909, 8))
	
	if monster then
		monster:setReward(true)
	end
end