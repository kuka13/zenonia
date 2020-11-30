function onRaid()
	local monster = Game.createMonster("Venom", Position(32419, 33200, 7))
	if monster then
		monster:setReward(true)
	end
end

