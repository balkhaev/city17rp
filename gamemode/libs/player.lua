local meta = FindMetaTable("Player")

function meta:getRole()
  return core.role.getPlayerRole(self.Player)
end

function meta:getGroup()
  return core.group.getPlayerGroup(self.Player)
end

function meta:getTeam()
  return core.team.getPlayerTeam(self.Player)
end

function GM:PlayerInitialSpawn(ply)
  ply.SID = ply:UserID()

  if not core.role.existsPlayerRole(ply) then
    core.role.setPlayerRole(ply, core.config.defaults.role)
  end
end
