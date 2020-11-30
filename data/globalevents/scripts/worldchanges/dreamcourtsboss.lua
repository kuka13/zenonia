local config = {
	['Monday'] = 'Alptramun',
	['Tuesday'] = 'Izcandar the Banished',
	['Wednesday'] = 'Malofur Mangrinder',
	['Thursday'] = 'Maxxenius',
	['Friday'] = 'Izcandar the Banished',
	['Saturday'] = 'Plagueroot', 
	['Sunday'] = 'Maxxenius' 
} 

 
local spawnByDay = true

function onStartup()

	if spawnByDay then
		 print('>> Dream Courts Boss:' .. config[os.date("%A")])
	 	Game.loadMap('data/world/dream courts bosses/' .. config[os.date("%A")] ..'.otbm')
 		
else
		 print('>> Dream Courts Boss: not boss today')
end
return true
end
