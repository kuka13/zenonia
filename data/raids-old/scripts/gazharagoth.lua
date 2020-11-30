function onRaid()
	local monster = Game.createMonster("Gaz'Haragoth", Position(33537, 32382, 12))
	if monster then
		monster:setReward(true)
	end
end
