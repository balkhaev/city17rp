local meta = FindMetaTable("Player")

function meta:setRole(roleName)
  if core.role.setPlayerRole(self, roleName) then
    local role = core.role.getRole(roleName)
    local group = core.group.getGroup(role.group)
    local team = core.team.getTeam(group.team)

    self:SetModel(role.model)
    self:SetTeam(team.index)

    self:SetNWString("role", role.name)
    self:SetNWString("roleTitle", role.title)
    self:SetNWString("group", group.name)
    self:SetNWString("groupTitle", group.title)
    self:SetNWString("team", team.name)
    self:SetNWString("teamTitle", team.title)
    self:SetPData("role", role.name)

    core.role.giveRoleItems(self, role.name)
    core.npc.addRelation(self)
  end
end

function meta:getGroup()
  local group = core.group.getGroup(self:getGroupName())

  if group == nil then
    Msg("[getGroup] ", self:Nick()," without group")
    return nil
  end

  return group
end

function meta:getTeam()
  return core.team.getPlayerTeam(self)
end

function meta:setGroup(groupName)
  self:SetNWString("group", groupName)
end

function meta:AddMoney(amount)
  self:SetMoney( self:GetMoney() + amount )
end

function meta:SetMoney(amount)
  self:SetNetworkedInt( "Money", amount )
  self:SetPData("money", amount)
end

function meta:TakeMoney(target, amount)
  if not target:IsPlayer() then return end
  if not self:EnoughMoney(amount) then
    return false
  end

  target:AddMoney(amount)
  self:AddMoney(-amount)
end

function meta:SetCamouflage(roleModel, roleTitle)
  self:SetModel(roleModel)
  self:SetNWString("roleTitle", roleTitle)
end

function meta:RemoveCamouflage()
  local role = self:getRole()

  self:SetModel(role.model)
  self:SetNWString("groupTitle", role.title)
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