local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                npcHandler:onThink()                    end

local limit_level = 100

local vocation_setup = {
    [1] = {
            [100] = {max_magic = 100},
            [200] = {max_magic = 100},
            [300] = {max_magic = 100},
            [420] = {max_magic = 100}
            },
    [2] = {
            [100] = {max_magic = 100},
            [200] = {max_magic = 100},
            [300] = {max_magic = 100},
            [420] = {max_magic = 100}
            },
    [3] = {
        [100] = {max_magic = 30, max_distance = 120, max_shielding = 110},
        [200] = {max_magic = 30, max_distance = 120, max_shielding = 110},
        [300] = {max_magic = 30, max_distance = 120, max_shielding = 110},
        [400] = {max_magic = 30, max_distance = 120, max_shielding = 110}
        },
    [4] = {
        [100] = {max_magic = 12, max_melee = 120, max_shielding = 110},
        [200] = {max_magic = 12, max_melee = 120, max_shielding = 110},
        [300] = {max_magic = 12, max_melee = 120, max_shielding = 110},
        [400] = {max_magic = 12, max_melee = 120, max_shielding = 110}
        }
}

local itemList = {
    {name ="ferumbras' staff", id =    25420    , buy = 1},
    {name ="boots of homecoming", id =    25429    , buy = 1},
    {name ="ferumbras' amulet", id =    25423    , buy = 1},
	{name ="axe of destruction", id =    30686    , buy = 1},
	{name ="mace of destruction", id =    30688    , buy = 1},
	{name ="blade of destruction", id =    30684    , buy = 1},
	{name ="chopper of destruction", id =    30687    , buy = 1},
	{name ="hammer of destruction", id =    30689    , buy = 1},
	{name ="slayer of destruction", id =    30685    , buy = 1},
	{name ="wand of destruction", id =    30692    , buy = 1},
	{name ="rod of destruction", id =    30693    , buy = 1},
	{name ="crossbow of destruction", id =    30691    , buy = 1},
	{name ="bow of destruction", id =    30690    , buy = 1},
	{name ="gold token", id =    25377    , buy = 1},
	{name ="resizer", id =    34057    , buy = 1},
	{name ="mortal mace", id =    36415    , buy = 1},
	{name ="falcon mace", id =    32425    , buy = 1},
	{name ="winterblade", id =    34060    , buy = 1},
	{name ="summerblade", id =    34059    , buy = 1},
	{name ="gnome sword", id =    30886    , buy = 1},
	{name ="falcon longsword", id =    32423    , buy = 1},
	{name ="falcon battleaxe", id =    32424    , buy = 1},
	{name ="ectoplasmic shield", id =    34068    , buy = 1},
	{name ="gnome shield", id =    30885    , buy = 1},
	{name ="falcon circlet", id =    32414    , buy = 1},
	{name ="gnome helmet", id =    30882    , buy = 1},
	{name ="gnome armor", id =    30883    , buy = 1},
	{name ="gnome legs", id =    30884    , buy = 1},
	{name ="silver token", id =    25172    , buy = 1},
	{name ="winged boots", id =    36452    , buy = 1},
	{name ="embrace of nature", id =    36414    , buy = 1},
	{name ="falcon bow", id =    32418    , buy = 1},
	{name ="icicle bow", id =    21696    , buy = 1},
	{name ="bow of cataclysm", id =    36416    , buy = 1},
	{name ="triple bolt crossbow", id =    21690    , buy = 1},
	{name ="cobra amulet", id =    36466    , buy = 1},
	{name ="cobra hood", id =    35232    , buy = 1},
	{name ="cobra crossbow", id =    35228    , buy = 1},
	{name ="cobra boots", id =    35229    , buy = 1},
	{name ="cobra sword", id =    35233    , buy = 1},
	{name ="cobra rod", id =    35235    , buy = 1},
	{name ="cobra wand", id =    35234    , buy = 1},
	{name ="cobra club", id =    35230    , buy = 1},
	{name ="cobra axe", id =    35231    , buy = 1},
	{name ="falcon coif", id =    32415    , buy = 1},
	{name ="falcon plate", id =    32419    , buy = 1},
	{name ="falcon greaves", id =    32420    , buy = 1},
	{name ="falcon escutcheon", id =    32422    , buy = 1},
    {name ="energetic backpack", id =    26181    , buy = 1},
    {name ="void boots", id =    26133    , buy = 1},
    {name ="tiara of power", id =    26130    , buy = 1},
    {name ="collar of blue plasma", id =    26198    , buy = 1},
    {name ="collar of red plasma", id =    26200    , buy = 1},
    {name ="collar of green plasma", id =    26199    , buy = 1},
    {name ="ring of blue plasma", id =    26185    , buy = 1},
    {name ="ring of green plasma", id =    26187    , buy = 1},
    {name ="ring of red plasma", id =    26189    , buy = 1},
    {name ="werewolf helmet", id =    24718    , buy = 1},
    {name ="moonlight crystals", id =    24739    , buy = 1},
    {name ="umbral master blade", id =    22400    , buy = 1},
    {name ="umbral master slayer", id =    22403    , buy = 1},
    {name ="umbral master axe", id =    22406    , buy = 1},
    {name ="umbral master chopper", id =    22409    , buy = 1},
    {name ="umbral master mace", id =    22412    , buy = 1},
	{name ="umbral master hammer", id =    22415    , buy = 1},
    {name ="umbral master bow", id =    22418    , buy = 1},
    {name ="umbral master crossbow", id =    22421    , buy = 1},
    {name ="umbral master spellbook", id =    22424    , buy = 1},
    {name ="infernal bolt", id =    6529    , buy = 1},
    {name ="crystalline arrow", id = 18304    , buy = 1},
    {name ="unrealized dream", id =    22598    , buy = 1},
    {name ="whacking driller of fate.", id = 10515        , buy = 1},
    {name ="squeezing gear of girlpower", id = 10513        , buy = 1},
    {name ="sneaky stabber of eliteness", id = 10511        , buy = 1},
    {name ="dwarven armor", id =    2503    , buy = 1},
    {name ="dwarven legs", id =    2504    , buy = 1},
    {name ="dwarven helmet", id =    2502    , buy = 1},
    {name ="golden boots", id =    2646    , buy = 1},
    {name ="great shield", id =    2522    , buy = 1},
    {name ="ornate chestplate", id =    15406    , buy = 1},
    {name ="ornate legs", id =    15412    , buy = 1},
    {name ="prismatic helmet", id =    18403    , buy = 1},
    {name ="depth calcei", id = 15410        , buy = 1},
    {name ="ornate shield", id =15413        , buy = 1},
    {name ="depth lorica", id =15407        , buy = 1},
    {name ="prismatic legs", id =18405        , buy = 1},
    {name ="elite draken helmet", id =12645        , buy = 1},
    {name ="assassin star", id =7368        , buy = 1},
    {name ="demonic essence", id =6500        , buy = 1},
    {name ="gill gugel", id =18398        , buy = 1},
    {name ="gill legs", id =18400        , buy = 1},
    {name ="yalahari mask", id =9778        , buy = 1},

   
}

local function setNewTradeTable(table)
    local items, item = {}
    for i = 1, #table do
        item = table[i]
        items[item.id] = {itemId = item.id, buyPrice = item.buy, sellPrice = item.sell, subType = 0, realName = item.name}
    end
    return items
end

local function greetCallback(cid)
    local player = Player(cid)
        npcHandler:setMessage(MESSAGE_GREET, "Welcome " .. player:getName() .. ", here you can {trade} items, get some {magic}, get some {skills}, get some {money}, get a bit of {experience} and receive {tibia coins}.")
       
   
    return true
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    local player = Player(cid)
   
   
   
    if msgcontains(msg, "money") then
        player:addItem(2160, 50)
        npcHandler:say("Here is some money, enjoy!", cid)
    elseif msgcontains(msg, "magic") or msgcontains(msg, "skill") or msgcontains(msg, "skills or magic") then
		if player:getGroup():getId() >= 2 then
		npcHandler:say("Esse char tem group > 2.", cid)
		else
		
        local vocation, level = player:getVocation():getBase():getId(), player:getLevel()
        local level_cap = math.min(400, math.max(100,math.floor(level / 100) * 100))
        local voc_parameter = vocation_setup[vocation]
       
       
        local magic = voc_parameter[level_cap].max_magic and voc_parameter[level_cap].max_magic or 0
        local dist = voc_parameter[level_cap].max_distance and voc_parameter[level_cap].max_distance or 0
        local melee = voc_parameter[level_cap].max_melee and voc_parameter[level_cap].max_melee or 0
        local shield = voc_parameter[level_cap].max_shielding and voc_parameter[level_cap].max_shielding or 0
       
        local text = "I have increased your magic to " .. magic
       
        if player:getMagicLevel() < magic then
           
			while player:getMagicLevel() < magic do
			player:addManaSpent(player:getVocation():getRequiredManaSpent(player:getBaseMagicLevel() + 1) - player:getManaSpent())
			end
        else
            text = "You have already reached the maximum magic level cap of " .. magic
        end
       
        if player:getSkillLevel(SKILL_DISTANCE) < dist then
			while player:getSkillLevel(SKILL_DISTANCE) < dist do
            player:addSkillTries(SKILL_DISTANCE, player:getVocation():getRequiredSkillTries(SKILL_DISTANCE, player:getSkillLevel(SKILL_DISTANCE) + 1) - player:getSkillTries(SKILL_DISTANCE))
			end
            --player:addSkillTries(SKILL_SHIELD, player:getVocation():getRequiredSkillTries(SKILL_SHIELD, shield) - player:getSkillTries(SKILL_SHIELD))
            text = text .. ", your distance to " .. dist
            --text = text .. ", your shield skill to " .. shield
        --elseif vocation == 3 then
          --  text = "You have already reached the maximum distance cap of " .. dist .. " and shield cap of " .. shield
		   else
            text = "You have already reached the maximum distance cap of " .. dist
        end
       
	   
	   
        if (player:getSkillLevel(SKILL_CLUB) < melee or player:getSkillLevel(SKILL_SWORD) < melee or player:getSkillLevel(SKILL_AXE) < melee) or player:getSkillLevel(SKILL_SHIELD) < shield then
            
			if player:getSkillLevel(SKILL_CLUB) < melee then
			while player:getSkillLevel(SKILL_CLUB) < melee do
			player:addSkillTries(SKILL_CLUB, player:getVocation():getRequiredSkillTries(SKILL_CLUB, player:getSkillLevel(SKILL_CLUB) + 1) - player:getSkillTries(SKILL_CLUB))
			end
			end
			
			if player:getSkillLevel(SKILL_SWORD) < melee then
			while player:getSkillLevel(SKILL_SWORD) < melee do
            player:addSkillTries(SKILL_SWORD, player:getVocation():getRequiredSkillTries(SKILL_SWORD, player:getSkillLevel(SKILL_SWORD) + 1) - player:getSkillTries(SKILL_SWORD))
			end
			end
			
			if player:getSkillLevel(SKILL_AXE) < melee then
			while player:getSkillLevel(SKILL_AXE) < melee do
            player:addSkillTries(SKILL_AXE, player:getVocation():getRequiredSkillTries(SKILL_AXE, player:getSkillLevel(SKILL_AXE) + 1) - player:getSkillTries(SKILL_AXE))
			end
			end
			
			if player:getSkillLevel(SKILL_SHIELD) < shield then
			while player:getSkillLevel(SKILL_SHIELD) < shield do
            player:addSkillTries(SKILL_SHIELD, player:getVocation():getRequiredSkillTries(SKILL_SHIELD, player:getSkillLevel(SKILL_SHIELD) + 1) - player:getSkillTries(SKILL_SHIELD))
            end
			end
			
			text = text .. ", your melee skills to " .. melee
            text = text .. ", your shield skill to " .. shield
        --elseif vocation == 4 then
            --text = "You have already reached the maximum melee skills cap of " .. melee .. " and shield cap of " .. shield
        end
       
       
        npcHandler:say(text .. ".", cid)
		end
    elseif msgcontains(msg, "experience") then
        limit_level = (os.date("%A") == "Monday") and 400 or ((os.date("%A") == "Tuesday") and 400 or ((os.date("%A") == "Wednesday") and 400 or ((os.date("%A") == "Thursday") and 400 or 400)))
        if player:getLevel() < limit_level then
            local exp_add = 5000000 * limit_level / 100 * 2
            player:addExperience(exp_add)
            --local expMsg = format_num(exp_add,1)
            npcHandler:say("I have added you " .. exp_add .. ", enjoy!", cid)
        else
            npcHandler:say("Oh my child, you are over level ".. limit_level .. ", I can't give you more experience.", cid)
        end
    elseif msgcontains(msg, "tibia") or msgcontains(msg, "coin") then
        db.query("UPDATE `accounts` SET `coins` = `coins` + 1000 WHERE `accounts`.`id` = " .. player:getAccountId())
        npcHandler:say("Foi adicionado 1000 Tibia Coins em sua conta.", cid)
    elseif msgcontains(msg, "trade") then
            local items = setNewTradeTable(itemList)
            local function onBuy(cid, item, subType, amount, ignoreCap, inBackpacks)
                if (ignoreCap == false and (player:getFreeCapacity() < ItemType(items[item].itemId):getWeight(amount) or inBackpacks and player:getFreeCapacity() < (ItemType(items[item].itemId):getWeight(amount) + ItemType(1988):getWeight()))) then
                    return player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You don\'t have enough cap.')
                end
                if items[item].buyPrice <= (player:isPremium() and (player:getMoney() + player:getBankBalance()) or player:getMoney()) then
                    if inBackpacks then
                        local container = Game.createItem(1988, 1)
                        local bp = player:addItemEx(container)
                        if (bp ~= 1) then
                            return player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You don\'t have enough container.')
                        end
                        for i = 1, amount do
                            container:addItem(items[item].itemId, items[item])
                        end
                    else
                        return
                        player:addItem(items[item].itemId, amount, false, items[item]) and
                        player:removeMoneyNpc(amount * items[item].buyPrice) and
                        player:sendTextMessage(MESSAGE_INFO_DESCR, 'You bought '..amount..'x '..items[item].realName..' for '..items[item].buyPrice * amount..' gold coins.')
                    end
                    player:sendTextMessage(MESSAGE_INFO_DESCR, 'You bought '..amount..'x '..items[item].realName..' for '..items[item].buyPrice * amount..' gold coins.')
                    player:removeMoneyNpc(amount * items[item].buyPrice)
                else
                    player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You do not have enough money.')
                end
                return true
            end

            local function onSell(cid, item, subType, amount, ignoreEquipped)
                if items[item].sellPrice then
                    return
                    player:removeItem(items[item].itemId, amount, -1, ignoreEquipped) and
                    player:addMoney(items[item].sellPrice * amount) and

                    player:sendTextMessage(MESSAGE_INFO_DESCR, 'You sold '..amount..'x '..items[item].realName..' for '..items[item].sellPrice * amount..' gold coins.')
                end
                return true
            end

            openShopWindow(cid, itemList, onBuy, onSell)
            npcHandler:say({
            "Keep in mind " .. player:getName() .. ", here you can {trade} items, get some {money}, get a bit of {experience}, {skills or magic} and receive {tibia coins}. ...",
            "There are several caps depending on the day, on monday max level will be 100, tuesday 200, wednesday 300, thursday 400 and friday, saturday and sunday will be 500. ...",
            "Also there will be caps for magic level, skills melee and distance, and also shielding."
            }, cid) --cambiar
    end
    return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())