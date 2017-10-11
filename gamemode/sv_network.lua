util.AddNetworkString("setPlayerRole")
util.AddNetworkString("getPlayerRoles")
util.AddNetworkString("receivePlayerRoles")
util.AddNetworkString("getTraderGoods")
util.AddNetworkString("receiveTraderGoods")
util.AddNetworkString("traderBuy")
util.AddNetworkString("setCamouflage")

net.Receive("setPlayerRole", function(len,ply)
  if not ply:hasAccess("managment") then
    return
  end

  local steamID = net.ReadString()
  local roleName = net.ReadString()
  local target = player.GetBySteamID(steamID)

  target:setRole(roleName)
end)

net.Receive("getPlayerRoles", function(len,ply)
  net.Start("receivePlayerRoles")

  local rolesToSend = {}

  if ply:hasAccess("all") then
    rolesToSend = core.roles.store
  else
    for _,v in pairs(core.group.getPlayerGroupRoles(ply)) do
      local role = core.role.getRole(v)

      if not role.hasAccess("managment") then
        table.insert(rolesToSend, role)
      end
    end
  end

  net.WriteTable(rolesToSend)
  net.Send(ply)
end)

net.Receive("getTraderGoods", function(len,ply)
  if not ply:hasAccess("trade") then
    return
  end

  net.Start("receiveTraderGoods")
  net.WriteTable(core.good.getGoods())
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

net.Receive("setCamouflage", function(len,ply)
  if not ply:hasAccess("camouflage") then return end

  local roleName = net.ReadString()

  core.disguise.setCamouflage(ply, roleName)
end)

net.Receive("getCamouflages", function(len,ply)
  if not ply:hasAccess("camouflage") then return end

  net.Start("receiveTraderGoods")
  net.WriteTable(core.good.getGoods())
  net.Send(ply)
end)
