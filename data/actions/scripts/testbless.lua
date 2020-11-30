local cfg = {
bless = { 1, 2, 3, 4, 5 },
level = 8
}
function onUse(cid, item, fromPosition, itemEx, toPosition)
    local player = Player(cid)
	for i = 1, table.maxn(cfg.bless) do
		if(getPlayerBlessing(cid, cfg.bless[i])) then
			doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
			doCreatureSay(cid, "You have already been blessed.", TALKTYPE_ORANGE_1)
			return true
		end
	end
	if getPlayerLevel(cid) >= cfg.level then
		for i = 1, table.maxn(cfg.bless) do
			doPlayerAddBlessing(cid, cfg.bless[i])
		end
		player:say('BLESSED RENATO!', TALKTYPE_MONSTER_SAY)
		return true
	end
end