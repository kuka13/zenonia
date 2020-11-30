local config = {
    -- west entrance
    [5030] = { sacrificePosition = Position(31515, 31092, 13), pushPosition = Position(31514, 31089, 13), destination = Position(31514, 31094, 13) },
    --east entrance
    [5031] = { sacrificePosition = Position(31514, 31119, 13), pushPosition = Position(31514, 31094, 13), destination = Position(31536, 31122, 13) }
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
    if not isInArray({27605}, sacrificeId) then
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
