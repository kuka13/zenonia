function onRaid()
	local monster = Game.createMonster("The Mutated Pumpkin", Position(33236, 32341, 7))
	if monster then
		monster:setReward(true)
	end
end
