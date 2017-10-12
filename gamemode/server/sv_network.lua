util.AddNetworkString("setPlayerRole")
util.AddNetworkString("getPlayerRoles")
util.AddNetworkString("receivePlayerRoles")

util.AddNetworkString("takeMoney")

util.AddNetworkString("traderBuy")
util.AddNetworkString("getTraderGoods")
util.AddNetworkString("receiveTraderGoods")

util.AddNetworkString("setCamouflage")
util.AddNetworkString("getCamouflages")
util.AddNetworkString("receiveCamouflages")

function sendPlayerRoles(ply)
  local rolesToSend = {}

  if ply:hasAccess("admin") then
    rolesToSend = core.role.store
  else
    for _,v in pairs(core.group.getPlayerGroupRoles(ply)) do
      local role = core.role.getRole(v)

      if not core.role.hasAccess(role.name, "managment") then
        table.insert(rolesToSend, role)
      end
    end
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
  local amount = net.ReadInt()
  local eyeTrace = ply:GetEyeTrace()

  ply:TakeMoney( eyeTrace.HitPos, amount )
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
  if not ply:EnoughMoney(good.cost) then return end

  ply:AddMoney(-good.cost)

  local eyeTrace = ply:GetEyeTrace()

  entity:SetPos( eyeTrace.HitPos )
  entity:Spawn()
end)

net.Receive("setCamouflage", function(len,ply)
  if not ply:hasAccess("camouflage") then return end

  local roleName = net.ReadString()
  local role = core.role.getRole(roleName)

  ply:SetCamouflage(role.model, role.group)
end)

net.Receive("getCamouflages", function(len,ply)
  if not ply:hasAccess("camouflage") then return end

  local camouflagesToSend = {}

  if ply:hasAccess("admin") then
    camouflagesToSend = core.role.store
  else
    local role = ply:getRole()

    for i,v in pairs(role.camouflage) do
      local camoRole = core.role.getRole(v)
      table.insert(camouflagesToSend, camoRole)
    end
  end

  net.Start("receiveCamouflages")
  net.WriteTable(camouflagesToSend)
  net.Send(ply)
end)

net.Receive("removeCamouflage", function(len,ply)
  if not ply:hasAccess("camouflage") then return end

  ply:RemoveCamouflage()
end)
