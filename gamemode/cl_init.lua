core = {}

include("shared.lua")
include("config/general.lua")
include("config/goods.lua")
include("libs/core.lua")
include("libs/utils.lua")
include("libs/role/team.lua")
include("libs/role/group.lua")
include("libs/role/role.lua")
include("client/libs/hud.lua")
include("client/libs/panel.lua")
include("sh_player.lua")

core.init(core.config)

hook.Add ("Think", "PlayerReady", function ()
  if not IsValid (LocalPlayer()) then return end

  include("client/cl_hud.lua")
  include("client/cl_panel.lua")
  include("client/cl_network.lua")

  hook.Remove ("Think", "PlayerReady")
end)

