core.group = {}
core.group.store = {}
core.group.uniqIndex = 0

function core.group.addGroup(name, desc, teamName, access)
  local team = core.team.getTeam(teamName)
  
  if team then
    core.group.uniqIndex = core.group.uniqIndex + 1

    core.group.store[core.group.uniqIndex] = {
      index = core.group.uniqIndex,
      name = name or "Unknown Group",
      description = desc or "N/A",
      access = access or "",
      roles = {},
      gangs = {}
    }
    
    core.team.addGroup(core.group.uniqIndex, name, team.index)
    
    return core.group.uniqIndex
  end
end

function core.group.addGang(playerId, playerName, groupIndex)
  core.group.store[groupIndex].gangs[playerId] = playerName
end

function core.group.addRole(roleIndex, roleName, groupIndex)
  core.group.store[groupIndex].roles[roleIndex] = roleName
end

function core.group.init(groups)
  for groupKey, group in pairs(groups) do
    core.group.addGroup(group.name, group.desc, group.team, group.access)
  end
end
