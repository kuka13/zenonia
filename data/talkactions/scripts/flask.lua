function onSay(cid, words, param)
	local flask = cid:getStorageValue(250122)
	
	if flask < 1 then
	cid:setStorageValue(250122, 1)
	cid:sendTextMessage(MESSAGE_INFO_DESCR, "Flasks: [DISABLED]")
	else
	cid:setStorageValue(250122, -1)
	cid:sendTextMessage(MESSAGE_INFO_DESCR, "Flasks: [ENABLED]")
	end
	
	return false
end
