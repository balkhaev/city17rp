AddCSLuaFile("config/general.lua")
AddCSLuaFile("libs/core.lua")
AddCSLuaFile("libs/role/team.lua")
AddCSLuaFile("libs/role/group.lua")
AddCSLuaFile("libs/role/role.lua")
AddCSLuaFile("libs/player.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

core = {}

include("config/general.lua")
include("libs/core.lua")
include("libs/role/team.lua")
include("libs/role/group.lua")
include("libs/role/role.lua")
include("libs/player.lua")
include("shared.lua")

core.init(core.config)

function GM:PlayerLoadout(ply)
  ply:StripWeapons()

  local role = ply:getRole()
  Msg("===== Loadout Player======\n")
  PrintTable(role)

  for _, weaponName in pairs(role.weapons) do
    ply:Give(weaponName)
  end
end

hook.Add("PlayerSpawn", "SpawnPlayer", function(ply)
  local group = ply:getGroup()
    
  Msg("Player ", ply:Nick(), " spawn on ", group.spawn, "\n")

  if group.spawn and group.spawn ~= "" then
    local tab = string.Explode(",", group.spawn)
    ply:SetPos(Vector(tab[1],tab[2],tab[3]))
  end
end)

concommand.Add("getspawnpoint", function(ply, cmd, args)
  local x,y,z = ply:GetPos().x,ply:GetPos().y,ply:GetPos().z
  Msg(x..","..y..","..z)
end)
