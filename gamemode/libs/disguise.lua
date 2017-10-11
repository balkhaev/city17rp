core.disguise = {}

function core.disguise.setCamouflage(ply, roleName)
  local role = core.role.getRole(roleName)

  ply:SetModel(role.model)
end