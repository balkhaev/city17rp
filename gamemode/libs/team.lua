core.team = {}
core.team.store = {}
core.team.uniqIndex = 0

function core.team.addTeam(name, desc)
  core.team.uniqIndex = core.team.uniqIndex + 1

  core.team.store[core.team.uniqIndex] = {
    index = core.team.uniqIndex,
    name = name or "Unknown Team",
    description = desc or "N/A",
    groups = {},
    roles = {},
    gangs = {}
  }

  return core.team.uniqIndex
end

function core.team.addGroup(groupIndex, groupName, teamIndex)
  core.team.store[teamIndex].group[groupIndex] = groupName
end

function core.team.addRole(roleIndex, roleName, teamIndex)
  core.team.store[teamIndex].roles[roleIndex] = roleName
end

function core.team.addGang(playerId, playerName, teamIndex)
  core.team.store[teamIndex].gangs[playerId] = playerName
end

function core.team.getTeam(teamName)
  for teamIndex, team in pairs(core.team.store) do
    if team.name == teamName then
      return team
    end
  end
  return nil
end

function core.team.init(teams)
  for teamKey, team in pairs(teams) do
    core.team.addTeam(team.title, team.desc)
  end
end
