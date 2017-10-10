util.AddNetworkString("setPlayerRole")
util.AddNetworkString("getPlayerRole")
util.AddNetworkString("receivePlayerRole")
util.AddNetworkString("traderBuy")

net.Receive("setPlayerRole", function(len,ply)
  if not ply:hasAccess("managment") then
    return
  end

  local steamID = net.ReadString()
  local roleName = net.ReadString()

  core.role.setPlayerRole(player.GetBySteamID(steamID), roleName)

  net.Start("receivePlayerRole")
  net.WriteString(ply:SteamID())
  net.WriteString(role.name)
  net.Broadcast()
end)

net.Receive("getPlayerRole", function(len,ply)
  net.Start("receivePlayerRole")
  net.WriteString(ply:SteamID())
  net.WriteString(ply:getRoleName())
  net.Send(ply)
end)

net.Receive("traderBuy", function(len,ply)
  if not ply:hasAccess("trade") then
    return
  end

  local entityType = net.ReadString()
  local entityName = net.ReadString()
  local good = core.good.getGood(entityType, entityName)

  --if good == nil then return end

  local entity = ents.Create(good.entity)
  --if not IsValid( entity ) then return end
  --if not ply:EnoughMoney(amount) then return end

  ply:AddMoney(-good.cost)

  local eyeTrace = ply:GetEyeTrace()

  entity:SetPos( eyeTrace.HitPos )
  entity:Spawn()
end)
