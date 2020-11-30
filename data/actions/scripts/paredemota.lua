local config = {
					id_parede = 6420, --ID DA parede
					pos_parede = {

									{x=33344,y=32121,z=10}, --pos da parede
									{x=33344,y=32120,z=10} --pos da parede
					},
					tempo = 240, --tempo para a parede voltar em segundos
}

local ta = 0


function onUse(cid, item, fromPosition, itemEx, toPosition)
	if ta == 1 then
		doPlayerSendCancel(cid, "As paredes jรก foram removidas, corra!.")
		return true
	end
	for _,pos in pairs(config.pos_parede) do
		local parede = getTileItemById(pos, config.id_parede)
		doRemoveItem(parede.uid)
	end
	ta = 1
	addEvent(function()
		for _,pos in pairs(config.pos_parede) do
			doCreateItem(config.id_parede,1,pos)
		end
		ta = 0
	end,config.tempo*1000)
	return true
end