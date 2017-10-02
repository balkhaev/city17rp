core.group = {}
core.group.store = {}
core.group.uniqIndex = 0

function core.group.addGroup(title, desc, access)
  core.group.uniqIndex = core.group.uniqIndex + 1
  
  core.group.store[core.group.uniqIndex] = {
    index = core.team.uniqIndex,
		name = name or "Unknown Group",
		description = desc or "N/A",
		access = access or "",
		roles = {},
		gangs = {}
  }
end
