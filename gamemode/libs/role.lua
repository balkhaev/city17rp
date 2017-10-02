core.role = {}
core.role.store = {}
core.role.uniqIndex = 0

function core.role.addRole(name, desc, groupName, access)
  local group = core.group.getGroup(groupName)
  
  if group then
    local team = core.team.getTeam(group.team)

    core.role.uniqIndex = core.role.uniqIndex + 1

    core.role.store[core.role.uniqIndex] = {
      index = core.role.uniqIndex,
      name = name,
      description = desc or "N/A",
      access = access or "",
      group = group,
      gangs = {}
    }

    core.group.addRole(core.role.uniqIndex, name, group.index)
    core.team.addRole(core.role.uniqIndex, name, team.index)

    return core.role.uniqIndex
  end

end

function core.role.getRole(roleName)
  
end

function core.role.addGang(playerId, playerName, roleIndex)
  core.role.store[roleIndex].gangs[playerId] = playerName
end

function core.role.setRole(ply, roleName)
  local role = core.role.getRole(roleName)
  
  if role then
    local group = core.group.getGroup(role.group)
    local team = core.team.getTeam(group.team)

    core.role.addGang(ply:SteamID(), ply:GetName(), role.index)
    core.group.addGang(ply, group)
    core.team.addGang(ply, team)

    ply:SetTeam(team.index)
  else
    Msg("Role undefined")
  end
end

function core.role.init(roles)
  for roleKey, role in pairs(roles) do
    core.role.addRole(role.name, role.desc, role.group)
  end
end
