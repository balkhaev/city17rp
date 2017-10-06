core = {}

include("shared.lua")
include("config/general.lua")
include("libs/core.lua")
include("libs/role/team.lua")
include("libs/role/group.lua")
include("libs/role/role.lua")
include("libs/player.lua")
include("libs/hud.lua")
include("libs/panel.lua")

core.init(core.config)

net.Receive("setPlayerRole", function()
  local steamID = net.ReadString()
  local roleName = net.ReadString()

  core.role.setPlayerRole(player:getPlayerBySteamID(steamID), roleName)
end)

-- include("cl_hud.lua")
include("cl_panel.lua")
