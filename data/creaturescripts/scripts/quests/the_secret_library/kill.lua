local defaultTime = 20

function onKill(player, creature)
	if not player:isPlayer() then
		return true
	end
	if not creature:isMonster() or creature:getMaster() then
		return true
	end
	local bossesTiming = {
		["grand master oberon"] = {storageTimer = Storage.secretLibrary.FalconBastion.oberonTimer},
	}
	local monsterName = creature:getName():lower()
	local timing = bossesTiming[monsterName]
	if timing then
		for playerid, damage in pairs(creature:getDamageMap()) do
			local p = Player(playerid)
			if p then
				p:setStorageValue(timing.storageTimer, os.time() + defaultTime*60*60)
			end
		end
	end
	return true
end

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	primaryDamage = 0
	secondaryDamage = 0
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end
