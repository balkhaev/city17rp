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

function core.role.addGang(playerId, playerName, roleIndex)
  core.role.store[roleIndex].gangs[playerId] = playerName
end

function core.role.getRole(roleName)
  for roleIndex, role in pairs(core.role.store) do
    if role.name == roleName then
      return role
    end
  end
  return nil
end

function core.role.getRoleGangs(roleName)
  local role = core.role.getRole(roleName)

  if role then
    return role.gangs
  end

  return nil
end

function core.role.setRole(ply, roleName)
  local role = core.role.getRole(roleName)
  
  if role then
    local group = core.group.getGroup(role.group)
    local team = core.team.getTeam(group.team)

    core.role.addGang(ply:SteamID(), ply:GetName(), role.index)
    core.group.addGang(ply:SteamID(), ply:GetName(), group.index)
    core.team.addGang(ply:SteamID(), ply:GetName(), team.index)

    ply:SetTeam(team.index)

    return role
  else
    Msg("Role undefined")
    return nil
  end
end

function core.role.indexPlayerRole(ply)
  for roleIndex, role in pairs(core.role.store) do
    if role.gangs[ply:SteamID()] then
      return roleIndex
    end
  end
  return -1
end

function core.role.getPlayerRole(ply)
  local roleIndex = core.role.indexPlayerRole(ply)

  if roleIndex == -1 then
    return nil
  end

  return core.role.store[roleIndex]
end

function core.role.existsPlayerRole(ply)
  return core.role.indexPlayerRole(ply) > -1
end

function core.role.init(roles)
  for roleKey, role in pairs(roles) do
    core.role.addRole(role.name, role.desc, role.group, role.access)
  end
end
