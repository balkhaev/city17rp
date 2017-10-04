function core.init(config)
  Msg("====== Init core ======\n")
  PrintTable(config.defaults)

  Msg("--- Init teams ---\n")
  for teamKey, team in pairs(teams) do
    Msg("Adding team "..team.title.."\n")
    core.team.addTeam(teamKey, team)
  end

  Msg("--- Init groups ---\n")
  for groupKey, group in pairs(groups) do
    Msg("Adding role "..group.title.."\n")
    core.group.addGroup(groupKey, group)
  end
  Msg("--- Init roles ---\n")

  for roleKey, role in pairs(core.config.roles) do
    Msg("Adding role "..role.title.."\n")
    core.role.addRole(roleKey, role)
  end

  for teamKey, teamVal in pairs(core.team.store) do
    team.SetUp(teamVal.index, teamVal.name, teamVal.color)
  end
end
