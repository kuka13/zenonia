task_monsters = {
   [1] = {name = "burning book", mons_list = {"cursed book", "energetic book"},  storage = 30000, amount = 300, exp = 50000, pointsTask = {1, 1}, items = {{id = 33318, count = 1}, {id = 2160, count = 10}}},
   [2] = {name = "brain squid", mons_list = {"rage squid", "squid warden"}, storage = 30001, amount = 200, exp = 50000, pointsTask = {1, 1}, items = {{id = 25378, count = 5}, {id = 2640, count = 1}}},
   [3] = {name = "hydra", mons_list = {"", ""}, storage = 30002, amount = 300, exp = 28000, pointsTask = {1, 1}, items = {{id = 2195, count = 1}, {id = 21400, count = 3}}},
   [4] = {name = "black warlock", mons_list = {"", ""}, storage = 30003, amount = 500, exp = 20000, pointsTask = {1, 1}, items = {{id = 25378, count = 3}, {id = 13756, count = 1}}}
}

task_daily = {
   [1] = {name = "black warlock", mons_list = {"monsterDay1_t2", "monsterDay1_t3"}, storage = 40000, amount = 100, exp = 5000, pointsTask = {1, 1}, items = {{id = 5912, count = 10}, {id = 13538, count = 1}}},
   [2] = {name = "demon", mons_list = {"", ""}, storage = 40001, amount = 10, exp = 10000, pointsTask = {1, 1}, items = {{id = 5911, count = 10}, {id = 2160, count = 10}}},
   [3] = {name = "hero", mons_list = {"", ""}, storage = 40002, amount = 10, exp = 18000, pointsTask = {1, 1}, items = {{id = 5914, count = 10}, {id = 2160, count = 10}}},
   [4] = {name = "medusa", mons_list = {"", ""}, storage = 40003, amount = 10, exp = 20000, pointsTask = {1, 1}, items = {{id = 5015, count = 1}, {id = 2160, count = 10}}}
}

task_storage = 20020 -- storage que verifica se está fazendo alguma task e ver qual task é - task normal
task_points = 20021 -- storage que retorna a quantidade de pontos task que o player tem.
task_sto_time = 20022 -- storage de delay para não poder fazer a task novamente caso ela for abandonada.
task_time = 20 -- tempo em horas em que o player ficará sem fazer a task como punição
task_rank = 20023 -- storage do rank task
taskd_storage = 20024 -- storage que verifica se está fazendo alguma task e ver qual task é - task daily
time_daySto = 20025 -- storage do tempo da task daily, no caso para verificar e add 24 horas para fazer novamente a task daily


local ranks_task = {
[{1, 20}] = "Newbie", 
[{21, 50}] = "Elite",
[{51, 100}] = "Master",
[{101, 200}] = "Destroyer",		
[{201, math.huge}] = "Juggernaut"
}

local RankSequence = {
["Newbie"] = 1,
["Elite"] = 2,
["Master"] = 3,
["Destroyer"] = 4,
["Juggernaut"] = 5,
}

function rankIsEqualOrHigher(myRank, RankCheck)
	local ret_1 = RankSequence[myRank]
	local ret_2 = RankSequence[RankCheck]
	return ret_1 >= ret_2
end

function getTaskInfos(player)
	local player = Player(player)
	return task_monsters[player:getStorageValue(task_storage)] or false
end

function getTaskDailyInfo(player)
	local player = Player(player)
	return task_daily[player:getStorageValue(taskd_storage)] or false
end


function taskPoints_get(player)
	local player = Player(player)
	if player:getStorageValue(task_points) == -1 then
		return 0 
	end
	return player:getStorageValue(task_points)
end

function taskPoints_add(player, count)
	local player = Player(player)
	return player:setStorageValue(task_points, taskPoints_get(player) + count)
end

function taskPoints_remove(player, count)
	local player = Player(player)
	return player:setStorageValue(task_points, taskPoints_get(player) - count)
end

function taskRank_get(player)
	local player = Player(player)
	if player:getStorageValue(task_rank) == -1 then
		return 1 
	end
	return player:getStorageValue(task_rank)
end

function taskRank_add(player, count)
	local player = Player(player)
	return player:setStorageValue(task_rank, taskRank_get(player) + count)
end

function getRankTask(player)
	local pontos = taskRank_get(player)
	local ret
	for _, z in pairs(ranks_task) do
		if pontos >= _[1] and pontos <= _[2] then
			ret = z
		end
	end
	return ret
end

function getItemsFromTable(itemtable)
     local text = ""
     for v = 1, #itemtable do
         count, info = itemtable[v].count, ItemType(itemtable[v].id)
         local ret = ", "
         if v == 1 then
             ret = ""
         elseif v == #itemtable then
             ret = " - "
         end
         text = text .. ret
         text = text .. (count > 1 and count or info:getArticle()).." "..(count > 1 and info:getPluralName() or info:getName())
     end
     return text
end