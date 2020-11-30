function getCost(level)
	if level <= 30 then
		return 2000*5
	elseif level >= 120 then
		return 10000*5
	else
		return ((level - 20) * 200 * 5) 
	end
end

function onSay(cid, words, param)
	local p = Player(cid)
	local cost = getCost(getPlayerLevel(cid))
	if(not(isPlayerPzLocked(cid))) then
		if(p:hasBlessing(1) and p:hasBlessing(2) and p:hasBlessing(3) and p:hasBlessing(4) and p:hasBlessing(5) and p:hasBlessing(6) and p:hasBlessing(7) and p:hasBlessing(8) and p:hasBlessing(9)) then
			p:sendCancelMessage("You have already been blessed by the gods.")
			return false
		end		
		--if(p:removeMoneyNpc(cost)) then
		if true then
			p:addBlessing(1, 1)
			p:addBlessing(2, 1)
			p:addBlessing(3, 1)
			p:addBlessing(4, 1)
			p:addBlessing(5, 1)
			p:addBlessing(6, 1)
			p:addBlessing(7, 1)
			p:addBlessing(8, 1)
			p:addBlessing(9, 1)
			p:getPosition():sendMagicEffect(50)
			p:sendTextMessage(19, "You have been blessed by the gods!")
		else
			p:sendCancelMessage("You need "..cost.." gold coins to buy all blessings.")
		end
	else
		p:sendCancelMessage("You can't buy bless, when you are in a battle.")
	end
return false
end
