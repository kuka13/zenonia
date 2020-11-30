-- Default jail time in seconds -- 
default_jail = 600 
-- The permission you need to jail someone -- 
grouprequired = 4
-- StorageValue that the player gets -- 
jailedstoragevalue_time = 1338 
jailedstoragevalue_bool = 1339 
-- Set the position of the jail: -- 
jailpos = { x = 32326, y = 31976, z =7 }
-- Set the position once unjailed: -- 
unjailpos = { x = 32326, y = 31993, z =7 } 
-- auto kicker, dont edit 
jail_list = {} 
jail_list_work = 0 
 
function checkJailList(param)
addEvent(checkJailList, 1000, {})
for targetID,player in ipairs(jail_list) do
if isPlayer(player) == TRUE then
if getPlayerStorageValue(player, jailedstoragevalue_time) < os.time() then
doTeleportThing(player, unjailpos, TRUE)
setPlayerStorageValue(player, jailedstoragevalue_time, 0)
setPlayerStorageValue(player, jailedstoragevalue_bool, 0)
table.remove(jail_list,targetID)
doPlayerSendTextMessage(player,MESSAGE_STATUS_CONSOLE_ORANGE,'Voce foi chutado da prisao! Ate logo')
end
else
table.remove(jail_list,targetID)
end
end
end
 
function onSay(cid, words, param)
if jail_list_work == 0 then
jail_list_work = addEvent(checkJailList, 1000, {})
end
if param == '' and (words == '!unjail' or words == '/unjail') then
if getPlayerStorageValue(cid, jailedstoragevalue_time) > os.time() then
doPlayerSendTextMessage ( cid, MESSAGE_INFO_DESCR, 'Voce esta preso ate ' .. os.date("%H:%M:%S", getPlayerStorageValue(cid, jailedstoragevalue_time)) .. ' (Agora sao: ' .. os.date("%H:%M:%S", os.time()) .. ').')
else
if getPlayerStorageValue(cid, jailedstoragevalue_bool) == 1 then
table.insert(jail_list,cid)
doPlayerSendTextMessage ( cid, MESSAGE_INFO_DESCR, 'Voce vai ser expulso da prisao em um segundo.')
else
doPlayerSendTextMessage ( cid, MESSAGE_INFO_DESCR, 'Voce nao esta preso.')
end
end
return TRUE
end
local jail_time = -1
for word in string.gmatch(tostring(param), "(%w+)") do
if tostring(tonumber(word)) == word then
jail_time = tonumber(word)
end
end
local isplayer = getPlayerByName(param)
if isPlayer(isplayer) ~= TRUE then
isplayer = getPlayerByName(string.sub(param, string.len(jail_time)+1))
if isPlayer(isplayer) ~= TRUE then
isplayer = getPlayerByName(string.sub(param, string.len(jail_time)+2))
if isPlayer(isplayer) ~= TRUE then
isplayer = getPlayerByName(string.sub(param, string.len(jail_time)+3))
end
end
end
if jail_time ~= -1 then
jail_time = jail_time * 60
else
jail_time = default_jail
end
if words == '!jail' or words == '/jail' then
if getPlayerGroupId ( cid ) >= grouprequired then
if isPlayer(isplayer) == TRUE then
doTeleportThing(isplayer, jailpos, TRUE)
setPlayerStorageValue(isplayer, jailedstoragevalue_time, os.time()+jail_time)
setPlayerStorageValue(isplayer, jailedstoragevalue_bool, 1)
table.insert(jail_list,isplayer)
doPlayerSendTextMessage ( cid, MESSAGE_INFO_DESCR, 'Voce esta preso '.. getCreatureName(isplayer) ..' ate ' .. os.date("%H:%M:%S", getPlayerStorageValue(isplayer, jailedstoragevalue_time)) .. ' (Agora sao: ' .. os.date("%H:%M:%S", os.time()) .. ').')
doPlayerSendTextMessage ( isplayer, MESSAGE_INFO_DESCR, 'Voce foi preso por '.. getCreatureName(cid) ..' ate ' .. os.date("%H:%M:%S", getPlayerStorageValue(isplayer, jailedstoragevalue_time)) .. ' (Agora sao: ' .. os.date("%H:%M:%S", os.time()) .. ').')
return TRUE
else
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "O player com este nome nao existe ou esta offline.")
return FALSE
end
else
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce nao pode libertar outros jogadores.")
return FALSE
end
elseif words == '!unjail' or words == '/unjail' then
if getPlayerGroupId ( cid ) >= grouprequired then
if isPlayer(isplayer) == TRUE then
doTeleportThing(isplayer, unjailpos, TRUE)
setPlayerStorageValue(isplayer, jailedstoragevalue_time, 0)
setPlayerStorageValue(isplayer, jailedstoragevalue_bool, 0)
table.remove(jail_list,targetID)
doPlayerSendTextMessage(isplayer,MESSAGE_STATUS_CONSOLE_ORANGE,getCreatureName(cid) .. 'vou deixar voce sair da prisao!')
doPlayerSendTextMessage ( cid, MESSAGE_INFO_DESCR, 'Voce esta solto '.. getCreatureName(isplayer) ..'.')
else
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "O player com este nome nao existe ou está offline.")
return FALSE
end
else
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce não pode libertar outros jogadores.")
return FALSE
end
end
return FALSE
end 