local config = {
    monsterName = 'The Scourge Of Oblivion',
    bossPosition = Position(32467, 32367, 15),
    centerPosition = Position(32470, 32372, 15),
    rangeX = 25,
    rangeY = 25
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
	
 
 
	-- addEvent(Game.broadcastMessage, 150, 'Beware! Mawhawk!', MESSAGE_EVENT_ADVANCE)
 
 
    local boss =
		
	Game.createMonster(config.monsterName, config.bossPosition, true, true)
    boss:setReward(true)
    return true
end 