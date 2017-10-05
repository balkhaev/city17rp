local meta = FindMetaTable("Player")

function meta:getRole()
  return core.role.getPlayerRole(self)
end

function meta:setRole(roleName)
  if core.role.setPlayerRole(self, roleName) then
    self:SetNWString("role", roleName)
  end
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

function meta:getPlayerByName(name)
  name = string.lower(name);
  for _,v in ipairs(player.GetHumans()) do
    if string.find(string.lower(v:Name()),name,1,true) ~= nil then
      return v
    end
  end
end

function meta:AddMoney(amount)
  self:SetMoney( self:GetMoney() + amount )
end

function meta:SetMoney(amount)
  self:SetNetworkedInt( "Money", amount )
  self:SetPData("money", amount)
end

function meta:SaveMoneyTXT()
  file.Write(gmod.GetGamemode().Name .."/Money/".. string.gsub(self:SteamID(), ":", "_") ..".txt", self:GetMoneyString())
end

function meta:TakeMoney(amount)
  local target = self:GetEyeTrace().Entity
  if target:IsPlayer() then
    --Add money function here
  end
  self:AddMoney(-amount)
end

function meta:GetMoney()
  return self:GetNetworkedInt( "Money" )
end
