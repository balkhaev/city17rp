core.role = {}
core.role.store = {}
core.role.uniqIndex = 0

function core.role.addRole(title, desc, group)
  core.role.uniqIndex = core.role.uniqIndex + 1

  core.role.store[core.role.uniqIndex] = {
    index = core.role.uniqIndex,
    title = title,
    description = desc or "N/A",
    group = group,
    gangs = {}
  }

  return core.role.uniqIndex
end

function core.role.getRole(roleName)
  
end

function core.role.addGang(ply, role)
  role.gangs[ply:SteamID()] = 1
end

function core.role.setRole(ply, roleName)
  local role = core.role.getRole(roleName)
  
  if role then
    local group = core.group.getGroup(role.group)
    
    if group then
      local team = core.team.getTeam(group.team)

      if team then
        core.role.addGang(ply, role)
        core.group.addGang(ply, group)
        core.team.addGang(ply, team)

        ply:SetTeam(team.index)
      else
        Msg("Team undefined")
      end
    else
      Msg("Group undefined")
    end
  else
    Msg("Role undefined")
  end
end

function core.role.init(roles)
  for roleKey, role in pairs(roles) do
    core.role.addRole(role.title, role.desc, role.group)
  end
end
