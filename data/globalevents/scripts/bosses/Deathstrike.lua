local config = {
    monsterName = 'Deathstrike',
    bossPosition = Position(33100, 31966, 10),
    centerPosition = Position(33107, 31964, 10),
    rangeX = 150,
    rangeY = 150
}
 
local function checkBoss(centerPosition, rangeX, rangeY, bossName)
    local spectators, spec = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
    for i = 1, #spectators do
        spec = spectators[i]
        if spec:isMonster() then
            if spec:getName() == bossName then
                return true
            end
        end
    end
    return false
end
 function onThink(interval, lastExecution)
    if checkBoss(config.centerPosition, config.rangeX, config.rangeY, config.monsterName) then
        return true
    end
 
    local boss =
	Game.createMonster(config.monsterName, config.bossPosition, true, true)
    boss:setReward(true)
    return true
end