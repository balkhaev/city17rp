local meta = FindMetaTable("Player")

function meta:getRole()
  return core.role.getPlayerRole(self)
end

function meta:getRoleName()
  return self:GetPData("role")
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


local getNick = meta.Nick
function meta:Nick()
  if (self:GetPData("nickname")) then
    return self:GetPData("nickname")
  end

  return getNick()
end

function meta:setNick(nick)
  self:SetPData("nickname", nick)
end

function meta:getPlayerByName(name)
  name = string.lower(name);
  for _,v in ipairs(player.GetHumans()) do
    if string.find(string.lower(v:Name()),name,1,true) ~= nil then
      return v
    end
  end
end

function GM:PlayerInitialSpawn(ply)
  ply.SID = ply:UserID()

  if not core.role.existsPlayerRole(ply) then
    if ply:GetPData("role") then
      core.role.setPlayerRole(ply, ply:GetPData("role"))
    else
      core.role.setPlayerRole(ply, core.config.defaults.role)
    end
  end
end
