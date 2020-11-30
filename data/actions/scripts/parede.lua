function onUse(cid, item, fromPosition, itemEx, toPosition)
local p = {x = 31514, y = 31095, z = 13} -- where to tp to 33672, 31884, 5
if(getPlayerStorageValue(cid, 10050) < 90) then
	doTeleportThing(cid,p)	
	doSendMagicEffect(p,10)
	return true
end

end