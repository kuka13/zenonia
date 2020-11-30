function onModalWindow(player, modalWindowId, buttonId, choiceId)
	local title, message = "Tutorial", "Message"
	tutorialStep[player:getGuid()] = tutorialStep[player:getGuid()] + 1 
	
	local config = {
		['Thais'] = {
			hints = {
				[1] = {texto = "Conheca o NPC Naji", tppos = Position(32345, 32229, 7), seta = Position(32343, 32229, 7)},
				[2] = {texto = "Conheca o NPC Benjamin", tppos = Position(32348, 32219, 7), seta = Position(32351, 32219, 7)}
			}
		}
	}
	
	local targetTown = player:getTown():getName()
	local townConfig = config[targetTown]
	
	if not townConfig then
		return true
	end
	
	local etapas = townConfig.hints
	
	
	if tutorialStep[player:getGuid()] > #etapas then
		player:unregisterEvent('TutoForNoobs')
		player:teleportTo(tutorialfromPos[player:getGuid()])
		tutorialStep[player:getGuid()] = 0
		return true
	end
	
	message = etapas[tutorialStep[player:getGuid()]].texto
	
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	local destination = etapas[tutorialStep[player:getGuid()]].tppos
	if destination then
		player:teleportTo(destination)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
	end
	
	local arrow = etapas[tutorialStep[player:getGuid()]].seta
	if arrow then
		arrow:sendMagicEffect(CONST_ME_TUTORIALARROW)
	end
	
	
	if tutorialStep[player:getGuid()] == #etapas then
		--player:unregisterEvent('TutoForNoobs')
		--player:teleportTo(tutorialfromPos[player:getGuid()])
	end
	
	
	
	
	
	local window = ModalWindow(301, title, message)
	window:addButton(101, "Ok")
	window:sendToPlayer(player)
	end