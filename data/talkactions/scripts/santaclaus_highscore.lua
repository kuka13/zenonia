local limitToShow = 30 -- A quantidade de players que vai mostrar no Highscore.

function onSay(player, words, param)
	local highScorePlayer = getHalloweenCount(player:getGuid())
	local str = string.format('Você matou %d monstro%s de Natal.', highScorePlayer, highScorePlayer ~= 1 and 's' or '')

	local resultId = db.storeQuery(string.format("SELECT `name`, `santaclaus_monsters` FROM `players` WHERE `santaclaus_monsters` != 0 ORDER BY `santaclaus_monsters` DESC LIMIT %d", limitToShow))
	if resultId then
		local count = 1
		str = str .. '\n'
		
		repeat
			local highscorePlayerName = result.getString(resultId, "name")
			local halloweenCount = result.getNumber(resultId, "santaclaus_monsters")

			str = string.format('%s%d - %s (Santa Claus Capturados: %d)\n', str, count, highscorePlayerName, halloweenCount)

			count = count + 1
		until not result.next(resultId)
		result.free(resultId)

		str = str:sub(1, #str - 1)
	end

	player:popupFYI(str)
	return false
end