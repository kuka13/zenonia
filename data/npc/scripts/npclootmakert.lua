local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)             end
function onCreatureDisappear(cid)         npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)     npcHandler:onCreatureSay(cid, type, msg)     end
function onThink()                         npcHandler:onThink()                         end

local function onGreet_Callback(cid)
    local npc = Npc()
    local player = Player(cid)
    local tile = npc:getTile()
    local house = tile:getHouse()

    if house then
        local access_list = house:getAccessList(GUEST_LIST)
        if access_list and access_list:find(player:getName()) then
            npcHandler:setMessage(MESSAGE_GREET, "Hello!.")
        else
            npcHandler:say("I do not speak with strangers.", cid)
            npcHandler:releaseFocus(cid)
            npcHandler:resetNpc(cid)
            return false
        end
    end

    return true
end
--- versão inicial 
--- mudança nick ao fala 
--- mudança cor da roupa
--- otimização 
local function onSay_Callback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, onSay_Callback)
npcHandler:setCallback(CALLBACK_GREET, onGreet_Callback)
npcHandler:addModule(FocusModule:new())