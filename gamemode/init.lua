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

  local role
  local roleIndex = core.role.indexPlayerRole(ply)

  if roleIndex == -1 then
    role = core.role.setRole(ply, core.config.defaults.role)
  else
    role = core.role.getPlayerRole(ply)
  end

  for _, weaponName in role.weapons do
    ply:Give(weaponName)
  end
end
