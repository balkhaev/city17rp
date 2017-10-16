util.AddNetworkString("setPlayerRole")
util.AddNetworkString("getPlayerRoles")
util.AddNetworkString("receivePlayerRoles")

util.AddNetworkString("giveMoney")
util.AddNetworkString("takeMoney")

util.AddNetworkString("traderBuy")
util.AddNetworkString("getTraderGoods")
util.AddNetworkString("receiveTraderGoods")

util.AddNetworkString("setCamouflage")
util.AddNetworkString("getCamouflages")
util.AddNetworkString("receiveCamouflages")

util.AddNetworkString("getPlayerAccess")
util.AddNetworkString("receivePlayerAccess")

net.Receive("getPlayerAccess", function(len,ply)
  local role = ply:getRole()
  local group = ply:getGroup()

  local accessToSend = core.utils.tableConcat(role.access,group.access)

  if ply:IsAdmin() then
    table.insert(accessToSend, "admin")
  end

  net.Start("receivePlayerAccess")
  net.WriteTable(accessToSend)
  net.Send(ply)
end)

function sendPlayerRoles(ply)
  local rolesToSend = {}
  local roles

  if ply:hasAccess("admin") then
    roles = core.role.store
  else
    roles = core.role.getRolesByGroup(ply:getGroupName())
  end

  for _,role in pairs(roles) do
    table.insert(rolesToSend, {
      title = role.title,
      groupTitle = core.group.getGroupTitle(role.group),
      name = role.name
    })
  end

  net.Start("receivePlayerRoles")
  net.WriteTable(rolesToSend)
  net.Send(ply)
end

net.Receive("setPlayerRole", function(len,ply)
  if not ply:hasAccess("managment") then
    return
  end

  local steamID = net.ReadString()
  local roleName = net.ReadString()
  local target = player.GetBySteamID(steamID)

  if ply:hasAccess("admin") or (target:isGroup("citizens") or target:getGroupName() == ply:getGroupName()) then
    target:setRole(roleName)
  end

  sendPlayerRoles(ply)
end)

net.Receive("getPlayerRoles", function(len,ply)
  sendPlayerRoles(ply)
end)

net.Receive("takeMoney", function(len,ply)
  local amount = net.ReadInt(32)
  local eyeTrace = ply:GetEyeTrace()

  ply:TakeMoney( eyeTrace.Entity, amount )
end)

net.Receive("getTraderGoods", function(len,ply)
  if not ply:hasAccess("trade") then
    return
  end

  local goodsToSend = {}

  if (ply:hasAccess("tradeWeapon")) then
    goodsToSend = {
      weapons = core.good.getGoodsByType("weapons"),
      equips = core.good.getGoodsByType("equips"),
      ammo = core.good.getGoodsByType("ammo")
    }
  end

  net.Start("receiveTraderGoods")
  net.WriteTable(goodsToSend)
  net.Send(ply)
end)

net.Receive("traderBuy", function(len,ply)
  if not ply:hasAccess("trade") then
    return
  end

  local entityType = net.ReadString()
  local entityName = net.ReadString()
  local good = core.good.getGood(entityType, entityName)

  if good == nil then return end

  local entity = ents.Create(good.entity)
  if not IsValid( entity ) then return end

  if not ply:EnoughMoney(good.cost) then
    ply:PrintMessage(HUD_PRINTTALK, "Не хватает денег")
    return
  end

  ply:AddMoney(-good.cost)

  local eyeTrace = ply:GetEyeTrace()

  entity:SetPos( eyeTrace.HitPos )
  entity:Spawn()
end)

net.Receive("setCamouflage", function(len,ply)
  if not ply:hasAccess("camouflage") then return end

  local roleName = net.ReadString()
  local role = core.role.getRole(roleName)

  ply:SetCamouflage(role.model, role.title)
end)

net.Receive("getCamouflages", function(len,ply)
  if not ply:hasAccess("camouflage") then return end

  local camouflagesToSend = {}
  local camouflages

  if ply:hasAccess("admin") then
    camouflages = core.role.store
  else
    camouflages = core.role.getCamouflageRoles(ply:getRoleName())
  end

  for i,camoRole in pairs(camouflages) do
    table.insert(camouflagesToSend, {
      title = camoRole.title,
      groupTitle = core.group.getGroupTitle(camoRole.group),
      name = camoRole.name
    })
  end

  net.Start("receiveCamouflages")
  net.WriteTable(camouflagesToSend)
  net.Send(ply)
end)

net.Receive("removeCamouflage", function(len,ply)
  if not ply:hasAccess("camouflage") then return end

  ply:RemoveCamouflage()
end)

net.Receive("giveMoney", function(len,ply)
  if not ply:hasAccess("admin") then return end

  local steamID = net.ReadString()
  local amount = net.ReadInt(32)
  local target = player.GetBySteamID(steamID)

  target:AddMoney(amount)
end)
