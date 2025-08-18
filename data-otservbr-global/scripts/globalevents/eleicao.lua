-- elections.rav (Canary / ravscript) — FIX: usar :day() + :time() com onTime

local Cfg = {
  enabled = true,

  vacancyWeekday = 1, -- 1 = domingo (os.date().wday)

  -- agenda semanal
  -- sábado abre candidaturas, domingo abre/fecha votação
  day6CandidacyHour = 12,
  day7VotingStartHour = 12,
  day7VotingEndHour = 21,

  -- limites
  maxPresCandPerKingdom = 3,
  maxGovCandPerKingdom  = 5,
  cooldownDays          = 30,

  -- quórum (0 desliga)
  presQuorumAbs = 0,
  presQuorumPct = 0.00,
  govQuorumAbs  = 0,
  govQuorumPct  = 0.00,
  eligibleWindowDays = 7,

  -- desempate
  tiebreak = { "REPUTATION", "EARLIEST_REG", "PLAYER_LEVEL" },

  -- NPC (capitais) – preencha coords depois
  npcName = "Comissario Eleitoral",
  npcPos = {
    NORTE = {x=32379,y=32241,z=7},
    OESTE = {x=32908,y=32072,z=7},
    SUL   = {x=32685,y=31691,z=6},
    LESTE = {x=33211,y=32460,z=8},
  },
  kingdomNames = { [1]="Norte",[2]="Oeste",[3]="Sul",[4]="Leste" },
}

-- ===== util =====
local function now() return os.time() end
local function isoWeekKey(ts) return os.date("!%GW%V", ts) end
local function qf(s, ...) return string.format(s, ...) end
local function esc(s) return db.escapeString(s) end

local function ensureCycle(ts)
  local key = isoWeekKey(ts)
  local r = db.storeQuery(qf("SELECT id FROM election_cycle WHERE week_iso=%s", esc(key)))
  if r then return result.getNumber(r, "id") end

  -- base: segunda 00:00 UTC
  local t = os.date("!*t", ts)
  local wday = t.wday -- 1=Sun..7=Sat
  local deltaToMon = (wday == 1) and 1 or ((9 - wday) % 7)
  local monday00 = os.time{year=t.year, month=t.month, day=t.day + deltaToMon - 1, hour=0}
  local saturday  = monday00 + 5*24*3600
  local sunday    = monday00 + 6*24*3600

  local candOpen  = saturday + Cfg.day6CandidacyHour*3600
  local voteOpen  = sunday   + Cfg.day7VotingStartHour*3600
  local voteClose = sunday   + Cfg.day7VotingEndHour*3600

  db.query(qf([[
    INSERT INTO election_cycle
      (week_iso,start_ts,candidacy_open_ts,voting_open_ts,voting_close_ts,status,
       pres_quorum_abs,pres_quorum_pct,gov_quorum_abs,gov_quorum_pct)
    VALUES (%s, FROM_UNIXTIME(%d), FROM_UNIXTIME(%d), FROM_UNIXTIME(%d), FROM_UNIXTIME(%d), 'PLANNED',
            %d, %.2f, %d, %.2f)
  ]], esc(key), monday00, candOpen, voteOpen, voteClose,
      Cfg.presQuorumAbs, Cfg.presQuorumPct, Cfg.govQuorumAbs, Cfg.govQuorumPct))

  local r2 = db.storeQuery(qf("SELECT id FROM election_cycle WHERE week_iso=%s", esc(key)))
  return result.getNumber(r2, "id")
end

local function setCycleStatus(id, status)
  db.query(qf("UPDATE election_cycle SET status=%s WHERE id=%d", esc(status), id))
end

-- ===== ações =====
local function actionVacancy()
  if not Cfg.enabled then return true end
  -- zera cargos; roda no domingo cedo
  db.query("UPDATE players SET is_president=0, is_governor=0;")
  return true
end

local function actionOpenCandidacy()
  if not Cfg.enabled then return true end
  local cid = ensureCycle(now())
  setCycleStatus(cid, 'CANDIDACY')
  Game.broadcastMessage("[Eleicoes] Candidaturas abertas. Procure o Comissario Eleitoral nas capitais.", MESSAGE_EVENT_ADVANCE)
  return true
end

local function actionOpenVoting()
  if not Cfg.enabled then return true end
  local cid = ensureCycle(now())
  setCycleStatus(cid, 'VOTING')
  Game.broadcastMessage("[Eleicoes] Votacao aberta. Encerra hoje no horario configurado.", MESSAGE_EVENT_ADVANCE)
  return true
end

local function appointWinners(cycleId)
  -- TODO: apurar votos (+quorum, desempate), aplicar cargos e cooldown
end

local function actionCloseVotingAndAppoint()
  if not Cfg.enabled then return true end
  local cid = ensureCycle(now())
  Game.broadcastMessage("[Eleicoes] Encerradas. Apurando resultados...", MESSAGE_EVENT_ADVANCE)
  appointWinners(cid)
  setCycleStatus(cid, 'CLOSED')
  return true
end

-- ===== registro correto dos globalevents =====

-- ===== registro dos eventos (sem XML) =====

-- VAGAS: roda todo dia 00:05, mas só executa se for domingo
local vacancy = GlobalEvent("elections_vacancy")
function vacancy.onTime()
  if not Cfg.enabled then return true end
  local w = os.date("*t")
  if w.wday == Cfg.vacancyWeekday then
    return actionVacancy()
  end
  return true
end
vacancy:time("00:05")
vacancy:register()

-- CANDIDATURAS: roda todo dia HH:00, executa só sábado
local cand = GlobalEvent("elections_open_candidacy")
function cand.onTime()
  if not Cfg.enabled then return true end
  local w = os.date("*t")
  if w.wday == 7 then -- sábado
    return actionOpenCandidacy()
  end
  return true
end
cand:time(string.format("%02d:00", Cfg.day6CandidacyHour))
cand:register()

-- ABRIR VOTAÇÃO: roda todo dia HH:00, executa só domingo
local voteOpen = GlobalEvent("elections_open_voting")
function voteOpen.onTime()
  if not Cfg.enabled then return true end
  local w = os.date("*t")
  if w.wday == 1 then -- domingo
    return actionOpenVoting()
  end
  return true
end
voteOpen:time(string.format("%02d:00", Cfg.day7VotingStartHour))
voteOpen:register()

-- FECHAR/APURAR: roda todo dia HH:00, executa só domingo
local voteClose = GlobalEvent("elections_close_voting")
function voteClose.onTime()
  if not Cfg.enabled then return true end
  local w = os.date("*t")
  if w.wday == 1 then -- domingo
    return actionCloseVotingAndAppoint()
  end
  return true
end
voteClose:time(string.format("%02d:00", Cfg.day7VotingEndHour))
voteClose:register()

-- Spawn do Comissario nas capitais ao iniciar o servidor
local spawnNpc = GlobalEvent("elections_spawn_npc")
function spawnNpc.onStartup()
  if not Cfg.enabled then return true end
  for _, pos in pairs(Cfg.npcPos) do
    local p = Position(pos.x, pos.y, pos.z)
    local npc = Game.createNpc(Cfg.npcName, p)
    if npc then
      npc:setMasterPos(p)
      p:sendMagicEffect(CONST_ME_TELEPORT)
    end
  end
  return true
end
spawnNpc:register()

