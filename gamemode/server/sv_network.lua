util.AddNetworkString("setPlayerRole")
util.AddNetworkString("getPlayerRoles")
util.AddNetworkString("receivePlayerRoles")

util.AddNetworkString("traderBuy")
util.AddNetworkString("getTraderGoods")
util.AddNetworkString("receiveTraderGoods")

util.AddNetworkString("setCamouflage")
util.AddNetworkString("getCamouflages")
util.AddNetworkString("receiveCamouflages")

net.Receive("setPlayerRole", function(len,ply)
  if not ply:hasAccess("managment") then
    return
  end

  local steamID = net.ReadString()
  local roleName = net.ReadString()
  local target = player.GetBySteamID(steamID)

  if (target:isGroup("citizens") or target:getGroupName() == ply:getGroupName()) or ply:hasAccess("admin") then
    target:setRole(roleName)
  end
end)

net.Receive("getPlayerRoles", function(len,ply)
  local rolesToSend = {}

  if ply:hasAccess("admin") then
    rolesToSend = core.roles.store
  else
    for _,v in pairs(core.group.getPlayerGroupRoles(ply)) do
      local role = core.role.getRole(v)

      if not role.hasAccess("managment") then
        table.insert(rolesToSend, role)
      end
    end
  end

  net.Start("receivePlayerRoles")
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

  if good == nil then return end

  local entity = ents.Create(good.entity)
  if not IsValid( entity ) then return end
  if not ply:EnoughMoney(amount) then return end

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
