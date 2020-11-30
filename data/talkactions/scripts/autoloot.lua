function onSay(player, words, param)	
	local lootlist, sum = player:getAutoLootList(), 1
	if lootlist then
		player:registerEvent('autoloot')
		local title = "Autoloot Helper!"
		local message = "Welcome do Autoloot Manager."
		local window = ModalWindow(1000, title, message)
				
		window:addButton(199, "Ok")
		window:sendToPlayer(player)
		return true		
    else
        player:sendCancelMessage("The list is empty.")
        return false
    end	
end