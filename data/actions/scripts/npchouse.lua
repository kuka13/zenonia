--- versão inicial 
--- proxima mudança envia tudo para lib
--- deixa igual a versão 12
--- 
  local config8 = {
	[1] = {name = "[Ferumbrasdress] Potion", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertferupotion", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	}, 
		[2] = {name = "[Ferumbrasdress] Loot", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertferutrade", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
		[3] = {name = "[Ferumbrasdress] Imbuements", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertferupotion", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
	
}
  function  Player:ferumbrasdress()
	local cid = self:getId()
	local window = ModalWindow {
		title = "Npc Select",
		message = "Choose the npc",
	}

	for index8, choice in ipairs(config8) do
		local name = string.format("%s", choice.name)
		local choice = window:addChoice(name)

        choice.index8 = index8	end

	window:addButton("Escolher",
		function(button, choice)
			local self = Player(cid)
			if self and choice then
				local tmpChoice8 = config8[choice.index8]
				if tmpChoice8 then
					tmpChoice8.action(cid)
				end
			end 
		end
	)
	window:setDefaultEnterButton("Escolher")
window:addButton("Voltar",
		function(button, choice)
			local self = Player(cid)
			if self then
				self:sendMainModal1()
			end
		end
	)

	window:addButton("Sair")
	window:sendToPlayer(self)
end
  
  local config7 = {
	[1] = {name = "[Bonelorddress] Potion", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertbehopotion", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	}, 
		[2] = {name = "[Bonelorddress] Loot", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertbehotrade", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
		[3] = {name = "[Bonelorddress] Imbuements", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertbehoimbu", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
	
}
  
 function  Player:bonelorddress()
	local cid = self:getId()
	local window = ModalWindow {
		title = "Npc Select",
		message = "Choose the npc",
	}

	for index7, choice in ipairs(config7) do
		local name = string.format("%s", choice.name)
		local choice = window:addChoice(name)

        choice.index7 = index7	end

	window:addButton("Escolher",
		function(button, choice)
			local self = Player(cid)
			if self and choice then
				local tmpChoice7 = config7[choice.index7]
				if tmpChoice7 then
					tmpChoice7.action(cid)
				end
			end 
		end
	)
	window:setDefaultEnterButton("Escolher")
window:addButton("Voltar",
		function(button, choice)
			local self = Player(cid)
			if self then
				self:sendMainModal1()
			end
		end
	)

	window:addButton("Sair")
	window:sendToPlayer(self)
end
  
  local config6 = {
	[1] = {name = "[Hydradress] Potion", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakerthydrapotion", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	}, 
		[2] = {name = "[Hydradress] Loot", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakerthydratrade", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
		[3] = {name = "[Hydradress] Imbuements", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakerthydraimbu", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
	
}
 
 function  Player:hydradress()
	local cid = self:getId()
	local window = ModalWindow {
		title = "Npc Select",
		message = "Choose the npc",
	}

	for index6, choice in ipairs(config6) do
		local name = string.format("%s", choice.name)
		local choice = window:addChoice(name)

        choice.index6 = index6	end

	window:addButton("Escolher",
		function(button, choice)
			local self = Player(cid)
			if self and choice then
				local tmpChoice6 = config6[choice.index6]
				if tmpChoice6 then
					tmpChoice6.action(cid)
				end
			end 
		end
	)
	window:setDefaultEnterButton("Escolher")
window:addButton("Voltar",
		function(button, choice)
			local self = Player(cid)
			if self then
				self:sendMainModal1()
			end
		end
	)

	window:addButton("Sair")
	window:sendToPlayer(self)
end
 
 local config5 = {
	[1] = {name = "[Dragondress] Potion", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertdragonpotion", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	}, 
		[2] = {name = "[Dragondress] Loot", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertdragontrade", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
		[3] = {name = "[Dragondress] Imbuements", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertdragonimbu", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
	
}
 
 function  Player:dragondress() 
	local cid = self:getId()
	local window = ModalWindow {
		title = "Npc Select",
		message = "Choose the npc",
	}

	for index5, choice in ipairs(config5) do
		local name = string.format("%s", choice.name)
		local choice = window:addChoice(name)

        choice.index5 = index5	end

	window:addButton("Escolher",
		function(button, choice)
			local self = Player(cid)
			if self and choice then
				local tmpChoice5 = config5[choice.index5]
				if tmpChoice5 then
					tmpChoice5.action(cid)
				end
			end 
		end
	)
	window:setDefaultEnterButton("Escolher")
window:addButton("Voltar",
		function(button, choice)
			local self = Player(cid)
			if self then
				self:sendMainModal1()
			end
		end
	)

	window:addButton("Sair")
	window:sendToPlayer(self)
end
   
  local config4 = {
	[1] = {name = "[CookDress] Potion", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertpotioncookdress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	}, 
		[2] = {name = "[CookDress] Loot", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakerttradecookdress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
		[3] = {name = "[CookDress] Imbuements", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertimbucookdress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
	
}
 
 function Player:CookDress()
	local cid = self:getId()
	local window = ModalWindow {
		title = "Npc Select",
		message = "Choose the npc",
	}

	for index4, choice in ipairs(config4) do
		local name = string.format("%s", choice.name)
		local choice = window:addChoice(name)

        choice.index4 = index4
	end

	window:addButton("Escolher",
		function(button, choice)
			local self = Player(cid)
			if self and choice then
				local tmpChoice4 = config4[choice.index4]
				if tmpChoice4 then
					tmpChoice4.action(cid)
				end
			end 
		end
	)
	window:setDefaultEnterButton("Escolher")
window:addButton("Voltar",
		function(button, choice)
			local self = Player(cid)
			if self then
				self:sendMainModal1()
			end
		end
	)

	window:addButton("Sair")
	window:sendToPlayer(self)
end
    
  local config3 = {
	[1] = {name = "[Tradedress] Potion", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertpotiontraderdress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	}, 
		[2] = {name = "[Tradedress] Loot", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakerttradetraderdress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
		[3] = {name = "[Tradedress] Imbuements", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertimbutraderdress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
	
}
 
 function Player:Tradedress()
	local cid = self:getId()
	local window = ModalWindow {
		title = "Npc Select",
		message = "Choose the npc",
	}

	for index3, choice in ipairs(config3) do
		local name = string.format("%s", choice.name)
		local choice = window:addChoice(name)

        choice.index3 = index3
	end

	window:addButton("Escolher",
		function(button, choice)
			local self = Player(cid)
			if self and choice then
				local tmpChoice3 = config3[choice.index3]
				if tmpChoice3 then
					tmpChoice3.action(cid)
				end
			end 
		end
	)
	window:setDefaultEnterButton("Escolher")
window:addButton("Voltar",
		function(button, choice)
			local self = Player(cid)
			if self then
				self:sendMainModal1()
			end
		end
	)

	window:addButton("Sair")
	window:sendToPlayer(self)
end
   

  local config2 = {
	[1] = {name = "[Stewarddress] Potion", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertpotionstewarddress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	}, 
		[2] = {name = "[Stewarddress] Loot", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakerttradestewarddress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
		[3] = {name = "[Stewarddress] Imbuements", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertimbustewarddress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
	
}
 
 function Player:Stewarddress()
	local cid = self:getId()
	local window = ModalWindow {
		title = "Npc Select",
		message = "Choose the npc",
	}

	for index2, choice in ipairs(config2) do
		local name = string.format("%s", choice.name)
		local choice = window:addChoice(name)

        choice.index2 = index2
	end

	window:addButton("Escolher",
		function(button, choice)
			local self = Player(cid)
			if self and choice then
				local tmpChoice2 = config2[choice.index2]
				if tmpChoice2 then
					tmpChoice2.action(cid)
				end
			end 
		end
	)
	window:setDefaultEnterButton("Escolher")
window:addButton("Voltar",
		function(button, choice)
			local self = Player(cid)
			if self then
				self:sendMainModal1()
			end
		end
	)

	window:addButton("Sair")
	window:sendToPlayer(self)
end
  
local config1 = {
	[1] = {name = "[Bankerdress] Potion", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertpotionbankerdress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	}, 
		[2] = {name = "[Bankerdress] Loot", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakerttradebankerdress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
		[3] = {name = "[Bankerdress] Imbuements", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:setStorageValue(Storage.Exaust.tempo, os.time() + 1000)
			
        Game.createNpc("npcmakertimbubankerdress", getPlayerPosition(player), true, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  
		end
	},
	
}
function Player:bankerdress()
	local cid = self:getId()
	local window = ModalWindow {
		title = "Npc Select",
		message = "Choose the npc",
	}

	for index1, choice in ipairs(config1) do
		local name = string.format("%s", choice.name)
		local choice = window:addChoice(name)

        choice.index1 = index1
	end

	window:addButton("Escolher",
		function(button, choice)
			local self = Player(cid)
			if self and choice then
				local tmpChoice1 = config1[choice.index1]
				if tmpChoice1 then
					tmpChoice1.action(cid)
				end
			end
		end
	)
	window:setDefaultEnterButton("Escolher")
window:addButton("Voltar",
		function(button, choice)
			local self = Player(cid)
			if self then
				self:sendMainModal1()
			end
		end
	)

	window:addButton("Sair")
	window:sendToPlayer(self)
end
 
 local config = {
	[1] = {name = "[Outfit] Ferumbrasdress", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

 player:ferumbrasdress()  
		end
	},
	
		[2] = {name = "[Outfit] Dragondress", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

 player:dragondress()  
		end
	},
			[3] = {name = "[Outfit] Bonelorddress", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

 player:bonelorddress()  
		end
	},
	
				[4] = {name = "[Outfit] Hydradress", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

 player:hydradress()  
		end
	},
	 
	[5] = {name = "[Outfit] CookDress", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

			
 player:CookDress()
		end
	},
	[6] = {name = "[Outfit] Tradedress", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 

player:Tradedress()
		end
	},
	[7] = {name = "[Outfit] Stewarddress", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end
 
player:Stewarddress()
		end
	},
		
	 

 	[8] = {name = "[Outfit] Bankerdress", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end

			player:bankerdress()
		end
	},
}
 function Player:sendMainModal1()
	local cid = self:getId()
	local window = ModalWindow {
		title = "Npc Select",
		message = "Choose the npc",
	}

	for index, choice in ipairs(config) do
		local name = string.format("%s", choice.name)
		local choice = window:addChoice(name)

        choice.index = index
	end

	window:addButton("Escolher",
		function(button, choice)
			local self = Player(cid)
			if self and choice then
				local tmpChoice = config[choice.index]
				if tmpChoice then
					tmpChoice.action(cid)
				end
			end
		end
	)
	
	window:setDefaultEnterButton("Escolher")

	window:addButton("Sair")
	window:sendToPlayer(self)
end
 
	
function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
local house = player:getTile():getHouse()
	if not house then
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "To use this item you must be inside your home.")
		
		return true
	end

if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) and not Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "you can not use this item while in combat.")
		return true
	end
 
	
--if player:getStorageValue(Storage.Exaust.tempo) >= os.time() then
--player:sendTextMessage(MESSAGE_STATUS_SMALL, 'Wait 24 hrs for create new npc.')
--return true
--end
	
	
	
	
	
	
	player:sendMainModal1()
    return true
end