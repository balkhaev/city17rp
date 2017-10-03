core.config = {}

core.config.defaults = {
  role = "citizen",
  access = {"settings"},
  spawnTime = 300
}

core.config.teams = {
  civilians = {
    title = "Мирные жители",
    color = Color(125, 125, 125, 255)
  },
  rebels = {
    title = "Повстанцы",
    color = Color(225, 225, 0, 225)
  },
  alliance = {
    title = "Альянс",
    color = Color(225, 0, 225, 225)
  },
  zombie = {
    title = "Зомби",
    color = Color(0, 225, 255, 225)
  }
}

core.config.groups = {
  -- Мирные жители
  administration = {
    title = "Администрация города",
    team = "civilians",
    spawn = "548.93084716797,3056.7243652344,80.03125",
    access = {"poll", "management"}
  },
  traders = {
    title = "Торговцы",
    team = "civilians",
    spawn = "",
    access = {"trade"}
  },
  citizens = {
    title = "Жители",
    team = "civilians",
    spawn = "",
    access = {}
  },
  -- Альянс
  civilianDefence = {
    title = "Гражданская оборона",
    team = "alliance",
    spawn = "4419.1293945313,312.06140136719,76.03125",
    access = {"arrest"}
  },
  allianceArmy = {
    title = "Армия Альянса",
    team = "alliance",
    spawn = "4419.1293945313,312.06140136719,76.03125",
    access = {}
  },
  -- Повстанцы
  implementationDepartment = {
    title = "Отдел внедрения",
    team = "rebels",
    spawn = "-3369.4533691406,-2147.1401367188,80.03125",
    access = {"camouflage"}
  },
  rebelsArmy = {
    title = "Армия Повстанцев",
    team = "rebels",
    spawn = "-3369.4533691406,-2147.1401367188,80.03125",
    access = {}
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
    access = {"managment"}
  },
  mayor = {
    title = "Мер",
    group = "administration",
    weapons = {},
    access = {"managment"}
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
