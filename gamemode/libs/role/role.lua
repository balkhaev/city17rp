core.role = core.role or {}
core.role.store = core.role.store or {}
core.role.uniqIndex = core.role.uniqIndex or 0

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
      camouflage = role.camouflage or {},
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
  Msg(roleName .. " not found\n")
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

function core.role.getRolesByGroup(groupName)
  local out = {}

  for indexRole, role in pairs(core.role.store) do
    if role.group == groupName then
      out[indexRole] = role
    end
  end

  return out
end

function core.role.getCamouflageRoles(roleName)
  local plyRole = core.role.getRole(roleName)
  local out = {}

  for camoIndex, camouflageRole in pairs(plyRole.camouflage) do
    local role = core.role.getRole(camouflageRole)
    out[camoIndex] = role
  end

  return out
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
  local role = core.role.getRole(roleName)
  Msg("Set role ", role.title, " for ", ply:Nick(), "\n")

  if role then
    if core.role.existsPlayerRole(ply) then
      core.role.deletePlayerRole(ply)
    end

    local group = core.group.getGroup(role.group)
    local team = core.team.getTeam(group.team)

    core.role.addGang(ply:SteamID(), ply:GetName(), role.index)
    core.group.addGang(ply:SteamID(), ply:GetName(), group.index)
    core.team.addGang(ply:SteamID(), ply:GetName(), team.index)

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

  for _, weaponName in pairs(role.weapons) do
    local wep = ply:Give(weaponName)

    if string.find(weaponName, "cw_") then
      ply:SetAmmo( 90, wep:GetPrimaryAmmoType() )
    end
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
