function onRaid()
	local monster = Game.createMonster("Pantera Negra", Position(32399, 33203, 7))
	if monster then
		monster:setReward(true)
	end
end