-- Comissario Eleitoral (Canary / ravscript) — com NpcSystem (canal NPC)

-----------------------------
-- CONFIG RÁPIDA
-----------------------------
local CFG = {
  MAX_PRES_CAND_PER_KINGDOM = 3,
  MAX_GOV_CAND_PER_KINGDOM  = 5,
  COOLDOWN_DAYS             = 30,
  RESIDENCY_MIN_DAYS_GOV    = 6,
  KINGDOM_NAMES             = { [1]="Norte", [2]="Oeste", [3]="Sul", [4]="Leste" },
}

--------------------------------
-- NPC BASE
--------------------------------
local internalNpcName = "Comissario Eleitoral"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName
npcConfig.health = 100
npcConfig.maxHealth = 100
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2
npcConfig.outfit = { lookType = 140, lookHead = 77, lookBody = 81, lookLegs = 79, lookFeet = 95, lookAddons = 0 }
npcConfig.flags = { floorchange = false }

-- NpcSystem (pra canal NPC)
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval) npcHandler:onThink(npc, interval) end
npcType.onAppear = function(npc, creature) npcHandler:onAppear(npc, creature) end
npcType.onDisappear = function(npc, creature) npcHandler:onDisappear(npc, creature) end
npcType.onMove = function(npc, creature, fromPos, toPos) npcHandler:onMove(npc, creature, fromPos, toPos) end
npcType.onSay = function(npc, creature, type, message) npcHandler:onSay(npc, creature, type, message) end
npcType.onCloseChannel = function(npc, creature) npcHandler:onCloseChannel(npc, creature) end

npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo, |PLAYERNAME|. Diga {ajuda} para instrucoes.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Boa sorte, cidadao.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Proximo!")

-- respostas sempre no canal do NPC
local function reply(npc, creature, text)
  npcHandler:say(text, npc, creature) -- canal privado do NPC
end

--------------------------------
-- HELPERS DB / UTIL
--------------------------------
local function esc(s) return db.escapeString(s) end
local function qf(s, ...) return string.format(s, ...) end

local function safeGetString(r, col) local ok,v=pcall(result.getString,r,col); return ok and v or nil end
local function safeGetNumber(r, col) local ok,v=pcall(result.getNumber,r,col); return ok and v or nil end

local function fetchOne(query)
  local r = db.storeQuery(query); if not r then return nil end
  local row = {
    id = safeGetNumber(r,"id"), name = safeGetString(r,"name"), level = safeGetNumber(r,"level"),
    kingdom = safeGetNumber(r,"kingdom"), kingdom_since = safeGetString(r,"kingdom_since"),
    week_iso = safeGetString(r,"week_iso"), status = safeGetString(r,"status"),
    next_eligible_ts = safeGetString(r,"next_eligible_ts"),
  }
  result.free(r); return row
end

local function fetchNum(query, col)
  local r = db.storeQuery(query); if not r then return 0 end
  local v = result.getNumber(r, col or "n"); result.free(r); return v
end

local function isoWeekKey(ts) return os.date("!%GW%V", ts) end

local function getCurrentCycle()
  local key = isoWeekKey(os.time())
  local row = fetchOne(qf("SELECT * FROM election_cycle WHERE week_iso=%s", esc(key)))
  if row then return row end
  return fetchOne("SELECT * FROM election_cycle WHERE status IN ('CANDIDACY','VOTING') ORDER BY id DESC LIMIT 1")
end

local function playerInfo(player)
  local r = db.storeQuery(qf("SELECT id,name,level,kingdom,kingdom_since,account_id FROM players WHERE id=%d", player:getGuid()))
  if not r then
    return { pid=player:getGuid(), name=player:getName(), level=player:getLevel(), acc=player:getAccountId(), kingdom=0, since=nil, kname="Neutro" }
  end
  local pid = result.getNumber(r,"id"); local nm = result.getString(r,"name"); local lvl = result.getNumber(r,"level")
  local k = result.getNumber(r,"kingdom"); local ks = result.getString(r,"kingdom_since"); local acc = result.getNumber(r,"account_id")
  result.free(r)
  return { pid=pid, name=nm, level=lvl, acc=acc, kingdom=k, since=ks, kname = CFG.KINGDOM_NAMES[k] or "Neutro" }
end

local function residencyDays(sinceStr)
  if not sinceStr then return 0 end
  local y,mo,d,hh,mm,ss = sinceStr:match("(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)")
  local t = os.time{year=y, month=mo, day=d, hour=hh, min=mm, sec=ss}
  return math.floor((os.time() - t)/86400)
end

--------------------------------
-- LÓGICA
--------------------------------
local function listCandidates(office, realm)
  local cyc = getCurrentCycle(); if not cyc then return {} end
  local out, sql = {}, nil
  if office == "PRESIDENT" then
    sql = qf([[SELECT c.id, p.name, c.kingdom
               FROM election_candidate c JOIN players p ON p.id=c.player_id
               WHERE c.cycle_id=%d AND c.office='PRESIDENT'
               ORDER BY c.kingdom, p.name]], tonumber(cyc.id))
  else
    sql = qf([[SELECT c.id, p.name, c.kingdom
               FROM election_candidate c JOIN players p ON p.id=c.player_id
               WHERE c.cycle_id=%d AND c.office='GOVERNOR' AND c.kingdom=%d
               ORDER BY p.name]], tonumber(cyc.id), realm)
  end
  local r = db.storeQuery(sql); if not r then return out end
  repeat
    table.insert(out, { id = result.getNumber(r,"id"), name = result.getString(r,"name"), kingdom = result.getNumber(r,"kingdom") })
  until not result.next(r)
  result.free(r); return out
end

local function findCandidateIdByName(office, realm, name)
  local cyc = getCurrentCycle(); if not cyc then return nil end
  local sql
  if office == "PRESIDENT" then
    sql = qf([[SELECT c.id FROM election_candidate c
               JOIN players p ON p.id=c.player_id
               WHERE c.cycle_id=%d AND c.office='PRESIDENT' AND LOWER(p.name)=LOWER(%s)]],
               tonumber(cyc.id), esc(name))
  else
    sql = qf([[SELECT c.id, c.kingdom FROM election_candidate c
               JOIN players p ON p.id=c.player_id
               WHERE c.cycle_id=%d AND c.office='GOVERNOR' AND LOWER(p.name)=LOWER(%s)]],
               tonumber(cyc.id), esc(name))
  end
  local r = db.storeQuery(sql); if not r then return nil end
  local id = result.getNumber(r,"id"); local k = safeGetNumber(r,"kingdom"); result.free(r)
  return id, k
end

local function canRun(player, office)
  local me = playerInfo(player)
  local cyc = getCurrentCycle(); if not cyc then return false, "Sem ciclo ativo." end
  if cyc.status ~= "CANDIDACY" then return false, "Candidaturas fechadas." end
  if me.kingdom < 1 or me.kingdom > 4 then return false, "Defina seu reino antes." end

  local cd = fetchOne(qf("SELECT next_eligible_ts FROM office_cooldown WHERE account_id=%d AND office=%s", me.acc, esc(office)))
  if cd and cd.next_eligible_ts then
    local y,mo,d,hh,mm,ss = cd.next_eligible_ts:match("(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)")
    local nextTs = os.time{year=y, month=mo, day=d, hour=hh, min=mm, sec=ss}
    if os.time() < nextTs then return false, "Voce esta em cooldown para este cargo." end
  end

  local already = fetchNum(qf("SELECT COUNT(1) n FROM election_candidate WHERE cycle_id=%d AND player_id=%d", tonumber(cyc.id), me.pid))
  if already > 0 then return false, "Voce ja esta inscrito em um cargo nesta semana." end

  if office == "PRESIDENT" then
    local cnt = fetchNum(qf("SELECT COUNT(1) n FROM election_candidate WHERE cycle_id=%d AND office='PRESIDENT' AND kingdom=%d", tonumber(cyc.id), me.kingdom))
    if cnt >= CFG.MAX_PRES_CAND_PER_KINGDOM then return false, "Limite de candidatos a presidente do seu reino atingido." end
  else
    if residencyDays(me.since) < CFG.RESIDENCY_MIN_DAYS_GOV then return false, "Precisa morar no seu reino ha pelo menos 6 dias." end
    local cnt = fetchNum(qf("SELECT COUNT(1) n FROM election_candidate WHERE cycle_id=%d AND office='GOVERNOR' AND kingdom=%d", tonumber(cyc.id), me.kingdom))
    if cnt >= CFG.MAX_GOV_CAND_PER_KINGDOM then return false, "Limite de candidatos a governador do seu reino atingido." end
  end
  return true
end

local function registerCandidate(player, office)
  local ok, msg = canRun(player, office); if not ok then return false, msg end
  local me  = playerInfo(player); local cyc = getCurrentCycle()
  db.query(qf("INSERT INTO election_candidate (cycle_id,office,kingdom,player_id,account_id) VALUES (%d,%s,%d,%d,%d)",
              tonumber(cyc.id), esc(office), me.kingdom, me.pid, me.acc))
  return true, ("Inscricao registrada: %s (%s) pelo Reino %s."):format(me.name, office, CFG.KINGDOM_NAMES[me.kingdom] or "?")
end

local function canVote(player, office)
  local cyc = getCurrentCycle(); if not cyc then return false, "Sem ciclo ativo." end
  if cyc.status ~= "VOTING" then return false, "Votacao fechada." end
  local me = playerInfo(player)
  if office == "GOVERNOR" and (me.kingdom < 1 or me.kingdom > 4) then return false, "Voce nao pertence a um reino." end
  local has = fetchNum(qf("SELECT COUNT(1) n FROM election_vote WHERE cycle_id=%d AND office=%s AND voter_account_id=%d", tonumber(cyc.id), esc(office), me.acc))
  if has > 0 then return false, "Voce ja votou neste cargo." end
  return true
end

local function castVote(player, office, targetName)
  local ok, msg = canVote(player, office); if not ok then return false, msg end
  local me = playerInfo(player); local cyc = getCurrentCycle()
  local realm = (office == "PRESIDENT") and 0 or me.kingdom
  local cid, ckingdom = findCandidateIdByName(office, (realm==0 and nil or realm), targetName)
  if not cid then return false, "Candidato nao encontrado." end
  if office == "GOVERNOR" and tonumber(ckingdom) ~= me.kingdom then return false, "So pode votar no governador do SEU reino." end
  db.query(qf("INSERT INTO election_vote (cycle_id,office,kingdom,voter_player_id,voter_account_id,candidate_id) VALUES (%d,%s,%s,%d,%d,%d)",
              tonumber(cyc.id), esc(office), (realm==0 and "NULL" or tostring(realm)), me.pid, me.acc, cid))
  return true, ("Voto computado para %s."):format(targetName)
end

--------------------------------
-- CALLBACK do NpcSystem (canal NPC)
--------------------------------
local function handleMessage(npc, creature, msg)
  local player = Player(creature); if not player then return true end
  local p = msg:lower()

  if p == "ajuda" or p == "help" then
    reply(npc, creature, "Comandos: {status}, {lista presidente}, {lista governador}, {candidatar presidente}, {candidatar governador}, {votar presidente <nome>}, {votar governador <nome>}.");
    return true
  end

  if p == "status" then
    local cyc = getCurrentCycle()
    if not cyc then reply(npc, creature, "Sem ciclo ativo."); return true end
    reply(npc, creature, ("Ciclo %s. Fase: %s."):format(cyc.week_iso or "?", cyc.status or "?"))
    return true
  end

  if p == "lista presidente" then
    local list = listCandidates("PRESIDENT")
    if #list == 0 then reply(npc, creature, "Sem candidatos a presidente."); return true end
    for _,c in ipairs(list) do
      reply(npc, creature, ("Presidente: %s (Reino %s)"):format(c.name, CFG.KINGDOM_NAMES[c.kingdom] or "?"))
    end
    return true
  end

  if p == "lista governador" then
    local me = playerInfo(player)
    if me.kingdom < 1 or me.kingdom > 4 then reply(npc, creature, "Voce nao pertence a um reino."); return true end
    local list = listCandidates("GOVERNOR", me.kingdom)
    if #list == 0 then reply(npc, creature, "Sem candidatos a governador do seu reino."); return true end
    for _,c in ipairs(list) do
      reply(npc, creature, ("Governador: %s (seu reino)"):format(c.name))
    end
    return true
  end

  if p == "candidatar presidente" then
    local ok,txt = registerCandidate(player, "PRESIDENT")
    reply(npc, creature, ok and txt or ("Falhou: "..txt)); return true
  end
  if p == "candidatar governador" then
    local ok,txt = registerCandidate(player, "GOVERNOR")
    reply(npc, creature, ok and txt or ("Falhou: "..txt)); return true
  end

  local vp = p:match("^votar presidente%s+(.+)$")
  if vp then
    local ok,txt = castVote(player, "PRESIDENT", vp)
    reply(npc, creature, ok and txt or ("Falhou: "..txt)); return true
  end
  local vg = p:match("^votar governador%s+(.+)$")
  if vg then
    local ok,txt = castVote(player, "GOVERNOR", vg)
    reply(npc, creature, ok and txt or ("Falhou: "..txt)); return true
  end

  reply(npc, creature, "Nao entendi. Diga {ajuda}.")
  return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, function(npc, creature, type, msg)
  return handleMessage(npc, creature, msg)
end)

-- foco/“hi”
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- registrar
npcType:register(npcConfig)
