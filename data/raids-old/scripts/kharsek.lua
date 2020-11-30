function onRaid()
	local monster = Game.createMonster("Kharsek", Position(32419, 33200, 7))
	if monster then
		monster:setReward(true)
	end
end