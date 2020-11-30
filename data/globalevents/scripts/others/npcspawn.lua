local function _spawnNPCs()
  for i = 1,#mapNpcs do
    local npc = mapNpcs[i]

    if npc and npc.name and npc.pos then
		local spawn = Game.createNpc(npc.name, npc.pos)
		if spawn then
			spawn:setMasterPos(npc.pos)
		end
    end
  end
 -- Game.createNpc('Testserver Assistant', Position(32371, 32231, 7))
  
  --print(os.date("today is %A, in %B"))
  --%w - dia da semana por números [0-6 = Domigo-Sabado]
 
 -- if os.date("%w") == '6' then
  print('SABADOU!! NPC HONERA CRIADO')
  Game.createNpc('Honera', Position(32359, 32233, 7))
  --else
   --print('nao criei o npc')
  --end
  
  
  return true
end

function onStartup()
    addEvent(_spawnNPCs, 1 * 1000)
    print('Advanced NPC spawn system | All NPCs will be loaded trough lib.')
    return true
end
--https://github.com/opentibiabr/OTServBR-Global
