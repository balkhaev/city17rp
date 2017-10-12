function core.init(config)
  Msg("====== Init core ======\n")
  PrintTable(config.defaults)

  Msg("--- Init teams ---\n")
  for teamKey, team in pairs(core.config.teams) do
    Msg("Adding team "..team.title.."\n")
    core.team.addTeam(teamKey, team)
  end

  Msg("--- Init groups ---\n")
  for groupKey, group in pairs(core.config.groups) do
    Msg("Adding role "..group.title.."\n")
    core.group.addGroup(groupKey, group)
  end
  Msg("--- Init roles ---\n")

  for roleKey, role in pairs(core.config.roles) do
    Msg("Adding role "..role.title.."\n")
    core.role.addRole(roleKey, role)
  end

  if SERVER then
    PrintTable(core.config.goods)
    for goodType, goods in pairs(core.config.goods) do
      for _, good in pairs(goods) do
        Msg("Adding good "..good.title.." with type "..goodType.."\n")
        core.good.addGood(goodType, good)
      end
    end
  end

  for teamKey, teamVal in pairs(core.team.store) do
    team.SetUp(teamVal.index, teamVal.name, teamVal.color)
  end
end
