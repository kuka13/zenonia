local spawns = {
    [1]  = {position = Position(33339,31914,9), monster = 'Mad Mage'},
}
 
 function onThink(interval, lastExecution)
    local spawn = spawns[math.random(#spawns)]
    local monster = 
   Game.createMonster(spawn.monster, spawn.position, true, true)
	 monster:setReward(true)
	 
    if not monster then
        print('>> Failed to spawn '..rand.bossName..'.')
        return true
    end
  return true
end