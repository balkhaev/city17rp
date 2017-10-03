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

function GM:PlayerInitialSpawn( ply )
  ply:ConCommand( "team_menu" )
end

function GM:PlayerLoadout(ply)
  ply:StripWeapons()

  local role = core.role.getPlayerRole(ply)
  
  if not role then
    role = core.role.setRole(ply, core.config.defaults.role)
  end
  
  for _, weaponName in role.weapons do
    ply:Give(weaponName)
  end
end
