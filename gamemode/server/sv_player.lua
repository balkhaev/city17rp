local meta = FindMetaTable("Player")

function meta:setRole(roleName)
  if core.role.setPlayerRole(self, roleName) then
    self:SetNWString("role", roleName)
  end
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
