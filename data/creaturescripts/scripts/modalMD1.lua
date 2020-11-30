local mounts = {
[1] = {name = "Tarantula", ID = 154}, 
[2] = {name = "Tortoise", ID = 172},
[3] = {name = "Toad", ID = 160},--
[4] = {name = "Baby Dragon Green", ID = 156},
[5] = {name = "River Crocovile", ID = 141},
    }
       
function onModalWindow(player, modalWindowId, buttonId, choiceId)
    player:unregisterEvent("modalMD1")
 
    if modalWindowId == 1001 then
        if buttonId == 100 then
                        if player:getItemCount(13167) == 0 then
                                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must have a Mount Doll in your backpack!")
                        return false
                        end
            if choiceId == 0 then
                return false
            end
            player:removeItem(13167, 1)
            player:addMount(mounts[choiceId].ID)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
        end
    end
end