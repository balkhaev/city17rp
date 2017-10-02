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

function core.team.addRole(role, team)
  core.team.store[team.index].roles[role.name] = role
end

function core.team.addGroup(group, team)
  core.team.store[team.index].group[group.name] = group
end

function core.team.init(teams)
  for teamKey, team in pairs(teams) do
    core.team.addTeam(team.title, team.desc)
  end
end
