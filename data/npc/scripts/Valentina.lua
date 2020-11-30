 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid)    npcHandler:onCreatureAppear(cid)   end
function onCreatureDisappear(cid)   npcHandler:onCreatureDisappear(cid)   end
function onCreatureSay(cid, type, msg)   npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()     npcHandler:onThink()     end
 
local items = {
          item2 = {25380, 9992}, -- Rotworm Stews
          item3 = {25380, 9999}, -- Blessed Steak
		  item4 = {25380, 10092}, -- Love Potion
		  item5 = {25380, 15546}, -- Four-Leaf Clover	  
		  item6 = {25380, 2798}, -- Blood Herb
		  item7 = {25380, 11119}, -- Heart Backpack
		  item8 = {25380, 13029}, -- Frozen Heart
		  item9 = {25380, 13169}, --  Demon Infant
		  item10 = {25380, 24322}, -- Truelove Teddy		  
		  item11 = {25380, 24324} -- Sweetheart Ring
		 
}
local counts = {
          count2 = {100, 1}, -- count1 quantidade que será pedido e que será dado na primeira troca
          count3 = {100, 1}, -- count2 quantidade que será pedido e que será dado na segunda troca
		  count4 = {30, 1}, -- count3 quantidade que será pedido e que será dado na segunda troca
		  count5 = {150, 1}, -- count4 quantidade que será pedido e que será dado na segunda troca		  
		  count6 = {5, 1}, -- count4 quantidade que será pedido e que será dado na segunda troca
		  count7 = {60, 1}, -- count4 quantidade que será pedido e que será dado na segunda troca
		  count8 = {100, 1}, -- count4 quantidade que será pedido e que será dado na segunda troca
		  count9 = {100, 1}, -- count4 quantidade que será pedido e que será dado na segunda troca
		  count10 = {50, 1}, -- count4 quantidade que será pedido e que será dado na segunda troca		  
		  count11 = {10, 1} -- count4 quantidade que será pedido e que será dado na segunda troca
		 
}
 
function creatureSayCallback(cid, type, msg)
          if(not npcHandler:isFocused(cid)) then
                    return false
          end
          local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

          if  msgcontains(msg, 'Rotworm Stews') then
                    if getPlayerItemCount(cid, items.item2[1]) >= counts.count2[1] then
                              doPlayerRemoveItem(cid, items.item2[1], counts.count2[1])
                              doPlayerAddItem(cid, items.item2[2], counts.count2[2])
                              selfSay('You just swap '.. counts.count2[1] ..' '.. getItemName(items.item2[1]) ..' for '.. counts.count2[2] ..' '.. getItemName(items.item2[2]) ..'.', cid)
                    else
                              selfSay('You need '.. counts.count2[1] ..' '.. getItemName(items.item2[1]) ..'.', cid)
                    end
					
					elseif msgcontains(msg, 'Blessed Steak') then
                    if getPlayerItemCount(cid, items.item3[1]) >= counts.count3[1] then
                              doPlayerRemoveItem(cid, items.item3[1], counts.count3[1])
                              doPlayerAddItem(cid, items.item3[2], counts.count3[2])
                              selfSay('You just swap '.. counts.count3[1] ..' '.. getItemName(items.item3[1]) ..' for '.. counts.count3[2] ..' '.. getItemName(items.item3[2]) ..'.', cid)
                    else
                              selfSay('You need '.. counts.count3[1] ..' '.. getItemName(items.item3[1]) ..'.', cid)
                    end
					
					elseif msgcontains(msg, 'Love Potion') then
                    if getPlayerItemCount(cid, items.item4[1]) >= counts.count4[1] then
                              doPlayerRemoveItem(cid, items.item4[1], counts.count4[1])
                              doPlayerAddItem(cid, items.item4[2], counts.count4[2])
                              selfSay('You just swap '.. counts.count4[1] ..' '.. getItemName(items.item4[1]) ..' for '.. counts.count4[2] ..' '.. getItemName(items.item4[2]) ..'.', cid)
                    else
                              selfSay('You need '.. counts.count4[1] ..' '.. getItemName(items.item4[1]) ..'.', cid)
                    end
					
					elseif msgcontains(msg, 'Four-Leaf Clover') then
                   if getPlayerItemCount(cid, items.item5[1]) >= counts.count5[1] then
                              doPlayerRemoveItem(cid, items.item5[1], counts.count5[1])
                              doPlayerAddItem(cid, items.item5[2], counts.count5[2])
                              selfSay('You just swap '.. counts.count5[1] ..' '.. getItemName(items.item5[1]) ..' for '.. counts.count5[2] ..' '.. getItemName(items.item5[2]) ..'.', cid)
                    else
                              selfSay('You need '.. counts.count5[1] ..' '.. getItemName(items.item5[1]) ..'.', cid)
                    end
					
					elseif msgcontains(msg, 'Blood Herb') then
                    if getPlayerItemCount(cid, items.item6[1]) >= counts.count6[1] then
                              doPlayerRemoveItem(cid, items.item6[1], counts.count6[1])
                              doPlayerAddItem(cid, items.item6[2], counts.count6[2])
                              selfSay('You just swap '.. counts.count6[1] ..' '.. getItemName(items.item6[1]) ..' for '.. counts.count6[2] ..' '.. getItemName(items.item6[2]) ..'.', cid)
                    else
                              selfSay('You need '.. counts.count6[1] ..' '.. getItemName(items.item6[1]) ..'.', cid)
                    end
					
					elseif msgcontains(msg, "Heart Backpack") then
                    if getPlayerItemCount(cid, items.item7[1]) >= counts.count7[1] then
                              doPlayerRemoveItem(cid, items.item7[1], counts.count7[1])
                              doPlayerAddItem(cid, items.item7[2], counts.count7[2])
                              selfSay('You just swap '.. counts.count7[1] ..' '.. getItemName(items.item7[1]) ..' for '.. counts.count7[2] ..' '.. getItemName(items.item7[2]) ..'.', cid)
                    else
                              selfSay('You need '.. counts.count7[1] ..' '.. getItemName(items.item7[1]) ..'.', cid)
                    end
					
					elseif msgcontains(msg, 'frozen heart') then
                    if getPlayerItemCount(cid, items.item8[1]) >= counts.count8[1] then
                              doPlayerRemoveItem(cid, items.item8[1], counts.count8[1])
                              doPlayerAddItem(cid, items.item8[2], counts.count8[2])
                              selfSay('You just swap '.. counts.count8[1] ..' '.. getItemName(items.item8[1]) ..' for '.. counts.count8[2] ..' '.. getItemName(items.item8[2]) ..'.', cid)
                    else
                              selfSay('You need '.. counts.count8[1] ..' '.. getItemName(items.item8[1]) ..'.', cid)
                    end
					
					elseif msgcontains(msg, 'Demon Infant') then
                    if getPlayerItemCount(cid, items.item9[1]) >= counts.count9[1] then
                              doPlayerRemoveItem(cid, items.item9[1], counts.count9[1])
                              doPlayerAddItem(cid, items.item9[2], counts.count9[2])
                              selfSay('You just swap '.. counts.count9[1] ..' '.. getItemName(items.item9[1]) ..' for '.. counts.count9[2] ..' '.. getItemName(items.item9[2]) ..'.', cid)
                    else
                              selfSay('You need '.. counts.count9[1] ..' '.. getItemName(items.item9[1]) ..'.', cid)
                    end
					
					-- Dolls 
					elseif msgcontains(msg, 'Truelove Teddy') then
                    if getPlayerItemCount(cid, items.item10[1]) >= counts.count10[1] then
                              doPlayerRemoveItem(cid, items.item10[1], counts.count10[1])
                              doPlayerAddItem(cid, items.item10[2], counts.count10[2])
                              selfSay('You just swap '.. counts.count10[1] ..' '.. getItemName(items.item10[1]) ..' for '.. counts.count10[2] ..' '.. getItemName(items.item10[2]) ..'.', cid)
                    else
                              selfSay('You need '.. counts.count10[1] ..' '.. getItemName(items.item10[1]) ..'.', cid)
                    end
					
					elseif msgcontains(msg, 'Sweetheart Ring') then
                    if getPlayerItemCount(cid, items.item11[1]) >= counts.count11[1] then
                              doPlayerRemoveItem(cid, items.item11[1], counts.count11[1])
                              doPlayerAddItem(cid, items.item11[2], counts.count11[2])
                              selfSay('You just swap '.. counts.count11[1] ..' '.. getItemName(items.item11[1]) ..' for '.. counts.count11[2] ..' '.. getItemName(items.item11[2]) ..'.', cid)
                    else
                              selfSay('You need '.. counts.count11[1] ..' '.. getItemName(items.item11[1]) ..'.', cid)
                    end
					
									
					
					
          end
		  
          return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())