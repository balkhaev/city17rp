local meta = FindMetaTable("Player")

function meta:getRole()
  return core.role.getRole(self:getRoleName())
end

function meta:getRoleName()
  return self:GetNWString("role")
end

function meta:getRoleTitle()
  local role = self:getRole()

  if role == nil then
    return "Unknown role"
  end

  return role.title
end

function meta:getGroup()
  local group = core.group.getGroup(self:getGroupName())

  if group == nil then
    Msg("[getGroup] ", self:Nick()," without group")
    return nil
  end

  return group
end

function meta:getGroupName()
  return self:GetNWString("group")
end

function meta:getGroupTitle()
  local group = self:getGroup()

  if group == nil then
    return "Unknown group"
  end

  return group.title
end

function meta:isGroup(groupName)
  local group = self:getGroup()

  if group == nil then
    return false
  end

  return group.name == groupName
end

function meta:getTeam()
  return core.team.getPlayerTeam(self)
end

function meta:hasAccess(accessFlag)
  if self:IsUserGroup("superadmin") then
    return true
  end

  if core.config.defaults.access[accessFlag] ~= nil then
    return true
  end

  if core.role.hasPlayerAccess(self, accessFlag) then
    return true
  end

  if core.group.hasPlayerAccess(self, accessFlag) then
    return true
  end

  return false
end

local getNick = meta.Nick
function meta:Nick()
  if (self:GetPData("nickname")) then
    return self:GetPData("nickname")
  end

  return getNick(self)
end

function meta:setNick(nick)
  self:SetPData("nickname", nick)
end

function meta:GetMoney()
  return self:GetNetworkedInt( "Money" )
end

function meta:EnoughMoney(amount)
  return self:GetMoney() >= amount
end

function meta:getPlayerByName(name)
  name = string.lower(name);
  for _,v in ipairs(player.GetHumans()) do
    if string.find(string.lower(v:Name()),name,1,true) ~= nil then
      return v
    end
  end
end
