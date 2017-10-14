local meta = FindMetaTable("Player")

function meta:getRole()
  return core.role.getRole(self:getRoleName())
end

function meta:getRoleName()
  return self:GetNWString("role")
end

function meta:getRoleTitle()
  if self.camouflageGroup ~= nil then
    return self.camouflageGroup
  end

  return self:GetNWString("roleTitle")
end

function meta:getGroupName()
  return self:GetNWString("group")
end

function meta:getGroupTitle()
  return self:GetNWString("groupTitle")
end

function meta:isGroup(groupName)
  local group = self:getGroup()

  if group == nil then
    return false
  end

  return group.name == groupName
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
