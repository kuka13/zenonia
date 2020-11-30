local mounts = {
[1] = {name = "Tarantula", ID = 154}, 
[2] = {name = "Tortoise", ID = 172},
[3] = {name = "Toad", ID = 160},--
[4] = {name = "Baby Dragon Green", ID = 156},
[5] = {name = "River Crocovile", ID = 141},
    }
	
function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    player:registerEvent("modalMD1")

    local title = "Accept your mount!"
    local message = "You will receive a new mount!"

    local window = ModalWindow(1001, title, message)
	if player:getItemCount(13167) >= 1 then
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