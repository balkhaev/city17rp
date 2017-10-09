core = {}

include("shared.lua")
include("config/general.lua")
include("config/goods.lua")
include("libs/core.lua")
include("libs/role/team.lua")
include("libs/role/group.lua")
include("libs/role/role.lua")
include("libs/player.lua")
include("libs/hud.lua")
include("libs/panel.lua")
include("libs/utils.lua")

core.init(core.config)

hook.Add ("Think", "PlayerReady", function ()
  if IsValid (LocalPlayer()) then
    net.Start("getPlayerRole")
    net.SendToServer()

    net.Receive("receivePlayerRole", function()
      local steamID = net.ReadString()
      local roleName = net.ReadString()

      core.role.setPlayerRole(player.GetBySteamID(steamID), roleName)
    end)

    hook.Remove ("Think", "PlayerReady")
  end
end)


-- include("cl_hud.lua")
include("cl_panel.lua")
