core.role = {}
core.role.store = {}
core.role.uniqIndex = 0

function core.role.addRole(name, title, desc, groupName, access)
  Msg("Adding role ", name, " ", title, "\n")
  local group = core.group.getGroup(groupName)
  
  if group then
    local team = core.team.getTeam(group.team)

    core.role.uniqIndex = core.role.uniqIndex + 1

    core.role.store[core.role.uniqIndex] = {
      index = core.role.uniqIndex,
      name = name,
      title = title,
      description = desc or "N/A",
      access = access or "",
      group = groupName,
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

function core.role.removeGang(playerId, roleIndex)
  table.remove(core.role.store[roleIndex].gangs, playerId)
end

function core.role.getRole(roleName)
  Msg("Search roleName ", roleName, "\n")
  for _, role in pairs(core.role.store) do
    Msg(_, " ", role)
    PrintTable(role)
    if role.name == roleName then
      Msg("========= Found ======== ", roleName, " ============\n")
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

function core.role.indexPlayerRole(ply)
  for roleIndex, role in pairs(core.role.store) do
    if role.gangs[ply:SteamID()] ~= nil then
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

function core.role.setPlayerRole(ply, roleName)
  Msg("Set role ", roleName, " for ", ply.SID, "\n")
  local role = core.role.getRole(roleName)
  PrintTable(role)

  if role then
    core.role.deletePlayerRole(ply)
    local group = core.group.getGroup(role.group)
    local team = core.team.getTeam(group.team)

    core.role.addGang(ply:SteamID(), ply:GetName(), role.index)
    core.group.addGang(ply:SteamID(), ply:GetName(), group.index)
    core.team.addGang(ply:SteamID(), ply:GetName(), team.index)

    ply:SetTeam(team.index)
  else
    Msg("Role undefined\n")
    return nil
  end
end

function core.role.deletePlayerRole(ply)
  local role = core.role.getPlayerRole(ply)
  local group = core.group.getGroup(role.group)
  local team = core.team.getTeam(group.team)

  core.role.removeGang(ply:SteamID(), ply:GetName(), role.index)
  core.group.removeGang(ply:SteamID(), ply:GetName(), group.index)
  core.team.removeGang(ply:SteamID(), ply:GetName(), team.index)
end

function core.role.hasAccess(roleName, accessFlag)
  return core.role.getRole(roleName).access[accessFlag] ~= nil
end

function core.role.init(roles)
  Msg("======Init roles=======\n")

  for roleKey, role in pairs(core.config.roles) do
    core.role.addRole(roleKey, role.name, role.desc, role.group, role.access)
  end

  PrintTable(core.role.store)
end
