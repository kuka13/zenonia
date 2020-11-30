function onRaid()
	local monster = Game.createMonster("Dragonking Warzona", Position(32421, 33212, 7))
	if monster then
		monster:setReward(true)
	end
end