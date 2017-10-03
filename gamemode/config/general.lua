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
    spawn = "",
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
    spawn = "",
    access = {"settings", "arrest"}
  },
  allianceArmy = {
    name = "Армия Альянса",
    team = "alliance",
    spawn = "",
    access = {"settings"}
  },
  -- Повстанцы
  implementationDepartment = {
    name = "Отдел внедрения",
    team = "rebels",
    spawn = "",
    access = {"settings", "camouflage"}
  },
  rebelsArmy = {
    name = "Армия Повстанцев",
    team = "rebels",
    spawn = "",
    access = {"settings"}
  }
}

core.config.roles = {
  -- Мирные жители
  citizen = {
    name = "Мирный житель",
    group = "citizens",
    weapons = {"weapon_citizenpackage","weapon_citizensuitcase","weapon_bugbait","weapon_brickbat","weapon_annabelle"},
    access = {}
  },
  rebelsCitizen = {
    name = "Доверенное лицо Повстанцев",
    group = "citizens",
    weapons = {},
    access = {}
  },
  allianceCitizen = {
    name = "Доверенное лицо Альянса",
    group = "citizens",
    weapons = {},
    access = {}
  },
  weaponTrader = {
    name = "Продавец оружия",
    group = "traders",
    weapons = {},
    access = {}
  },
  armorTrader = {
    name = "Продавец брони",
    group = "traders",
    weapons = {},
    access = {}
  },
  representativeMayor = {
    name = "Представитель мера",
    group = "administration",
    weapons = {},
    access = {}
  },
  deputyMayor = {
    name = "Заместитель мера",
    group = "administration",
    weapons = {},
    access = {}
  },
  mayor = {
    name = "Мер",
    group = "administration",
    weapons = {},
    access = {}
  },
  -- Альянс
  recruit = {
    name = "Рекрут",
    group = "civilianDefence",
    weapons = {},
    access = {}
  },
  patrol = {
    name = "Патрульный",
    group = "civilianDefence",
    weapons = {},
    access = {}
  },
  corporalGuard = {
    name = "Разводящий",
    group = "civilianDefence",
    weapons = {},
    access = {}
  },
  -- Повстанцы
  scout = {
    name = "Разведчик",
    group = "implementationDepartment",
    weapons = {},
    access = {}
  },
  spy = {
    name = "Шпион",
    group = "implementationDepartment",
    weapons = {},
    access = {}
  },
  saboteur = {
    name = "Диверсант",
    group = "implementationDepartment",
    weapons = {},
    access = {}
  }
}
