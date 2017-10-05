AddCSLuaFile("shared.lua")
AddCSLuaFile("config/general.lua")
AddCSLuaFile("libs/core.lua")
AddCSLuaFile("libs/role/team.lua")
AddCSLuaFile("libs/role/group.lua")
AddCSLuaFile("libs/role/role.lua")
AddCSLuaFile("libs/player.lua")
AddCSLuaFile("libs/hud.lua")
AddCSLuaFile("libs/panel.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_panel.lua")

core = {}

include("config/general.lua")
include("libs/core.lua")
include("libs/role/team.lua")
include("libs/role/group.lua")
include("libs/role/role.lua")
include("libs/player.lua")
include("sv_commands.lua")
include("shared.lua")

core.init(core.config)

util.AddNetworkString("setPlayerRole")

function GM:PlayerInitialSpawn(ply)
  ply.SID = ply:UserID()

  if not core.role.existsPlayerRole(ply) then
    if ply:GetPData("role") then
      core.role.setPlayerRole(ply, ply:GetPData("role"))
    else
      core.role.setPlayerRole(ply, core.config.defaults.role)
    end
  end

  local cash = ply:GetPData("money")

  if cash == nil then
    ply:SetPData("money", core.config.defaults.money)
    ply:SetMoney( core.config.defaults.money )
  else
    ply:SetMoney( cash )
  end
end

function GM:PlayerLoadout(ply)
  core.role.giveRoleItems(ply, ply:getRoleName())
end

function GM:PlayerSetModel( ply )
  local role = ply:getRole()
  ply:SetModel(role.model)
end

hook.Add("PlayerSpawn", "SpawnPlayer", function(ply)
  local group = ply:getGroup()

  Msg("Player ", ply:Nick(), " spawn on ", group.spawn, "\n")

  if group.spawn and group.spawn ~= "" then
    local tab = string.Explode(",", group.spawn)
    ply:SetPos(Vector(tab[1],tab[2],tab[3]))
  end
end)

--[[
function GetNearestPlayer(zombie)
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

local zombie = ents.Create("npc_zombie")
zombie:SetPos(Vector)
zombie:SetName("zombie")
zombie:Spawn()
local ply = GetNearestPlayer(zombie)
local plypos = ply:GetPos()
zombie:SetLastPosition(plypos)
zombie:SetEnemy(ply)
zombie:UpdateEnemyMemory( ply, plypos )
zombie:SetSchedule( SCHED_CHASE_ENEMY  )
--]]
local zombieSpawnPos = { Vector(0,0,0), Vector(0,200,0) }
hook.Add( "Think", "ZombieSpawner", function()
  if ( self.ZombieTimer or 0 ) < CurTime() then
    self.ZombieTimer = CurTime() + 10

    local spawnpos = table.Random( zombieSpawnPos )

    local zombie = ents.Create( "npc_zombie" )
    zombie:SetPos( spawnpos )
    zombie:Spawn()
  end
end)
