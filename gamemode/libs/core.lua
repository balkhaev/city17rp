function core.init(config)
  Msg("=======Init core=======\n")
  PrintTable(config)

  core.team.init(config.teams)
  core.group.init(config.groups)
  core.role.init(config.roles)
end