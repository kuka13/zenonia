function onRaid()
	local monster = Game.createMonster("A Monga", Position(32952, 32698, 7))
	if monster then
		monster:setReward(true)
	end
end
