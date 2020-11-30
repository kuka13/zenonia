function onRaid()
	local monster = Game.createMonster("Papai Cerberus", Position(32419, 33200, 7))
	if monster then
		monster:setReward(true)
	end
end