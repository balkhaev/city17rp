core = {}

include("shared.lua")
include("libs/utils.lua")
include("config/gamemode.lua")
include("client/libs/hud.lua")
include("client/libs/panel.lua")
include("sh_player.lua")

hook.Add ("Think", "PlayerReady", function ()
  if not IsValid (LocalPlayer()) then return end

  hook.Remove ("Think", "PlayerReady")
end)

function GM:DrawDeathNotice( x, y )
end

function GM:HUDDrawTargetID()
end

include("client/cl_hud.lua")
include("client/cl_panel.lua")
include("client/cl_network.lua")
