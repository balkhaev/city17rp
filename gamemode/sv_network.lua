util.AddNetworkString("getPlayerRoles")
util.AddNetworkString("receivePlayerRoles")
util.AddNetworkString("getTraderGoods")
util.AddNetworkString("receiveTraderGoods")
util.AddNetworkString("traderBuy")
util.AddNetworkString("setCamouflage")

net.Receive("getPlayerRoles", function(len,ply)
  net.Start("receivePlayerRoles")
  net.WriteTable(core.role.store)
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
