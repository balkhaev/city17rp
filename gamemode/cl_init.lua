core = {}

include("shared.lua")
include("config/general.lua")
include("config/goods.lua")
include("libs/core.lua")
include("libs/utils.lua")
include("libs/role/team.lua")
include("libs/role/group.lua")
include("libs/role/role.lua")
include("libs/player.lua")
include("libs/client/hud.lua")
include("libs/client/panel.lua")

core.init(core.config)

hook.Add ("Think", "PlayerReady", function ()
  if not IsValid (LocalPlayer()) then return end

  net.Receive("startedPoll", function()
    local pollQuestion = net.ReadString()

    core.panel.createPoll(pollQuestion)
  end)

  hook.Remove ("Think", "PlayerReady")
end)

include("cl_hud.lua")
include("cl_panel.lua")
