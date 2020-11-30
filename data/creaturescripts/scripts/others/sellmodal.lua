function onModalWindow(player, modalWindowId, buttonId, choiceId)
	local title, message = "Sell System", "Sell System Message"
	local window = ModalWindow(401, title, message)
	if buttonId == 100 then
		player:unregisterEvent('sellModal')
		return true
	end
	
	local sellitems = {
		[1] = {item = 2160, valor = 1},
		[2] = {item = 2159, valor = 1}
	}
	
	if buttonId == 101 and choiceId >= 1 and choiceId < 255 then
		if player:removeItem(sellitems[choiceId].item, 1) then
			--doPlayerAddMoney(player, sellitems[choiceId].valor)
			player:addItem(25377, sellitems[choiceId].valor)
		end
		
	end
		
	for i = 1, #sellitems do
		local itemid = sellitems[i].item
		local valor = sellitems[i].valor
		if player:getItemCount(itemid) >= 1 then
		local str = string.gsub(" "..ItemType(itemid):getName(), "%W%l", string.upper):sub(2)
			window:addChoice(i, ""..str..", "..valor.."")
		end
	end
	
	window:addButton(101, "Ok")
	window:addButton(100, "Cancelar")
	window:sendToPlayer(player)
	
end