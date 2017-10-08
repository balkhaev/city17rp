util.AddNetworkString("setPlayerRole")
util.AddNetworkString("getPlayerRole")
util.AddNetworkString("receivePlayerRole")

net.Receive("setPlayerRole", function(len,ply)
  if not ply:hasAccess("managment") then
    return
  end

  local steamID = net.ReadString()
  local roleName = net.ReadString()

  core.role.setPlayerRole(player.GetBySteamID(steamID), roleName)
end)

net.Receive("getPlayerRole", function(len,ply)
  net.Start("receivePlayerRole")
  net.WriteString(ply:SteamID())
  net.WriteString(ply:getRoleName())
  net.Send(ply)
end)

net.Receive("createDrone", function()
  local droneName = net.ReadString()
  local dronePos = string.Explode(",", net.ReadString())

  local drone = ents.Create(droneName)
  if not IsValid( drone ) then return end
  drone:SetPos( Vector( dronePos ) )
  drone:Spawn()
end)