core.group = {}
core.group.store = {}
core.group.uniqIndex = 0

function core.group.addGroup(name, group)
  local team = core.team.getTeam(group.team)
  
  if team then
    core.group.uniqIndex = core.group.uniqIndex + 1

    core.group.store[core.group.uniqIndex] = {
      index = core.group.uniqIndex,
      name = name,
      title = group.title or "Unknown Group",
      description = group.desc or "N/A",
      access = group.access or "",
      team = group.team,
      spawn = group.spawn,
      roles = {},
      gangs = {}
    }
    
    core.team.addGroup(core.group.uniqIndex, name, team.index)
    
    return core.group.uniqIndex
  end
end

function core.group.addRole(roleIndex, roleName, groupIndex)
  core.group.store[groupIndex].roles[roleIndex] = roleName
end

function core.group.removeRole(roleIndex, groupIndex)
  table.remove(core.group.store[groupIndex].roles, roleIndex)
end

function core.group.addGang(playerId, playerName, groupIndex)
  core.group.store[groupIndex].gangs[playerId] = playerName
end

function core.group.removeGang(playerId, groupIndex)
  table.remove(core.group.store[groupIndex].gangs, playerId)
end

function core.group.getGroup(groupName)
  for groupIndex, group in pairs(core.group.store) do
    if group.name == groupName then
      return group
    end
  end
  return nil
end

function core.group.getGroupRoles(groupName)
  local group = core.group.getGroup(groupName)

  if group then
    return group.groups
  end

  return nil
end

function core.group.getGroupGangs(groupName)
  local group = core.group.getGroup(groupName)

  if group then
    return group.gangs
  end

  return nil
end

function core.group.indexPlayerGroup(ply)
  for groupIndex, group in pairs(core.group.store) do
    if group.gangs[ply:SteamID()] then
      return groupIndex
    end
  end
  return -1
end

function core.group.getPlayerGroup(ply)
  local groupIndex = core.group.indexPlayerGroup(ply)

  if groupIndex == -1 then
    return nil
  end

  return core.group.store[groupIndex]
end

function core.group.hasAccess(groupName, accessFlag)
  return core.group.getGroup(groupName).access[accessFlag] ~= nil
end

function core.group.init(groups)
  Msg("======Init groups======\n")
  for groupKey, group in pairs(groups) do
    core.group.addGroup(groupKey, group)
  end
  PrintTable(core.group.store)
end
