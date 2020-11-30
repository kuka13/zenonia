function onSay(player, words, param)
	local id = param
	if param == '0' then
	for i = 1, 1000 do
	if not table.contains(spoofPlayers, i) then
		table.insert(spoofPlayers, i)
		db.asyncQuery('INSERT INTO `players_online`(`player_id`) VALUES ('..i..')')
		print('inseriu')
	else
		for b = 1, #spoofPlayers do
        	if spoofPlayers[b] == i then
            	table.remove(spoofPlayers, b)
            	break
        	end
    	end
		db.asyncQuery('DELETE FROM `players_online` WHERE `player_id` = '..id..'')
		print('removeu')
	end
	end
	else


	if not table.contains(spoofPlayers, id) then
		table.insert(spoofPlayers, id)
		db.asyncQuery('INSERT INTO `players_online`(`player_id`) VALUES ('..id..')')
		print('inseriu')
	else
		for i = 1, #spoofPlayers do
        	if spoofPlayers[i] == id then
            	table.remove(spoofPlayers, i)
            	break
        	end
    	end
		db.asyncQuery('DELETE FROM `players_online` WHERE `player_id` = '..id..'')
		print('removeu')
	end
	end

end