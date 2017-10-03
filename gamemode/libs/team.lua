core.team = {}
core.team.store = {}
core.team.uniqIndex = 0

function core.team.addTeam(name, title, desc)
  core.team.uniqIndex = core.team.uniqIndex + 1

  core.team.store[core.team.uniqIndex] = {
    index = core.team.uniqIndex,
    name = name,
    title = title or "Unknown Team",
    description = desc or "N/A",
    groups = {},
    roles = {},
    gangs = {}
  }

  return core.team.uniqIndex
end

function core.team.addGroup(groupIndex, groupName, teamIndex)
  core.team.store[teamIndex].groups[groupIndex] = groupName
end

function core.team.removeGroup(groupIndex, teamIndex)
  table.remove(core.team.store[teamIndex].groups, groupIndex)
end

function core.team.addRole(roleIndex, roleName, teamIndex)
  core.team.store[teamIndex].roles[roleIndex] = roleName
end

function core.team.removeRole(roleIndex, teamIndex)
  table.remove(core.team.store[teamIndex].roles, roleIndex)
end

function core.team.addGang(playerId, playerName, teamIndex)
  core.team.store[teamIndex].gangs[playerId] = playerName
end

function core.team.removeGang(playerId, teamIndex)
  table.remove(core.team.store[teamIndex].gangs, playerId)
end

function core.team.getTeam(teamName)
  for teamIndex, team in pairs(core.team.store) do
    if team.name == teamName then
      return team
    end
  end
  return nil
end

function core.team.getTeamGroups(teamName)
  local team = core.team.getTeam(teamName)

  if team then
    return team.groups
  end

  return nil
end

function core.team.getTeamRoles(teamName)
  local team = core.team.getTeam(teamName)

  if team then
    return team.roles
  end

  return nil
end

function core.team.getTeamGangs(teamName)
  local team = core.team.getTeam(teamName)

  if team then
    return team.gangs
  end

  return nil
end

function core.team.indexPlayerTeam(ply)
  for teamIndex, team in pairs(core.team.store) do
    if team.gangs[ply:SteamID()] then
      return teamIndex
    end
  end
  return -1
end

function core.team.getPlayerTeam(ply)
  local teamIndex = core.team.indexPlayerTeam(ply)

  if teamIndex == -1 then
    return nil
  end

  return core.team.store[teamIndex]
end

function core.team.init(teams)
  Msg("======Init teams======\n")
  for teamKey, team in pairs(teams) do
    core.team.addTeam(teamKey, team.name, team.desc)
  end
  PrintTable(core.team.store)
end
