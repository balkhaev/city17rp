core.role = {}
core.role.store = {}
core.role.uniqIndex = 0

function core.role.addRole(name, role)
  local group = core.group.getGroup(role.group)

  if group then
    local team = core.team.getTeam(group.team)

    core.role.uniqIndex = core.role.uniqIndex + 1

    core.role.store[core.role.uniqIndex] = {
      index = core.role.uniqIndex,
      name = name,
      title = role.title,
      description = role.desc or "N/A",
      access = role.access or "",
      group = role.group,
      weapons = role.weapons,
      model = role.model,
      salary = role.salary or group.salary,
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
  Msg("Remove gang "..playerId.." from role index "..roleIndex.."\n")
  core.role.store[roleIndex].gangs[playerId] = nil
end

function core.role.getRole(roleName)
  for _, role in pairs(core.role.store) do
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

function core.role.getRoleBySteamID(steamID)
  for roleIndex, role in pairs(core.role.store) do
    if role.gangs[steamID] ~= nil then
      return roleIndex
    end
  end
  return -1
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
  Msg("Set role ", roleName, " for ", ply:Nick(), "\n")
  local role = core.role.getRole(roleName)

  if role then
    if core.role.existsPlayerRole(ply) then
      core.role.deletePlayerRole(ply)
    end

    local group = core.group.getGroup(role.group)
    local team = core.team.getTeam(group.team)

    core.role.addGang(ply:SteamID(), ply:GetName(), role.index)
    core.group.addGang(ply:SteamID(), ply:GetName(), group.index)
    core.team.addGang(ply:SteamID(), ply:GetName(), team.index)

    if SERVER then
      ply:SetModel(role.model)
      ply:SetTeam(team.index)
      ply:SetPData("role", role.name)

      core.role.giveRoleItems(ply, roleName)
    end

    return true
  else
    Msg("[setPlayerRole] ", ply:Nick(), " with unknown role - ", roleName)
  end

  return false
end

function core.role.deletePlayerRole(ply)
  local role = core.role.getPlayerRole(ply)
  local group = core.group.getGroup(role.group)
  local team = core.team.getTeam(group.team)

  Msg("Removing role "..role.title.." for player "..ply:Nick().."\n")

  core.role.removeGang(ply:SteamID(), role.index)
  core.group.removeGang(ply:SteamID(), group.index)
  core.team.removeGang(ply:SteamID(), team.index)
end

function core.role.giveRoleItems(ply, roleName)
  ply:StripWeapons()

  local role = core.role.getRole(roleName)

  ply:GetHands()
  for _, weaponName in pairs(role.weapons) do
    ply:Give(weaponName)
  end
end

function core.role.hasAccess(roleName, accessFlag)
  local role = core.role.getRole(roleName)

  for _,access in pairs(role.access) do
    if access == "all" then
      return true
    end
    if access == accessFlag then
      return true
    end
  end

  return false
end

function core.role.hasPlayerAccess(ply, accessFlag)
  local role = ply:getRole()
  return core.role.hasAccess(role.name, accessFlag)
end
