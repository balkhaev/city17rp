core.zombie = {}
core.zombie.spawnPos = { Vector(87.167327880859,5650.2534179688,-463.96875), Vector(92.311859130859,7093.9091796875,-465.96875) }
core.zombie.count = 0
core.zombie.timer = 0
core.zombie.isEvent = false

GM:OnNPCKilled( function(npc, attacker, inflictor )

end)

function core.zombie.spawnZombie()
  local spawnpos = table.Random( core.zombie.spawnPos )

  local zombie = ents.Create( "npc_zombie" )
  zombie:SetPos( spawnpos )
  zombie:SetName("zombie")
  zombie:Spawn()

  local ply = core.zombie.getNearestPlayer(zombie)
  local plypos = ply:GetPos()
  zombie:SetLastPosition(plypos)
  zombie:SetEnemy(ply)
  zombie:UpdateEnemyMemory( ply, plypos )
  zombie:SetSchedule( SCHED_CHASE_ENEMY  )

  core.zombie.count = core.zombie.count + 1
end

function core.zombie.needSpawn()
  --[[
  if core.zombie.isEvent then

  end
  ]]--
  return core.zombie.timer < CurTime() and core.zombie.count <= core.config.defaults.zombieLimit
end

function core.zombie.isLimit()
  if core.zombie.isEvent then
    return true
  end

  local isZombieLimit = core.zombie.count <= core.config.defaults.zombieLimit

  if isZombieLimit then
    core.zombie.startEvent()
  end

  return isZombieLimit
end

function core.zombie.startEvent()
  core.zombie.isEvent = true
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
