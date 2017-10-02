core = {}

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile("libs/team.lua")
AddCSLuaFile("libs/group.lua")
AddCSLuaFile("libs/role.lua")

core.role.init(core.config.roles)

include( "shared.lua" )
