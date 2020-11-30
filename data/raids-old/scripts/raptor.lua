function onRaid()
	local monster = Game.createMonster("Raptor", Position(32419, 33200, 7))
	if monster then
		monster:setReward(true)
	end
end