AddCSLuaFile("config/general.lua")
AddCSLuaFile("libs/core.lua")
AddCSLuaFile("libs/team.lua")
AddCSLuaFile("libs/group.lua")
AddCSLuaFile("libs/role.lua")
AddCSLuaFile("libs/player.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

core = {}

include("config/general.lua")
include("libs/core.lua")
include("libs/team.lua")
include("libs/group.lua")
include("libs/role.lua")
include("libs/player.lua")
include("shared.lua")

core.init(core.config)

function GM:PlayerLoadout(ply)
  ply:StripWeapons()

  local role = ply:getRole()

  for _, weaponName in role.weapons do
    ply:Give(weaponName)
  end
end

hook.Add("PlayerSpawn", "SpawnPlayer", function(ply)
  local group = ply:getGroup()

  if group.spawn and group.spawn ~= "" then
    local tab = string.Explode(",", group.spawn)
    ply:SetPos(Vector(tab[1],tab[2],tab[3]))
  end
end)

concommand.Add("getspawnpoint", function(ply, cmd, args)
  local x,y,z = ply:GetPos().x,ply:GetPos().y,ply:GetPos().z
  Msg(x..","..y..","..z)
end)
