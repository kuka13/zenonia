function onRaid()
	local monster = Game.createMonster("Magic Butterfly", Position(32408, 33204, 7))
	if monster then
		monster:setReward(true)
	end
end