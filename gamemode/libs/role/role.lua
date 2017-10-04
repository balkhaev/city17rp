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

  if role then
    if core.role.existsPlayerRole(ply) then
      core.role.deletePlayerRole(ply)
    end

    local group = core.group.getGroup(role.group)
    local team = core.team.getTeam(group.team)

    core.role.addGang(ply:SteamID(), ply:GetName(), role.index)
    core.group.addGang(ply:SteamID(), ply:GetName(), group.index)
    core.team.addGang(ply:SteamID(), ply:GetName(), team.index)

    core.role.giveRoleItems(ply, roleName)

    ply:SetTeam(team.index)
    -- ply:SetPData("role", role.name)
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

function core.role.giveRoleItems(ply, roleName)
  local role = core.role.getRole(roleName)

  for _, weaponName in pairs(role.weapons) do
    ply:Give(weaponName)
  end
end

function core.role.hasAccess(roleName, accessFlag)
  return core.role.getRole(roleName).access[accessFlag] ~= nil
end
