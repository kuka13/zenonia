local config = {
    -- west entrance
    [5090] = { sacrificePosition = Position(32314, 31932, 6), pushPosition = Position(32315, 31932, 6), destination = Position(32318, 31929, 5) },
    --east entrance
    [5091] = { sacrificePosition = Position(32314, 31932, 6), pushPosition = Position(32315, 31932, 6), destination = Position(32318, 31929, 5) },
}

function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local flame = config[item.actionid]
    if not flame then
        return true
    end

    local sacrificeId, sacrifice = Tile(flame.sacrificePosition):getThing(1).itemid, true
    if not isInArray({2160, 500}, sacrificeId) then
        sacrifice = false
    end

    if not sacrifice then
        player:teleportTo(flame.pushPosition)
        position:sendMagicEffect(CONST_ME_ENERGYHIT)
        flame.pushPosition:sendMagicEffect(CONST_ME_ENERGYHIT)
        return true
    end

    local soilItem = Tile(flame.sacrificePosition):getItemById(sacrificeId)
    if soilItem then
        soilItem:remove()
    end

    player:teleportTo(flame.destination)
    position:sendMagicEffect(CONST_ME_HITBYFIRE)
    flame.sacrificePosition:sendMagicEffect(CONST_ME_HITBYFIRE)
    flame.destination:sendMagicEffect(CONST_ME_HITBYFIRE)
    return true
end
