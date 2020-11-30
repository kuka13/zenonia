function onSay(player, words, param)
   if player:getStorageValue(25799) < 0 then
	player:setStorageValue(25799, 0)
	end
	if player:getStorageValue(25798) < 0 then
	player:setStorageValue(25798, 0)
	end
   
   --player:setStorageValue(25799, player:getStorageValue(25799) + 5)
   
    local title = "Online Points!"
	local points = player:getStorageValue(25799)
	local horas = player:getStorageValue(25798)
    local message = "Aqui voce podera ver a soma dos seus pontos! \n\n\n\nTotal de horas online: "..horas.."\nPontos acumulados:"..points..""
	
  
    local window = ModalWindow(1929, title, message)

    --window:addButton(100, "Confirm")
    window:addButton(101, "OK")
  
   
  
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
  
    window:sendToPlayer(player)
    return true
end
