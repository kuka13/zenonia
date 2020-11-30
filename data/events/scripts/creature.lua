__picif = {}
function Creature:onChangeOutfit(outfit)
	return true
end

function checkCombat(creature, target)
    -- ID da vocação seguido dos monstros "amigos"
	print('funcao custom')

	if creature:isPlayer() and target:isPlayer() then
		--return RETURNVALUE_NOERROR
	end

	if not creature:isPlayer() and target:isPlayer() then
		if target:getStorageValue(250120) == 1 then
			print('check deathstor')
				return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
		end
	end

	

	--return RETURNVALUE_NOERROR
end

function Creature:onAreaCombat(tile, isAggressive)
	return true
end

-- Prey slots consumption
local function preyTimeLeft(player, slot)
	local timeLeft = player:getPreyTimeLeft(slot) / 60
	local monster = player:getPreyCurrentMonster(slot)
	if (timeLeft > 0) then
		local playerId = player:getId()
		local currentTime = os.time()
		local timePassed = currentTime - nextPreyTime[playerId][slot]
		if timePassed > 59 then
			timeLeft = timeLeft - 1
			nextPreyTime[playerId][slot] = currentTime + 60
			else
			timeLeft = 0
		end
		-- Expiring prey as there's no timeLeft
		if (timeLeft == 0) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Your %s's prey has expired.", monster:lower()))
			player:setPreyCurrentMonster(slot, "")
		end
		-- Setting new timeLeft
		player:setPreyTimeLeft(slot, timeLeft * 60)
		else
		-- Expiring prey as there's no timeLeft
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Your %s's prey has expired.", monster:lower()))
		player:setPreyCurrentMonster(slot, "")
	end
	return player:sendPreyData(slot)
end

local function removeCombatProtection(cid)
	local player = Player(cid)
	if not player then
		return true
	end
	
	local time = 0
	if player:isMage() then
		time = 10
		elseif player:isPaladin() then
		time = 20
		else
		time = 30
	end
	
	player:setStorageValue(Storage.combatProtectionStorage, 2)
	addEvent(function(cid)
		local player = Player(cid)
		if not player then
			return
		end
		
		player:setStorageValue(Storage.combatProtectionStorage, 0)
		player:remove()
	end, time * 1000, cid)
end

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

function Creature:onTargetCombat(target)
	
	if not self then
		return true
	end

	--[[

	if self:isMonster() then
		print('checkmaroto')
	checkCombat(self, target)
	end ]]

	--[[
	if self:isPlayer() then
		local aux = 1
		local weapontype
		local attacker = self
		local weapon = self:getSlotItem(CONST_SLOT_LEFT)
		if weapon then
			local ammo = self:getSlotItem(CONST_SLOT_AMMO)
			if ammo then
				local ammoid = ammo:getId()
				local ammotype = ItemType(ammoid)
				aux = ammotype:getAttack()
			end
			local weaponid = weapon:getId()
			weapontype = ItemType(weaponid)
			-- Bows and Crossbows
			-- aqui coloquei os ids que estavam em weapons.xml
			local bows = {2455,2456,34055,5803,8849,8850,8853,8852,8851,8857,8855,8856,8858,8854,13873,15643,15644,16111,18453,18454,21690,21696,22416,25983,25885,25943,25987,25886,25947,22417,22418,22419,22420,22421,25522,25523,30690,30691,32418}
			
			if table.contains(bows, weaponid) then --primeiro checar se e um bow
				if ammotype then
					aux = ammotype:getAttack()
				end
				else
				if weapontype:getWeaponType() == 6 then --senao for bow, ver se eh magic level
					aux = attacker:getMagicLevel(SKILL_MAGLEVEL)
					else --senao, e weapon, ou distance com ataque
					aux = weapontype:getAttack()
				end
			end
		end
		
		if weapon and attacker:isPlayer() and aux > 1 then
			local primaryDamage = math.random(1, aux)
			
			--A Chance de Crítico é Baseado na Arma, O Mesmo para o Dano
			--print(weapontype:getWeaponType())
			if weapontype:getWeaponType() == 1 and math.random(100) <= attacker:getSkillLevel(SKILL_SWORD) * critChance.Sword then
				pDam = ((attacker:getSkillLevel(SKILL_SWORD) * critDmg.Sword)       / 100) * primaryDamage
				pDam = math.max(1, pDam)
				attacker:say("SWORD +"..string.format("%.0f", pDam).."", TALKTYPE_MONSTER_SAY)
				elseif weapontype:getWeaponType() == 3 and math.random(100) <= attacker:getSkillLevel(SKILL_AXE) * critChance.Axe then
				pDam = ((attacker:getSkillLevel(SKILL_AXE) * critDmg.Axe)           / 100) * primaryDamage     
				pDam = math.max(1, pDam)
				attacker:say("AXE +"..string.format("%.0f", pDam).."", TALKTYPE_MONSTER_SAY)
				elseif weapontype:getWeaponType() == 2 and math.random(100) <= attacker:getSkillLevel(SKILL_CLUB) * critChance.Club then
				pDam = ((attacker:getSkillLevel(SKILL_CLUB) * critDmg.Club)         / 100) * primaryDamage     
				pDam = math.max(1, pDam)
				attacker:say("CLUB +"..string.format("%.0f", pDam).."", TALKTYPE_MONSTER_SAY)
				elseif weapontype:getWeaponType() == 5 and math.random(100) <= attacker:getSkillLevel(SKILL_DISTANCE) * critChance.Dist then
				pDam = ((attacker:getSkillLevel(SKILL_DISTANCE) * critDmg.Dist)     / 100) * primaryDamage    
				pDam = math.max(1, pDam)
				attacker:say("DISTANCE +"..string.format("%.0f", pDam).."", TALKTYPE_MONSTER_SAY)
				elseif weapontype:getWeaponType() == 6 and math.random(100) <= attacker:getMagicLevel(SKILL_MAGLEVEL) * critChance.Magic then
				pDam = ((attacker:getMagicLevel(SKILL_MAGLEVEL) * critDmg.Magic)    / 100) * primaryDamage
				pDam = math.max(1, pDam)
				attacker:say("ML +"..string.format("%.0f", pDam).."", TALKTYPE_MONSTER_SAY)
				elseif weapontype:getWeaponType() == 7 and math.random(100) <= attacker:getSkillLevel(SKILL_DISTANCE) * critChance.Dist then
				pDam = ((attacker:getSkillLevel(SKILL_DISTANCE) * critDmg.Dist)     / 100) * primaryDamage    
				pDam = math.max(1, pDam)
				attacker:say("DISTANCE +"..string.format("%.0f", pDam).."", TALKTYPE_MONSTER_SAY)
			end
			doTargetCombatHealth(0, target, COMBAT_PHYSICALDAMAGE, -pDam, -pDam, CONST_ME_NONE)
		end
	end
	]]
	if not __picif[target.uid] then
		if target:isMonster() then
			target:registerEvent("RewardSystemSlogan")
			__picif[target.uid] = {}
		end
	end
	
	
	if target:isPlayer() then
		if self:isMonster() then
			local protectionStorage = target:getStorageValue(Storage.combatProtectionStorage)
			
			
			if target:getIp() == 0  then -- If player is disconnected, monster shall ignore to attack the player
				if target:isPzLocked() then return true end
				if protectionStorage <= 0 then
					addEvent(removeCombatProtection, 30 * 1000, target.uid)
					target:setStorageValue(Storage.combatProtectionStorage, 1)
					elseif protectionStorage == 1 then
					self:searchTarget()
					return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
				end
				
				return true
			end
			
			if protectionStorage >= os.time() then
				return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
			end
	end
end

if ((target:isMonster() and self:isPlayer() and target:getType():isPet() and target:getMaster() == self) or (self:isMonster() and target:isPlayer() and self:getType():isPet() and self:getMaster() == target)) then
	return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
end

if PARTY_PROTECTION ~= 0 then
	if self:isPlayer() and target:isPlayer() then
		local party = self:getParty()
		if party then
			local targetParty = target:getParty()
			if targetParty and targetParty == party then
				return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
			end
		end
	end
end

if ADVANCED_SECURE_MODE ~= 0 then
	if self:isPlayer() and target:isPlayer() then
		if self:hasSecureMode() then
			return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
		end
	end
end
return true
end

function Creature:onDrainHealth(attacker, typePrimary, damagePrimary, typeSecondary, damageSecondary, colorPrimary, colorSecondary)
	if (not self) then
		return typePrimary, damagePrimary, typeSecondary, damageSecondary, colorPrimary, colorSecondary
	end
	
	if (not attacker) then
		return typePrimary, damagePrimary, typeSecondary, damageSecondary, colorPrimary, colorSecondary
	end
	
	-- New prey => Bonus damage
	if (attacker:isPlayer()) then
		if (self:isMonster() and not self:getMaster()) then
			--for slot = CONST_PREY_SLOT_FIRST, CONST_PREY_SLOT_THIRD do
				--if (attacker:getPreyCurrentMonster(slot) == self:getName() and attacker:getPreyBonusType(slot) == CONST_BONUS_DAMAGE_BOOST) then
					--damagePrimary = damagePrimary + math.floor(damagePrimary * (attacker:getPreyBonusValue(slot) / 100))
					--break
				--end
			--end
		end
		-- New prey => Damage reduction
		elseif (attacker:isMonster()) then
		if (self:isPlayer()) then
			--for slot = CONST_PREY_SLOT_FIRST, CONST_PREY_SLOT_THIRD do
				--if (self:getPreyCurrentMonster(slot) == attacker:getName() and self:getPreyBonusType(slot) == CONST_BONUS_DAMAGE_REDUCTION) then
					--damagePrimary = damagePrimary - math.floor(damagePrimary * (self:getPreyBonusValue(slot) / 100))
					--break
				--end
			--end
		end
	end
	
	return typePrimary, damagePrimary, typeSecondary, damageSecondary, colorPrimary, colorSecondary
end
