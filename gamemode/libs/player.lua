local meta = FindMetaTable("Player")

function meta:getRole()
  return core.role.getPlayerRole(self.Player)
end

function GM:PlayerInitialSpawn(ply)
  ply.SID = ply:UserID()

  if not core.role.existsPlayerRole(ply) then
    core.role.setRole(ply, core.config.defaults.role)
  end
end
