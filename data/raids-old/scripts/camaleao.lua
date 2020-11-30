function onRaid()
	local monster = Game.createMonster("Camaleao", Position(32289, 33204, 7))
	if monster then
		monster:setReward(true)
	end
end