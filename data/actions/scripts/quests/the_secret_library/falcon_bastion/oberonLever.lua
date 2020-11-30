local bossName = "grand master oberon"


function onUse(player, item, fromPosition, itemEx, toPosition)
	local convertTable = {}
	Game.setStorageValue(GlobalStorage.secretLibrary.FalconBastion.oberonTimer, 0)

	if item:getId() == 1945 then -- Last boss room!
			if Game.getStorageValue(GlobalStorage.secretLibrary.FalconBastion.oberonTimer) >= 1 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait a while, recently someone challenged " .. bossName .. ".")
				return true
			end
			local teleport = 0
			for i = 33358, 33362, 1 do
				local newpos = Position(i, 31342, 9)
				local nplayer = Tile(newpos):getTopCreature()
				if nplayer and nplayer:isPlayer() then
					teleport = teleport + 1
				end
			end

			local fromPosition_ = Position(33356, 31311, 9) -- Checagem
			local toPosition_ = Position(33376, 31328, 9) -- Checagem
			local exitPosition = Position(33297, 31286, 9)
			
			if(isPlayerInArea(fromPosition_, toPosition_)) then
				player:sendCancelMessage('It looks like there is someone inside.')
				return true
			end

			for _x= fromPosition_.x, toPosition_.x, 1 do
				for _y= fromPosition_.y, toPosition_.y, 1 do
					for _z= fromPosition_.z, toPosition_.z, 1 do
						local tile = Tile(Position(_x, _y, _z))
						if (tile and tile:getTopCreature()) and (tile:getTopCreature():isMonster() or tile:getTopCreature():isNpc()) then
							tile:getTopCreature():remove()
						end
					end
				end
			end
			
			for i = 33358, 33362, 1 do
				local newpos = Position(i, 31342, 9)
				local nplayer = Tile(newpos):getTopCreature()
				if nplayer and nplayer:isPlayer() then
					nplayer:teleportTo(Position(33365, 31323, 9), true)
					convertTable[#convertTable + 1] = nplayer:getId()
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				end
			end
		local oberon = Game.createMonster("Grand Master Oberon", Position(33365, 31318, 9))
		if oberon then
			oberon:setStorageValue(Storage.secretLibrary.FalconBastion.oberonHeal, 0)
		end
		Game.setStorageValue(GlobalStorage.secretLibrary.FalconBastion.oberonSay, - 1)
		Game.createNpc("Oberon's Spite", Position(33363, 31321, 9))
		Game.createNpc("Oberon's Ire", Position(33368, 31321, 9))
		Game.createNpc("Oberon's Bile", Position(33363, 31317, 9))
		Game.createNpc("Oberon's Hate", Position(33368, 31317, 9))
		Game.setStorageValue(globalTimer, 1)
		addEvent(clearForgotten, 30 * 60 * 1000, fromPosition_, toPosition_, exitPosition, globalTimer)
	end	
	
	
	return true
end