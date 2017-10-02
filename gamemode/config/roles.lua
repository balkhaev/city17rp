core.config = {}

core.config.defaults = {
  role = "citizen",
  spawnTime = 300
}

core.config.teams = {
  civilians = {
    title = "Мирные жители"
  },
  rebels = {
    title = "Повстанцы"
  },
  alliance = {
    title = "Альянс"
  },
  zombie = {
    title = "Зомби"
  }
}

core.config.groups = {
  administration = {
    title = "Администрация города",
    team = "civilians"
  },
  traders = {
    title = "Торговцы",
    team = "civilians"
  },
  citizens = {
    title = "Жители",
    team = "civilians"
  },
  civilianDefence = {
    title = "Гражданская оборона",
    team = "alliance"
  },
  allianceArmy = {
    title = "Армия Альянса",
    team = "alliance"
  },
  implementationDepartment = {
    title = "Отдел внедрения",
    team = "rebels"
  },
  rebelsArmy = {
    title = "Армия Повстанцев",
    team = "rebels"
  }
}

core.config.roles = {
  citizen = {
    title = "Мирный житель",
    group = "citizens"
  },
  rebelsCitizen = {
    title = "Доверенное лицо Повстанцев",
    group = "citizens"
  },
  allianceCitizen = {
    title = "Доверенное лицо Альянса",
    group = "citizens"
  },
  weaponTrader = {
    title = "Продавец оружия",
    group = "traders"
  },
  armorTrader = {
    title = "Продавец брони",
    group = "traders"
  },
  representativeMayor = {
    title = "Представитель мера",
    group = "administration"
  },
  deputyMayor = {
    title = "Заместитель мера",
    group = "administration"
  },
  mayor = {
    title = "Мер",
    group = "administration"
  }
}
