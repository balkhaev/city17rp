core.role = {}
core.role.store = {}
core.role.uniqIndex = 0

function core.role.addRole(title, desc, access)
  core.role.uniqIndex = core.role.uniqIndex + 1
  
  core.role.store[core.role.uniqIndex] = {
		index = core.role.uniqIndex,
		name = name or "Unknown Role",
		description = desc or "N/A",
		access = access or "",
		gangs = {}
  }
  
  return core.role.uniqIndex
end
