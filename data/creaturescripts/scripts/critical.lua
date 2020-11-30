--Chance de Crítico Por Arma
    local critChance = {
        Sword   = 0.75,
        Axe     = 0.6,
        Club    = 0.5,
        Dist    = 0.75,
        Magic   = 0.75
    }
 
--Dano Crítico Por Arma
   
    local critDmg = {
        Sword   = 0.5,
        Axe     = 0.5,
        Club    = 0.5,
        Dist    = 0.5,
        Magic   = 0.5
    }
 
function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    attacker:say("DISTANCE", TALKTYPE_MONSTER_SAY)
	--Se é Campo ou Dano Por Tempo
	print('RELOU')
    if Tile(creature:getPosition()):hasFlag(TILESTATE_MAGICFIELD) == TRUE or attacker == nil then
        --return primaryDamage, primaryType, secondaryDamage, secondaryType  
    end
 
    --Não Funciona
    if not attacker:isPlayer() and not attacker:isMonster() then
    --    return primaryDamage, primaryType, secondaryDamage, secondaryType      
    end
 
    local pDam, pCap = 0, 0
    local dodge = false
   
    --Chance de Crítico dos Monstros
    if attacker:isMonster() and not creature:isMonster() then      
        if attacker:getSpeed() * 0.08 > math.random(100) then
            pDam = primaryDamage * 0.5
        end    
    end
 
    --Chance de Esquiva dos Monstros
    if creature:isMonster() and attacker:isPlayer() and primaryType ~= COMBAT_HEALING then
        if creature:getSpeed() * 0.08 > math.random(100) then
            dodge = true
            creature:say("DODGE".. pDam, TALKTYPE_MONSTER_SAY)
        end
    end
 
    --Chance de Crítico dos Jogadores Baseado na Arma [NÃO FUNCIONA]
    if attacker:isPlayer() then
        --A Chance de Crítico é Baseado na Arma, O Mesmo para o Dano
        if attacker:getWeaponType() == WEAPON_SWORD and math.random(100) <= attacker:getSkillLevel(SKILL_SWORD) * critChance.Sword then
			attacker:say("SWORD", TALKTYPE_MONSTER_SAY)
            pDam = ((attacker:getSkillLevel(SKILL_SWORD) * critDmg.Sword)       / 100) * primaryDamage     
        elseif attacker:getWeaponType() == WEAPON_AXE and math.random(100) <= attacker:getSkillLevel(SKILL_AXE) * critChance.Axe then
            pDam = ((attacker:getSkillLevel(SKILL_AXE) * critDmg.Axe)           / 100) * primaryDamage     
			attacker:say("AXE", TALKTYPE_MONSTER_SAY)
        elseif attacker:getWeaponType() == WEAPON_CLUB and math.random(100) <= attacker:getSkillLevel(SKILL_CLUB) * critChance.Club then
            pDam = ((attacker:getSkillLevel(SKILL_CLUB) * critDmg.Club)         / 100) * primaryDamage     
			attacker:say("CLUB", TALKTYPE_MONSTER_SAY)
        elseif attacker:getWeaponType() == WEAPON_DISTANCE and math.random(100) <= attacker:getSkillLevel(SKILL_DISTANCE) * critChance.Dist then
            pDam = ((attacker:getSkillLevel(SKILL_DISTANCE) * critDmg.Dist)     / 100) * primaryDamage     
			attacker:say("DISTANCE", TALKTYPE_MONSTER_SAY)
        elseif attacker:getWeaponType() == WEAPON_WAND and math.random(100) <= attacker:getMagicLevel(SKILL_MAGLEVEL) * critChance.Magic then
            pDam = ((attacker:getMagicLevel(SKILL_MAGLEVEL) * critDmg.Magic)    / 100) * primaryDamage
			attacker:say("WAND", TALKTYPE_MONSTER_SAY)
        end
    end
 
    --Chance de Esquiva dos Jogadores
    if creature:isPlayer() and primaryType ~= COMBAT_HEALING then
        --Pega a % Livre da CAP do Player
        pCap = getPlayerFreeCap(creature) / (creature:getCapacity() / 100)
 
        --O Cálculo é Baseado na Velocidade e na Capicidade Livre do Player
        if ((creature:getSpeed() / 2) * 0.05) * (pCap * 1.5/1) > math.random(100)  then        
            dodge = true
            creature:say("Esquivou: -"..pDam.."DMG", TALKTYPE_MONSTER_SAY)
        end
    end
 
    --Se der Crítico Mostrar Mensagem
    if pDam ~= 0 then
        if origin == ORIGIN_RANGED then
            creature:say("Headshot!: +".. pDam .."DMG", TALKTYPE_MONSTER_SAY)
            creature:getPosition():sendMagicEffect(CONST_ME_EXPLOSIONAREA)        
        elseif origin == ORIGIN_MELEE then
            attacker:say("Critico!: +".. pDam .."DMG", TALKTYPE_MONSTER_SAY)
            creature:getPosition():sendMagicEffect(CONST_ME_HITAREA)
        elseif origin == ORIGIN_SPELL then
            if primaryType == 2 then
                    attacker:say("ELECTROCUTE!", TALKTYPE_MONSTER_SAY)
                elseif primaryType == 512 then
                    attacker:say("FREEZE!", TALKTYPE_MONSTER_SAY)
                elseif primaryType == 8 then
                    attacker:say("BURN!", TALKTYPE_MONSTER_SAY)
                elseif primaryType == 2048 then
                    attacker:say("EMBRACE!", TALKTYPE_MONSTER_SAY)
                elseif primaryType == 1024 then
                    attacker:say("PURIFY!", TALKTYPE_MONSTER_SAY)
                elseif primaryType == 128 then
                    attacker:say("REVIVE!", TALKTYPE_MONSTER_SAY)
                elseif primaryType == 1 then
                    attacker:say("CRITICAL!", TALKTYPE_MONSTER_SAY)
                elseif primaryType == 4 then
                    attacker:say("THORN!", TALKTYPE_MONSTER_SAY)
            end
        end
    end
 
    --Se Esquivado
    if dodge then
        return primaryDamage - primaryDamage, primaryType, secondaryDamage - secondaryDamage, secondaryType
    else
        --Se Acertar Crítico
        if pDam ~= 0 then
            if attacker:isPlayer() then
                attacker:sendTextMessage((MESSAGE_DAMAGE_DEALT), "Critical Hit: +".. pDam .." DMG")
                return primaryDamage + pDam, primaryType, secondaryDamage, secondaryType
            else
                attacker:say("Crit: ".. pDam, TALKTYPE_MONSTER_SAY)
                return primaryDamage + pDam, primaryType, secondaryDamage, secondaryType
            end
        end
       
        --Dano Normal
        return primaryDamage, primaryType, secondaryDamage, secondaryType      
    end
   
end