core = {}

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("libs/team.lua")
AddCSLuaFile("libs/group.lua")
AddCSLuaFile("libs/role.lua")

include("libs/team.lua")
include("libs/group.lua")
include("libs/role.lua")
include( "shared.lua" )

core.role.init(core.config.roles)
