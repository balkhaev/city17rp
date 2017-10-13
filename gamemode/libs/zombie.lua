core.zombie = {}
core.zombie.spawnPos = { "87.167327880859,5650.2534179688,-463.96875", "92.311859130859,7093.9091796875,-465.96875","1390.6419677734,6618.8603515625,-435.72940063477","1049.6564941406,5010.859375,-465.96875","2000.3262939453,3035.2922363281,-465.96875" }
core.zombie.timer = 0
core.zombie.isEvent = false

function core.zombie.spawnZombie(spawnVector)
  local zombie = ents.Create( "npc_zombie" )
  zombie:SetPos( spawnVector )
  zombie:SetName("zombie")
  zombie:Spawn()

  local ply = core.zombie.getNearestPlayer(zombie)

  if ply ~= NULL then
    local plypos = ply:GetPos()
    zombie:SetLastPosition(plypos)
    zombie:SetEnemy(ply)
    zombie:UpdateEnemyMemory( ply, plypos )
    zombie:SetSchedule( SCHED_CHASE_ENEMY  )
  end
end

function core.zombie.needSpawn()
  return core.zombie.timer < CurTime()
end

function core.zombie.getZombieCount()
  local zombieTable = ents.FindByClass( "npc_zombie" )
  return zombieTable.Count
end

function core.zombie.isLimit()
  return core.zombie.getZombieCount() >= core.config.defaults.zombieLimit
end

function core.zombie.isMinLimit()
  return core.zombie.getZombieCount() <= core.config.defaults.minZombieLimit
end

function core.zombie.getTimout()
  if core.zombie.isEvent then
    return 5
  else
    return 10
  end
end

function core.zombie.startEvent()
  core.zombie.isEvent = true
end

function core.zombie.endEvent()
  core.zombie.isEvent = false
end

function core.zombie.getNearestPlayer(zombie)
  local distance = 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999
  local zombiepos = zombie:GetPos()
  local target = NULL

  for _, v in pairs(player.GetAll()) do
    local plydistance = v:GetPos():Distance(zombiepos)

    if plydistance < distance then
      distance = plydistance
      target = v

    end

  end

  return target
end
