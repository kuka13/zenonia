function onRaid()
	local monster = Game.createMonster("Drogon", Position(32419, 33200, 7))
	if monster then
		monster:setReward(true)
	end
end