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
  administration = {
    name = "Администрация города",
    team = "civilians"
  },
  traders = {
    name = "Торговцы",
    team = "civilians"
  },
  citizens = {
    name = "Жители",
    team = "civilians"
  },
  civilianDefence = {
    name = "Гражданская оборона",
    team = "alliance"
  },
  allianceArmy = {
    name = "Армия Альянса",
    team = "alliance"
  },
  implementationDepartment = {
    name = "Отдел внедрения",
    team = "rebels"
  },
  rebelsArmy = {
    name = "Армия Повстанцев",
    team = "rebels"
  }
}

core.config.roles = {
  citizen = {
    name = "Мирный житель",
    group = "citizens",
    weapons = {"weapon_citizenpackage","weapon_citizensuitcase","weapon_bugbait","weapon_brickbat","weapon_annabelle"}
  },
  rebelsCitizen = {
    name = "Доверенное лицо Повстанцев",
    group = "citizens",
    weapons = {}
  },
  allianceCitizen = {
    name = "Доверенное лицо Альянса",
    group = "citizens",
    weapons = {}
  },
  weaponTrader = {
    name = "Продавец оружия",
    group = "traders",
    weapons = {}
  },
  armorTrader = {
    name = "Продавец брони",
    group = "traders",
    weapons = {}
  },
  representativeMayor = {
    name = "Представитель мера",
    group = "administration",
    weapons = {}
  },
  deputyMayor = {
    name = "Заместитель мера",
    group = "administration",
    weapons = {}
  },
  mayor = {
    name = "Мер",
    group = "administration",
    weapons = {}
  }
}
