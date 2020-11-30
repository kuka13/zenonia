function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:hasMount(152) then
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You already have this mount.")
        return true
    end

    player:addMount(152) -- Id da Mount
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    player:say('You received Gloom Wolf.', TALKTYPE_ORANGE_1)
    return true
end