local meta = FindMetaTable("Player")

function meta:getRole()
  return core.role.getPlayerRole(self)
end

function meta:getGroup()
  return core.group.getPlayerGroup(self)
end

function meta:getTeam()
  return core.team.getPlayerTeam(self)
end

function meta:hasAccess(accessFlag)
  if core.config.defaults.access[accessFlag] ~= nil then
    return true
  end

  local role = self:getRole()

  if core.role.hasAccess(role.name, accessFlag) then
    return true
  end

  local group = self:getGroup()

  if core.group.hasAccess(group.name, accessFlag) then
    return true
  end

  return false
end

function meta:Nick()
  if (self:GetPData("nickname")) then
    return self:GetPData("nickname")
  end

  return self:Nick()
end

function meta:setNick(nick)
  self:SetPData("nickname", nick)
end

function GM:PlayerInitialSpawn(ply)
  ply.SID = ply:UserID()

  if not core.role.existsPlayerRole(ply) then
    core.role.setPlayerRole(ply, core.config.defaults.role)
  end
end
