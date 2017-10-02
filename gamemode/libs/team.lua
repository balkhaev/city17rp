core.team = {}
core.team.store = {}
core.team.uniqIndex = 0

function core.team.addTeam(name, desc, access)
  core.team.uniqIndex = core.team.uniqIndex + 1

  core.team.store[core.team.uniqIndex] = {
    index = core.team.uniqIndex,
    name = name or "Unknown Team",
    description = desc or "N/A",
    access = access or "",
    groups = {},
    roles = {},
    gangs = {}
  }

  return core.team.uniqIndex
end

