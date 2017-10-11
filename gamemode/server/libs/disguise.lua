core.disguise = {}

function core.disguise.setCamouflage(ply, roleName)
  local role = core.role.getRole(roleName)

  ply:SetModel(role.model)
end

function core.disguise.removeCamouflage(ply)
  local role = core.role.getRole(ply:getRoleName())

  ply:SetModel(role.model)
end