function core.init(config)
  Msg("=======Init core=======\n")
  PrintTable(config.defaults)

  core.team.init(config.teams)
  core.group.init(config.groups)
  core.role.init(config.roles)

  for teamKey, teamVal in pairs(core.team.store) do
    team.SetUp(teamVal.index, teamVal.name, teamVal.color)
  end
end
