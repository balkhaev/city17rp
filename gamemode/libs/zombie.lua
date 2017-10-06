core.zombie = {}
core.zombie.spawnPos = { Vector(87.167327880859,5650.2534179688,-463.96875), Vector(92.311859130859,7093.9091796875,-465.96875) }
core.zombie.timer = 0

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
end

function core.zombie.needSpawn()
  return core.zombie.timer < CurTime() and core.zombie.count <= core.config.defaults.zombieLimit
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
