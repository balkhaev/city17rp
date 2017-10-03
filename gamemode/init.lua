AddCSLuaFile("config/general.lua")
AddCSLuaFile("libs/team.lua")
AddCSLuaFile("libs/group.lua")
AddCSLuaFile("libs/role.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

core = {}

include("config/general.lua")
include("libs/core.lua")
include("libs/team.lua")
include("libs/group.lua")
include("libs/role.lua")
include("shared.lua")

core.init(core.config)

function GM:PlayerLoadout(ply)
  ply:StripWeapons()

  local role = ply:getRole()

  for _, weaponName in role.weapons do
    ply:Give(weaponName)
  end
end

function GM:PlayerSelectSpawn(pl)
  local spawns = ents.FindByClass("info_player_start")
  local random_entry = math.random( #spawns )

  return spawns[ random_entry ]
end

hook.Add("PlayerSpawn", "SpawnPlayer", function(ply)
  if ply:GetPData("NewSpawn") then
    local tab = string.Explode(",", ply:GetPData("NewSpawn"))
    ply:SetPos(Vector(tab[1],tab[2],tab[3]))
  end
end)

concommand.Add("setspawnpoint", function(ply, cmd, args)
  local x,y,z = ply:GetPos().x,ply:GetPos().y,ply:GetPos().z
  ply:SetPData("NewSpawn", x..","..y..","..z)
  ply:PrintMessage(HUD_PRINTCENTER, "Spawnpoint Set, Use removespawnpoint to spawn normally")
end)

concommand.Add("removespawnpoint", function(ply, cmd, args)
  local x,y,z = ply:GetPos().x,ply:GetPos().y,ply:GetPos().z
  ply:SetPData("NewSpawn", x..","..y..","..z)
end)
