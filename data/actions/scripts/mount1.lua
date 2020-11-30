function onUse(cid, item, fromPosition, itemEx, toPosition)

local effect = 30 -- efeito ao clicar no baú
local storage = 34530 
﻿
if(getPlayerStorageValue(cid, 34530) > 0) then
doPlayerSendTextMessage(cid, 25, "Você já recebeu sua mount.")
return TRUE
end﻿

doPlayerAddMount(cid, 13) -- Aqui é o ID da montaria, você pode encontrar em DATA/XML/mounts.xml.
doPlayerSendTextMessage(cid, 25, "Você ganhou uma nova mount.")
doSendMagicEffect(getPlayerPosition(cid), effect)
﻿
return TRUE
end﻿﻿﻿﻿﻿---- string of mending id "22542"-----
local Items = {
    [24718] = {
        ["sorcerer"] = 24783, ["master sorcerer"] = 24783,
        ["druid"] = 24784, ["elder druid"] = 24784,
        ["knight"] = 24785, ["elite knight"] = 24785,
        ["paladin"] = 24786, ["royal paladin"] = 24786
    },
    [24716] = 24790
}
 
function onUse(cid, item, fromPosition, itemEx, toPosition)
    local player = Player(cid)

    if (not player) then
        return false
    end

    local transformItem = Items[itemEx:getId()]
    if (not transformItem) then
        return false
    end

    if (type(transformItem) == 'table') then
        if (player:getVocation()) then
            local myItem = transformItem[player:getVocation():getName():lower()]
            if (myItem) then
                itemEx:transform(myItem, 1)
            end
        end
    else
        itemEx:transform(transformItem, 1)
    end

    itemEx:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    item:remove(1)
    return true
end