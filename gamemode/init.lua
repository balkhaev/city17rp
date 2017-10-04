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
-- AddCSLuaFile("cl_hud.lua")
-- AddCSLuaFile("cl_panel.lua")

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
  -- core.role.giveRoleItems(ply, ply:getRoleName())
end

--[[
hook.Add("PlayerSpawn", "SpawnPlayer", function(ply)
  local group = ply:getGroup()

  Msg("Player ", ply:Nick(), " spawn on ", group.spawn, "\n")

  if group.spawn and group.spawn ~= "" then
    local tab = string.Explode(",", group.spawn)
    ply:SetPos(Vector(tab[1],tab[2],tab[3]))
  end
end)
--]]

concommand.Add("getspawnpoint", function(ply, cmd, args)
  local x,y,z = ply:GetPos().x,ply:GetPos().y,ply:GetPos().z
  Msg(x..","..y..","..z)
end)

concommand.Add("setrole", function(ply, cmd, args)
  if args[1] == nil then
    return
  end
  if args[2] ~= nil then
    core.role.setPlayerRole(ply:getPlayerByName(args[1]), args[2])
    return
  end

  core.role.setPlayerRole(ply, args[1])
end)
