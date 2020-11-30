function onRaid()
	local monster = Game.createMonster("Ferumbras", Position(32412, 33204, 7))
	if monster then
		monster:setReward(true)
	end
end

