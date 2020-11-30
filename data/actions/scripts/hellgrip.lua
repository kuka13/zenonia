function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:hasMount(39) then
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You already have this mount.")
        return true
    end

    player:addMount(39) -- Id da Mount
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    player:say('You received The Hellgrip.', TALKTYPE_ORANGE_1)
    return true
end