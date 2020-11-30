function onSay(player, words, param)
	player:registerEvent('sellModal')

	local title = "Sell"
	local message = "Welcome to Sell System"
	
	local window = ModalWindow(401, title, message)
	
	
	
	
	window:addButton(101, "Ok")
	
	window:sendToPlayer(player)
	
	return false
end
