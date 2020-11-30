local mounts = {
    [1] = {name = "Cerberus", ID = 146},  
    }
	
function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    player:registerEvent("modalMD")

    local title = "Accept your mount!"
    local message = "You will receive a new mount!"

    local window = ModalWindow(1001, title, message)
	if player:getItemCount(10064) >= 1 then
		window:addButton(100, "Confirm")
		window:setDefaultEnterButton(100)
	else
		window:setDefaultEnterButton(101)
end
    window:addButton(101, "Cancel")
    window:setDefaultEscapeButton(101)
   
    for i = 1, #mounts do
		local o = mounts[i].name
		if not player:hasMount(mounts[i].ID) then
			window:addChoice(i, o)
		end
    end
	
	if window:getChoiceCount() == 0 then
        window:setMessage("You have this mount! You have been awarded the achievement and a custom mount!")
		--add achievement 
    end

    window:sendToPlayer(player)
    return true
end