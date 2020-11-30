function onKill(player, target)
    if not target:isMonster() then
        return true
	end
	
	local attackMonster = MonsterType(getCreatureName(target))
	local rate = Game.getExperienceStage(player:getLevel())
	local xp = attackMonster:getExperience() * rate
	
	print(xp)
	return true
end
