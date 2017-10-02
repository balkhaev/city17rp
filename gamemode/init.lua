core = {}

AddCSLuaFile("config/general.lua")
AddCSLuaFile("libs/team.lua")
AddCSLuaFile("libs/group.lua")
AddCSLuaFile("libs/role.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("config/general.lua")
include("libs/team.lua")
include("libs/group.lua")
include("libs/role.lua")
include("shared.lua")

core.team.init(core.config.teams)
core.role.init(core.config.roles)

function GM:PlayerInitialSpawn( ply )
  ply:ConCommand( "team_menu" )
end

function GM:PlayerLoadout(ply)
  ply:StripWeapons()

  if ply:Team() == 1 then
    ply:Give("weapon_physcannon")
  elseif ply:Team() == 2 then
    ply:Give("weapon_physgun")
  end
end
 
function team_1( ply ) 
  ply:SetTeam( 1 )
  ply:Spawn()
end 
 
function team_2( ply ) 
  ply:SetTeam( 2 )
  ply:Spawn()
end 
 
concommand.Add( "team_1", team_1 )
concommand.Add( "team_2", team_2 )
