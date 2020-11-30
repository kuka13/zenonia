function onRaid()
	local monster = Game.createMonster("Feroxa", Position(33401, 31474, 11))  -- 33389" y="31539" z="11"
	if monster then
		monster:setReward(true)
	end
end