util.AddNetworkString("setPlayerRole")
util.AddNetworkString("getPlayerRole")
util.AddNetworkString("receivePlayerRole")
util.AddNetworkString("tradeBuy")
util.AddNetworkString("createEntity")

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

net.Receive("createEntity", function(len,ply)
  if not ply:hasAccess("trade") then
    return
  end

  local ammoName = net.ReadString()
  local eyeTrace = ply:GetEyeTrace()

  local entity = ents.Create(ammoName)
  if not IsValid( entity ) then return end
  entity:SetPos( eyeTrace.HitPos )
  entity:Spawn()
end)
