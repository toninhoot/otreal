-- Bank NPC with IOF (English, ASCII only)
-- IOF: 5% on deposit / withdraw / transfer
-- Federal share = 1% of gross (20% of IOF); remaining IOF split equally across 4 kingdoms (1% each).
-- All IOF calculations are rounded DOWN to the nearest gold coin.
-- If the same player holds multiple leadership roles, they only receive one share (no double dipping).

local count = {}
local transfer = {}
local receiptFormat = "Date: %s\nType: %s\nGold Amount: %d\nReceipt Owner: %s\nRecipient: %s\n\n%s"

-- ================= IOF / Helpers =================
local IOF_RATE = 0.05 -- 5%

-- Kingdom names in English (DB kingdom: 0..4)
local KINGDOM_NAMES = { [0]="None", [1]="North", [2]="West", [3]="South", [4]="East" }

local function getPlayerKingdomId(player)
  local r = db.storeQuery(string.format("SELECT kingdom FROM players WHERE id=%d", player:getGuid()))
  if not r then return 0 end
  local k = result.getNumber(r, "kingdom") or 0
  result.free(r)
  return k
end

-- returns a breakdown table {tax, fed, k1, k2, k3, k4, net, kname}
local function iofBreakdown(amount, player)
  -- round DOWN to nearest gold
  local tax = math.floor(amount * IOF_RATE)
  local fed = math.floor(tax / 5)            -- 20% of IOF = 1% of gross
  local kingdoms = tax - fed
  local each = math.floor(kingdoms / 4)      -- split equally per kingdom, remainder ignored
  local kid = getPlayerKingdomId(player)
  return {
    tax = tax,
    fed = fed,
    k1 = each, k2 = each, k3 = each, k4 = each,
    net = amount - tax,
    kname = KINGDOM_NAMES[kid] or "None"
  }
end

-- ASCII-only, English breakdown text
local function iofReceiptLine(kind, amount, b)
  return string.format("%s\nGross: %d gp\nIOF (5%%): %d gp\n- Federal: %d gp\n- Kingdoms: 4 x %d gp\nNet: %d gp\nYour kingdom: %s",
    kind, amount, b.tax, b.fed, b.k1, b.net, b.kname)
end

-- Adjust bank balance for a target player:
-- if online, use API (safe in memory); if offline, SQL.
local function addBankByIdOrSQL(playerId, playerName, delta)
  if delta == 0 then return end
  local tgt = (Game.getPlayerByGUID and Game.getPlayerByGUID(playerId)) or Game.getPlayerByName(playerName)
  if tgt then
    tgt:setBankBalance(tgt:getBankBalance() + delta)
  else
    db.query(string.format("UPDATE players SET balance = balance + %d WHERE id=%d", delta, playerId))
  end
end

-- Credit federal share to current president (if any)
local function creditPresident(amount)
  if amount <= 0 then return end
  local r = db.storeQuery("SELECT id, name FROM players WHERE is_president=1 LIMIT 1")
  if not r then return end
  local pid = result.getNumber(r, "id")
  local pname = result.getString(r, "name")
  result.free(r)
  addBankByIdOrSQL(pid, pname, amount)
end

-- Credit each governor (per kingdom)
local function creditGovernors(each)
  if each <= 0 then return end
  for k = 1, 4 do
    local r = db.storeQuery(string.format("SELECT id, name FROM players WHERE is_governor=1 AND kingdom=%d LIMIT 1", k))
    if r then
      local pid = result.getNumber(r, "id")
      local pname = result.getString(r, "name")
      result.free(r)
      addBankByIdOrSQL(pid, pname, each)
    end
  end
end

-- Distribute IOF tax shares safely. If the actor is one of the recipients, credit them only once.
local function distributeIOF(breakdown, actorPlayer)
  local actorId = actorPlayer and actorPlayer:getGuid() or 0
  -- President share
  local presId = 0
  do
    local r = db.storeQuery("SELECT id, name FROM players WHERE is_president=1 LIMIT 1")
    if r then
      presId = result.getNumber(r, "id")
      local presName = result.getString(r, "name")
      result.free(r)
      if presId ~= 0 then
        if actorId == presId then
          actorPlayer:setBankBalance(actorPlayer:getBankBalance() + breakdown.fed)
        else
          addBankByIdOrSQL(presId, presName, breakdown.fed)
        end
      end
    end
  end
  -- Governor shares (4 kingdoms)
  for k = 1, 4 do
    local r = db.storeQuery(string.format("SELECT id, name FROM players WHERE is_governor=1 AND kingdom=%d LIMIT 1", k))
    if r then
      local gid = result.getNumber(r, "id")
      local gname = result.getString(r, "name")
      result.free(r)
      if gid ~= 0 and gid ~= presId then
        if actorId == gid then
          actorPlayer:setBankBalance(actorPlayer:getBankBalance() + breakdown.k1)  -- k1 == k2 == k3 == k4
        else
          addBankByIdOrSQL(gid, gname, breakdown.k1)
        end
      end
    end
  end
end
-- ================= /IOF Helpers =================

local function GetReceipt(info)
  local receipt = Game.createItem(info.success and 19598 or 19599)
  receipt:setAttribute(ITEM_ATTRIBUTE_TEXT,
    receiptFormat:format(
      os.date("%d. %b %Y - %H:%M:%S"),
      info.type,
      info.amount,
      info.owner,
      info.recipient,
      info.message
    )
  )
  return receipt
end

function Npc:parseBankMessages(message, npc, creature, npcHandler)
  local messagesTable = {
    ["money"] = "We can {change} money for you. You can also access your {bank account}",
    ["change"] = "There are three different coin types in Tibia: 100 gold coins equal 1 platinum coin, 100 platinum coins equal 1 crystal coin. So if you would like to change 100 gold into 1 platinum, simply say '{change gold}' and then '1 platinum'",
    ["bank"] = "We can {change} money for you. You can also access your {bank account}",
    ["advanced"] = "Your bank account will be used automatically when you want to {rent} a house or place an offer on the {market}. Let me know if you want to know about how either one works",
    ["help"] = "You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation",
    ["functions"] = "You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation",
    ["basic"] = "You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation",
    ["job"] = "I work in this bank. I can {change money} for you and help you with your bank account",
    ["bank account"] = {
      "Every Tibian has one. The big advantage is that you can access your money in every branch of the Tibian Bank! ...",
      "Would you like to know more about the {basic} functions of your bank account, the {advanced} functions, or are you already bored, perhaps?",
    },
  }
  npcHandler:sendMessages(message, messagesTable, npc, creature, true, 3000)
end

function Npc:parseBank(message, npc, creature, npcHandler)
  local player = Player(creature)
  local playerId = creature:getId()
  local msg = message:lower()

  -- Ignore guild-related keywords here (guild bank handled separately)
  if MsgContains(message, "guild") then
    return true
  end

  -- Balance inquiry
  if MsgContains(message, "balance") then
    local balance = Bank.balance(player)
    if balance >= 100000000 then
      npcHandler:say(string.format("I think you must be one of the richest inhabitants in the world! Your account balance is %d gold.", balance), npc, creature)
    elseif balance >= 10000000 then
      npcHandler:say(string.format("You have made ten millions and it still grows! Your account balance is %d gold.", balance), npc, creature)
    elseif balance >= 1000000 then
      npcHandler:say(string.format("Wow, you have reached the magic number of a million gp! Your account balance is %d gold!", balance), npc, creature)
    elseif balance >= 100000 then
      npcHandler:say(string.format("You certainly have made a pretty penny. Your account balance is %d gold.", balance), npc, creature)
    else
      npcHandler:say(string.format("Your account balance is %d gold.", balance), npc, creature)
    end
    return true
  end

  -- Deposit money
  if MsgContains(message, "deposit") then
    local amount = nil
    if MsgContains(message, "deposit all") then
      amount = player:getMoney()
    else
      if string.match(message, "%d+") then
        amount = getMoneyCount(message)
      end
    end
    if amount == nil then
      npcHandler:say("Please tell me how much gold you would like to deposit.", npc, creature)
      npcHandler:setTopic(playerId, 1)
      return true
    end
    if amount <= 0 or player:getMoney() < amount or not isValidMoney(amount) then
      npcHandler:say("You do not have enough gold.", npc, creature)
      npcHandler:setTopic(playerId, 0)
    else
      count[playerId] = amount
      local b = iofBreakdown(amount, player)
      npcHandler:say(string.format("Would you really like to deposit %d gold? IOF 5%%: %d. Net to balance: %d.", amount, b.tax, b.net), npc, creature)
      npcHandler:setTopic(playerId, 2)
    end
    return true
  end

  if npcHandler:getTopic(playerId) == 1 then
    -- Handle deposit amount prompt
    local amount = getMoneyCount(message)
    if not isValidMoney(amount) or player:getMoney() < amount or amount <= 0 then
      npcHandler:say("You do not have enough gold.", npc, creature)
      npcHandler:setTopic(playerId, 0)
    else
      count[playerId] = amount
      local b = iofBreakdown(amount, player)
      npcHandler:say(string.format("Would you really like to deposit %d gold? IOF 5%%: %d. Net to balance: %d.", amount, b.tax, b.net), npc, creature)
      npcHandler:setTopic(playerId, 2)
    end
    return true
  end

  if npcHandler:getTopic(playerId) == 2 then
    if MsgContains(message, "yes") then
      local amount = count[playerId] or 0
      local b = iofBreakdown(amount, player)
      if player:removeMoney(amount) then
        -- Credit net amount to bank account (amount already removed from player)
        if Bank and Bank.credit then
          Bank.credit(player, b.net)
        else
          player:setBankBalance(player:getBankBalance() + b.net)
        end
        -- Distribute IOF tax shares
        distributeIOF(b, player)
        npcHandler:say("Deposit successful.\n" .. iofReceiptLine("Deposit", amount, b), npc, creature)
      else
        npcHandler:say("You do not have enough gold.", npc, creature)
      end
    elseif MsgContains(message, "no") then
      npcHandler:say("As you wish. Is there something else I can do for you?", npc, creature)
    end
    npcHandler:setTopic(playerId, 0)
    return true
  end

  -- Withdraw money
  if MsgContains(message, "withdraw") then
    local amount
    if MsgFind(message, "withdraw all") then
      if Bank and Bank.balance then
        amount = Bank.balance(player)
      else
        amount = player:getBankBalance()
      end
    elseif string.match(message, "%d+") then
      amount = getMoneyCount(message)
    end
    if amount == nil then
      npcHandler:say("Please tell me how much gold you would like to withdraw.", npc, creature)
      npcHandler:setTopic(playerId, 6)
      return true
    end
    if not isValidMoney(amount) or not Bank.hasBalance(player, amount) then
      npcHandler:say("There is not enough gold on your account.", npc, creature)
      npcHandler:setTopic(playerId, 0)
    else
      count[playerId] = amount
      local b = iofBreakdown(amount, player)
      npcHandler:say(string.format("Are you sure you wish to withdraw %d gold? IOF 5%%: %d. You will receive: %d.", amount, b.tax, b.net), npc, creature)
      npcHandler:setTopic(playerId, 7)
    end
    return true
  end

  if npcHandler:getTopic(playerId) == 6 then
    local amount = getMoneyCount(message)
    if not isValidMoney(amount) or not Bank.hasBalance(player, amount) then
      npcHandler:say("There is not enough gold on your account.", npc, creature)
      npcHandler:setTopic(playerId, 0)
    else
      count[playerId] = amount
      local b = iofBreakdown(amount, player)
      npcHandler:say(string.format("Are you sure you wish to withdraw %d gold? IOF 5%%: %d. You will receive: %d.", amount, b.tax, b.net), npc, creature)
      npcHandler:setTopic(playerId, 7)
    end
    return true
  end

  if npcHandler:getTopic(playerId) == 7 then
    if MsgContains(message, "yes") then
      local amount = count[playerId] or 0
      local b = iofBreakdown(amount, player)
      -- Calculate coin stacks (for capacity/slots check)
      local totalValue = amount
      local crystalCoins = math.floor(totalValue / 10000)
      totalValue = totalValue % 10000
      local platinumCoins = math.floor(totalValue / 100)
      totalValue = totalValue % 100
      local goldCoins = totalValue
      local crystalPiles = math.floor((crystalCoins + 99) / 100)
      local platinumPiles = math.floor((platinumCoins + 99) / 100)
      local goldPiles = math.floor((goldCoins + 99) / 100)
      local totalPiles = crystalPiles + platinumPiles + goldPiles
      if player:getFreeCapacity() < getMoneyWeight(amount) then
        npcHandler:say("Hold on, you do not have enough capacity to carry all those coins!", npc, creature)
      elseif player:getFreeBackpackSlots() < totalPiles then
        npcHandler:say(string.format(
          "Hold on, you do not have enough room in your backpack to carry all these coins.\nYou will receive %i crystal stacks (%i coins), %i platinum stacks (%i coins), and %i gold stacks (%i coins). Please ensure you have at least %i free slots in your backpack.",
          crystalPiles, crystalCoins, platinumPiles, platinumCoins, goldPiles, goldCoins, totalPiles
        ), npc, creature)
      else
        if not player:withdrawMoney(amount) then
          npcHandler:say("There is not enough gold on your account.", npc, creature)
        else
          -- Remove IOF tax from withdrawn coins and distribute shares
          if player:removeMoney(b.tax) then
            distributeIOF(b, player)
            npcHandler:say("Here you are.\n" .. iofReceiptLine("Withdraw", amount, b), npc, creature)
          else
            -- Could not remove the IOF coins (possibly capacity or slot issues). Revert withdrawal.
            if Bank and Bank.deposit then
              Bank.deposit(player, amount)
            else
              Player.depositMoney(player, amount)
            end
            npcHandler:say("You do not have enough room/capacity for the coins. Try again.", npc, creature)
          end
        end
      end
    elseif MsgContains(message, "no") then
      npcHandler:say("The customer is king! Come back anytime if you wish to withdraw your money.", npc, creature)
    end
    npcHandler:setTopic(playerId, 0)
    return true
  end

  -- Transfer money
  if MsgContains(message, "transfer") then
    local amount = 0
    if string.match(message, "%d+") then
      amount = getMoneyCount(message)
    end
    if amount == 0 or not isValidMoney(amount) then
      -- No valid amount provided, ask for amount
      npcHandler:say("Please tell me the amount of gold you would like to transfer.", npc, creature)
      npcHandler:setTopic(playerId, 11)
      return true
    end
    if not Bank.hasBalance(player, amount) then
      npcHandler:say("There is not enough gold on your account.", npc, creature)
      npcHandler:setTopic(playerId, 0)
      return true
    end
    count[playerId] = amount
    local target = message:match("to%s*(.+)$")
    if not target or target == "" then
      -- No recipient provided, ask for name
      npcHandler:say(string.format("Who would you like to transfer %d gold to?", amount), npc, creature)
      npcHandler:setTopic(playerId, 12)
      return true
    end
    -- If both amount and target name are provided
    if player:getName():lower() == target:lower() then
      npcHandler:say("Fill in this field with the person who receives your gold!", npc, creature)
      npcHandler:setTopic(playerId, 0)
      return true
    end
    local playerName = Game.getNormalizedPlayerName(target)
    if not playerName then
      npcHandler:say("This player does not exist.", npc, creature)
      npcHandler:setTopic(playerId, 0)
      return true
    end
    local cleanName = playerName:gsub("%s+", ""):lower()
    local arrayDenied = { "accountmanager","rooksample","druidsample","sorcerersample","knightsample","paladinsample" }
    if table.contains(arrayDenied, cleanName) then
      npcHandler:say("This player does not exist.", npc, creature)
      npcHandler:setTopic(playerId, 0)
      return true
    end
    transfer[playerId] = playerName
    local b = iofBreakdown(amount, player)
    npcHandler:say(string.format("Confirm: transfer %d gold to %s.\nRecipient will receive %d. IOF 5%% (debited from you): %d.", amount, playerName, b.net, b.tax), npc, creature)
    npcHandler:setTopic(playerId, 13)
    return true
  end

  if npcHandler:getTopic(playerId) == 11 then
    -- Player provided amount, now ask for recipient
    count[playerId] = getMoneyCount(message)
    if not Bank.hasBalance(player, count[playerId]) then
      npcHandler:say("There is not enough gold on your account.", npc, creature)
      npcHandler:setTopic(playerId, 0)
      return true
    end
    if isValidMoney(count[playerId]) then
      npcHandler:say(string.format("Who would you like to transfer %d gold to?", count[playerId]), npc, creature)
      npcHandler:setTopic(playerId, 12)
    else
      npcHandler:say("There is not enough gold on your account.", npc, creature)
      npcHandler:setTopic(playerId, 0)
    end
    return true
  end

  if npcHandler:getTopic(playerId) == 12 then
    -- Player provided recipient name
    transfer[playerId] = message
    if player:getName():lower() == (transfer[playerId] or ""):lower() then
      npcHandler:say("Fill in this field with the person who receives your gold!", npc, creature)
      npcHandler:setTopic(playerId, 0)
      return true
    end
    local playerName = Game.getNormalizedPlayerName(transfer[playerId])
    if playerName then
      local cleanName = playerName:gsub("%s+", ""):lower()
      local arrayDenied = { "accountmanager","rooksample","druidsample","sorcerersample","knightsample","paladinsample" }
      if table.contains(arrayDenied, cleanName) then
        npcHandler:say("This player does not exist.", npc, creature)
        npcHandler:setTopic(playerId, 0)
        return true
      end
      transfer[playerId] = playerName  -- use normalized name for the actual transfer
      local b = iofBreakdown(count[playerId], player)
      npcHandler:say(string.format("Confirm: transfer %d gold to %s.\nRecipient will receive %d. IOF 5%% (debited from you): %d.", count[playerId], playerName, b.net, b.tax), npc, creature)
      npcHandler:setTopic(playerId, 13)
    else
      npcHandler:say("This player does not exist.", npc, creature)
      npcHandler:setTopic(playerId, 0)
    end
    return true
  end

  if npcHandler:getTopic(playerId) == 13 then
    if MsgContains(message, "yes") then
      local amount = count[playerId] or 0
      local b = iofBreakdown(amount, player)
      -- Ensure player still has enough balance to cover gross + IOF
      if not Bank.hasBalance(player, amount + b.tax) then
        npcHandler:say("There is not enough gold on your account to cover the amount plus IOF.", npc, creature)
        npcHandler:setTopic(playerId, 0)
        return true
      end
      -- Transfer net amount to recipient
      if not player:transferMoneyTo(transfer[playerId], b.net) then
        npcHandler:say("You cannot transfer money to this account.", npc, creature)
        npcHandler:setTopic(playerId, 0)
        return true
      end
      -- Debit IOF tax from sender's bank balance
      player:setBankBalance(player:getBankBalance() - b.tax)
      -- Distribute IOF tax shares
      distributeIOF(b, player)
      npcHandler:say(string.format("Very well. Transfer completed.\nRecipient will receive %d gp.\n%s", b.net, iofReceiptLine("Transfer", amount, b)), npc, creature)
      transfer[playerId] = nil
    elseif MsgContains(message, "no") then
      npcHandler:say("Alright, is there something else I can do for you?", npc, creature)
    end
    npcHandler:setTopic(playerId, 0)
    return true
  end

  -- Change money (no IOF involved)
  if MsgContains(message, "change gold") then
    npcHandler:say("How many platinum coins would you like to get?", npc, creature)
    npcHandler:setTopic(playerId, 14)
    return true
  end

  if npcHandler:getTopic(playerId) == 14 then
    if getMoneyCount(message) < 1 then
      npcHandler:say("Sorry, you do not have enough gold coins.", npc, creature)
      npcHandler:setTopic(playerId, 0)
    else
      count[playerId] = getMoneyCount(message)
      npcHandler:say(string.format("So you would like me to change %d of your gold coins into %d platinum coins?", count[playerId] * 100, count[playerId]), npc, creature)
      npcHandler:setTopic(playerId, 15)
    end
    return true
  end

  if npcHandler:getTopic(playerId) == 15 then
    if MsgContains(message, "yes") then
      if player:removeItem(ITEM_GOLD_COIN, count[playerId] * 100) then
        player:addItem(ITEM_PLATINUM_COIN, count[playerId])
        npcHandler:say("Here you are.", npc, creature)
      else
        npcHandler:say("Sorry, you do not have enough gold coins.", npc, creature)
      end
    else
      npcHandler:say("Well, can I help you with something else?", npc, creature)
    end
    npcHandler:setTopic(playerId, 0)
    return true
  end

  if MsgContains(message, "change platinum") then
    npcHandler:say("Would you like to change your platinum coins into {gold} or {crystal}?", npc, creature)
    npcHandler:setTopic(playerId, 16)
    return true
  end

  if npcHandler:getTopic(playerId) == 16 then
    if MsgContains(message, "gold") then
      npcHandler:say("How many platinum coins would you like to change into {gold}?", npc, creature)
      npcHandler:setTopic(playerId, 17)
    elseif MsgContains(message, "crystal") then
      npcHandler:say("How many crystal coins would you like to get?", npc, creature)
      npcHandler:setTopic(playerId, 19)
    else
      npcHandler:say("Well, can I help you with something else?", npc, creature)
      npcHandler:setTopic(playerId, 0)
    end
    return true
  end

  if npcHandler:getTopic(playerId) == 17 then
    if getMoneyCount(message) < 1 then
      npcHandler:say("Sorry, you do not have enough platinum coins.", npc, creature)
      npcHandler:setTopic(playerId, 0)
    else
      count[playerId] = getMoneyCount(message)
      npcHandler:say(string.format("So you would like me to change %d of your platinum coins into %d gold coins for you?", count[playerId] * 100, count[playerId]), npc, creature)
      npcHandler:setTopic(playerId, 18)
    end
    return true
  end

  if npcHandler:getTopic(playerId) == 18 then
    if MsgContains(message, "yes") then
      if player:removeItem(ITEM_PLATINUM_COIN, count[playerId]) then
        player:addItem(ITEM_GOLD_COIN, count[playerId] * 100)
        npcHandler:say("Here you are.", npc, creature)
      else
        npcHandler:say("Sorry, you do not have enough platinum coins.", npc, creature)
      end
    else
      npcHandler:say("Well, can I help you with something else?", npc, creature)
    end
    npcHandler:setTopic(playerId, 0)
    return true
  end

  if MsgContains(message, "change crystal") then
    npcHandler:say("How many crystal coins would you like to change into platinum?", npc, creature)
    npcHandler:setTopic(playerId, 21)
    return true
  end

  if npcHandler:getTopic(playerId) == 21 then
    if getMoneyCount(message) < 1 then
      npcHandler:say("Sorry, you do not have enough crystal coins.", npc, creature)
      npcHandler:setTopic(playerId, 0)
    else
      count[playerId] = getMoneyCount(message)
      npcHandler:say(string.format("So you would like me to change %d of your crystal coins into %d platinum coins for you?", count[playerId] * 100, count[playerId]), npc, creature)
      npcHandler:setTopic(playerId, 22)
    end
    return true
  end

  if npcHandler:getTopic(playerId) == 22 then
    if MsgContains(message, "yes") then
      if player:removeItem(ITEM_PLATINUM_COIN, count[playerId] * 100) then
        player:addItem(ITEM_CRYSTAL_COIN, count[playerId])
        npcHandler:say("Here you are.", npc, creature)
      else
        npcHandler:say("Sorry, you do not have enough platinum coins.", npc, creature)
      end
    else
      npcHandler:say("Well, can I help you with something else?", npc, creature)
    end
    npcHandler:setTopic(playerId, 0)
    return true
  end

  return false
end

function Npc:parseGuildBank(message, npc, creature, playerId, npcHandler)
  local player = Player(creature)

  if not MsgContains(message, "guild") then
    return false
  end

  local guild = player:getGuild()
  if not guild then
    npcHandler:say("You are not in a guild.", npc, creature)
    npcHandler:setTopic(playerId, 0)
    return true
  end

  if MsgContains(message, "balance") then
    npcHandler:say(string.format("Your guild bank balance is %d gold.", guild:getBankBalance()), npc, creature)
    return true
  end

  if MsgContains(message, "deposit") then
    local amount = getMoneyCount(message)
    if not isValidMoney(amount) or not Bank.hasBalance(player, amount) then
      npcHandler:say("There is not enough gold on your account.", npc, creature)
      npcHandler:setTopic(playerId, 0)
      return true
    end
    if Bank.transferToGuild(player, guild, amount) then
      npcHandler:say(string.format("You have transferred %d gold to your guild bank account.", amount), npc, creature)
    else
      npcHandler:say("Sorry, this transfer is not possible.", npc, creature)
    end
    npcHandler:setTopic(playerId, 0)
    return true
  end

  if MsgContains(message, "withdraw") then
    local amount = getMoneyCount(message)
    if not isValidMoney(amount) or not Bank.hasBalance(guild, amount) then
      npcHandler:say("There is not enough gold on the guild account.", npc, creature)
      npcHandler:setTopic(playerId, 0)
      return true
    end
    if Bank.transfer(guild, player, amount) then
      npcHandler:say(string.format("Here you are, %d gold from your guild bank account.", amount), npc, creature)
    else
      npcHandler:say("Sorry, this transfer is not possible.", npc, creature)
    end
    npcHandler:setTopic(playerId, 0)
    return true
  end

  return false
end
