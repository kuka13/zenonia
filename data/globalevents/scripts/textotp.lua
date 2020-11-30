local effects = {
	{position = Position(32055, 31886, 6), text = 'Para liberar, fale com a npc ORESSA:\n(hi, choose, vocation)', effect = CONST_ME_TUTORIALARROW},
	{position = Position(32059, 31886, 6), text = 'Para liberar, fale com a npc ORESSA:\n(hi, choose, vocation)', effect = CONST_ME_TUTORIALARROW},
	{position = Position(32069, 31886, 6), text = 'Para liberar, fale com a npc ORESSA:\n(hi, choose, vocation)', effect = CONST_ME_TUTORIALARROW},
	{position = Position(32073, 31886, 6), text = 'Para liberar, fale com a npc ORESSA:\n(hi, choose, vocation)', effect = CONST_ME_TUTORIALARROW},
	--{position = Position(32405, 33211, 7), text = '', effect = CONST_ME_SKULLVERTICAL},
}

function onThink(interval)
	--print('loop aqui')
    for i = 1, #effects do
        local settings = effects[i]
        local spectators = Game.getSpectators(settings.position, false, true, 7, 7, 5, 5)
        if #spectators > 0 then
            if settings.text then
                for i = 1, #spectators do
                    spectators[i]:say(settings.text, TALKTYPE_MONSTER_SAY, false, spectators[i], settings.position)
                end
            end
            if settings.effect then
                settings.position:sendMagicEffect(settings.effect)
            end
        end
    end
   return true
end
 