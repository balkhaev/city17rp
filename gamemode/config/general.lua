core.config = {}

core.config.defaults = {
  role = "citizen",
  spawnTime = 300
}

core.config.teams = {
  civilians = {
    name = "Мирные жители",
    color = Color(125, 125, 125, 255)
  },
  rebels = {
    name = "Повстанцы",
    color = Color(225, 225, 0, 225)
  },
  alliance = {
    name = "Альянс",
    color = Color(225, 0, 225, 225)
  },
  zombie = {
    name = "Зомби",
    color = Color(0, 225, 255, 225)
  }
}

core.config.groups = {
  -- Мирные жители
  administration = {
    name = "Администрация города",
    team = "civilians",
    spawn = "548.93084716797,3056.7243652344,80.03125",
    access = {"settings", "poll", "management"}
  },
  traders = {
    name = "Торговцы",
    team = "civilians",
    spawn = "",
    access = {"settings", "trade"}
  },
  citizens = {
    name = "Жители",
    team = "civilians",
    spawn = "",
    access = {"settings"}
  },
  -- Альянс
  civilianDefence = {
    name = "Гражданская оборона",
    team = "alliance",
    spawn = "4419.1293945313,312.06140136719,76.03125",
    access = {"settings", "arrest"}
  },
  allianceArmy = {
    name = "Армия Альянса",
    team = "alliance",
    spawn = "4419.1293945313,312.06140136719,76.03125",
    access = {"settings"}
  },
  -- Повстанцы
  implementationDepartment = {
    name = "Отдел внедрения",
    team = "rebels",
    spawn = "-3369.4533691406,-2147.1401367188,80.03125",
    access = {"settings", "camouflage"}
  },
  rebelsArmy = {
    name = "Армия Повстанцев",
    team = "rebels",
    spawn = "-3369.4533691406,-2147.1401367188,80.03125",
    access = {"settings"}
  }
}

core.config.roles = {
  -- Мирные жители
  citizen = {
    title = "Мирный житель",
    group = "citizens",
    weapons = {"weapon_citizenpackage","weapon_citizensuitcase","weapon_bugbait","weapon_brickbat","weapon_annabelle"},
    access = {}
  },
  rebelsCitizen = {
    title = "Доверенное лицо Повстанцев",
    group = "citizens",
    weapons = {},
    access = {}
  },
  allianceCitizen = {
    title = "Доверенное лицо Альянса",
    group = "citizens",
    weapons = {},
    access = {}
  },
  weaponTrader = {
    title = "Продавец оружия",
    group = "traders",
    weapons = {},
    access = {}
  },
  armorTrader = {
    title = "Продавец брони",
    group = "traders",
    weapons = {},
    access = {}
  },
  representativeMayor = {
    title = "Представитель мера",
    group = "administration",
    weapons = {},
    access = {}
  },
  deputyMayor = {
    title = "Заместитель мера",
    group = "administration",
    weapons = {},
    access = {}
  },
  mayor = {
    title = "Мер",
    group = "administration",
    weapons = {},
    access = {}
  },
  -- Альянс
  recruit = {
    title = "Рекрут",
    group = "civilianDefence",
    weapons = {},
    access = {}
  },
  patrol = {
    title = "Патрульный",
    group = "civilianDefence",
    weapons = {},
    access = {}
  },
  corporalGuard = {
    title = "Разводящий",
    group = "civilianDefence",
    weapons = {},
    access = {}
  },
  -- Повстанцы
  scout = {
    title = "Разведчик",
    group = "implementationDepartment",
    weapons = {},
    access = {}
  },
  spy = {
    title = "Шпион",
    group = "implementationDepartment",
    weapons = {},
    access = {}
  },
  saboteur = {
    title = "Диверсант",
    group = "implementationDepartment",
    weapons = {},
    access = {}
  }
}
