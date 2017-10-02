core = {}

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("libs/team.lua")
AddCSLuaFile("libs/group.lua")
AddCSLuaFile("libs/role.lua")

include("shared.lua")
include("libs/team.lua")
include("libs/group.lua")
include("libs/role.lua")

core.team.init(core.config.teams)
core.role.init(core.config.roles)
