

local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, -1)
setConditionParam(condition, CONDITION_PARAM_STAT_MAXHITPOINTS, 500)
setConditionParam(condition, CONDITION_PARAM_STAT_MAXMANAPOINTS, 500)
setConditionParam(condition, CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, 50)
setConditionParam(condition, CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, 50)
setConditionParam(condition, CONDITION_PARAM_STAT_CAPACITYPERCENT, 150)



function onEquip(cid, item, slot)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Now that you're using this item you'll receive a special bonus...")
doAddCondition(cid, condition)
doSendMagicEffect(getCreaturePos(cid), 10)
doPlayerAddMana(cid, getPlayerMaxMana(cid))
cid:addHealth(cid:getMaxHealth())
--doPlayerSetMaxCapacity(cid, cid:getCapacity())

return true
end


function onDeEquip(cid, item, slot)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You're no longer receiving the special bonus..")
doRemoveCondition(cid, CONDITION_ATTRIBUTES)
--doPlayerSetMaxCapacity(cid,cid:getCapacity())
return true
end