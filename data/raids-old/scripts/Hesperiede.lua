function onRaid()
	local monster = Game.createMonster("Hesperiede", Position(32321, 32482, 7))
	if monster then
		monster:setReward(true)
	end
end