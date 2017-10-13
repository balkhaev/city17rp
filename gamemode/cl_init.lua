core = {}

include("shared.lua")
include("client/libs/hud.lua")
include("client/libs/panel.lua")
include("sh_player.lua")

hook.Add ("Think", "PlayerReady", function ()
  if not IsValid (LocalPlayer()) then return end

  hook.Remove ("Think", "PlayerReady")
end)

include("client/cl_hud.lua")
include("client/cl_panel.lua")
include("client/cl_network.lua")
