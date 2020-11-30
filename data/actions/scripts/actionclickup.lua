function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	if not player then
		return false
	end
	
	player:addExperience(1000, true)
	
	item:remove()
	return true
end
