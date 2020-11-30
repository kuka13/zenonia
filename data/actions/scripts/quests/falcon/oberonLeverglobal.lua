local function clearOberon()
	local spectators = Game.getSpectators(Position(33564, 31474, 8), false, false, 10, 10, 10, 10)
	for i = 1, #spectators do
		local spectator = spectators[i]
		if spectator:isMonster() then
			spectator:remove()
		end
	end
end	

local BOSSca = "Grand Master Oberon" -- boss name
local BOSS_POSca = {x = 33563, y = 31470, z = 8} -- boss spawn

local roomca = {fromx = 33554, tox = 33571, fromy = 31467, toy = 31482, z = 8} -- boss room 
 
local function isPlayerInArea(fromPos, toPos)
    for _x = fromPos.x, toPos.x do
        for _y = fromPos.y, toPos.y do
            for _z = fromPos.z, toPos.z do
                creatureca = getTopCreature({x = _x, y = _y, z = _z})
                    if (isPlayer(creatureca.uid)) then
                    return true
                end
            end
        end
    end
    return false
end


function AddBossca()

local bossca = 0
for x = roomca.fromx, roomca.tox do
for y = roomca.fromy, roomca.toy do
for z = roomca.z, roomca.z do

creatureca = {x = x, y = y, z = z}
mobca = getTopCreature(creatureca).uid

    if getCreatureName(mobca) == BOSSca then
        bossca = 1
    end
end
end
end

if bossca == 1 then
end

if bossca == 0 then
		local monster = Game.createMonster("Grand Master Oberon", Position(33563, 31470, 8))
        --monster:setReward(true)		
end

return true
end


function onUse(cid, item, fromPosition, itemEx) 
	local player = Player(cid)
	if not player then
		return true
	end
	if(getStorageValue(40003) < 1) then	
        if item.itemid == 1945 then 
	        if player:getStorageValue(1) and not isPlayerInArea({x = 33554, y = 31467, z = 8, stackpos = 100}, {x = 33571, y = 31482, z = 8, stackpos = 100}) then
				pos1ca = {x = 33556, y = 31497, z = 8}
				pos2ca = {x = 33557, y = 31497, z = 8}
				pos3ca = {x = 33558, y = 31497, z = 8}
				pos4ca = {x = 33559, y = 31497, z = 8}
				pos5ca = {x = 33560, y = 31497, z = 8}
				
				doTeleportThing(getTopCreature(pos1ca).uid, {x = 33558, y = 31479, z = 8})
				doTeleportThing(getTopCreature(pos2ca).uid, {x = 33558, y = 31479, z = 8})
				doTeleportThing(getTopCreature(pos3ca).uid, {x = 33558, y = 31479, z = 8})
				doTeleportThing(getTopCreature(pos4ca).uid, {x = 33558, y = 31479, z = 8})
				doTeleportThing(getTopCreature(pos5ca).uid, {x = 33558, y = 31479, z = 8})
					
				clearOberon()
				player:setStorageValue(40003, 1)
				Game.createMonster("Grand Master Oberon", Position(33563, 31470, 8))
				addEvent(player:setStorageValue, 360*60*1000, 40003, 0) 
	else doPlayerSendTextMessage(cid,19,"There are players inside the room or is missing players here.")
end

end
else 
doPlayerSendCancel(cid, "You've fight this boss in the last 6 hours, please wait!")
end
	return true
end