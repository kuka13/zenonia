function onSay(player, words, param)
	player:registerEvent('TutoForNoobs')

	tutorialStep, tutorialfromPos = {}, {} --MOVER PARA O INIT.LUA
	
	tutorialStep[player:getGuid()] = 0
	tutorialfromPos[player:getGuid()] = player:getPosition()
	
	local title = "Tutorial"
	local message = "Welcome to Tutorial System"
	
	local window = ModalWindow(301, title, message)
	window:addButton(101, "Ok")
	window:sendToPlayer(player)
	
	return false
end
