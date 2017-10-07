core.config = {}

core.config.defaults = {
  role = "citizen",
  access = {"settings"},
  spawnTime = 300,
  money = 1000,
  zombieLimit = 30,
  minZombieLimit = 5
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
    access = {"poll"}
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

--cw_ammo_545x39(cw_ak74),cw_ammo_556x45(cw_ar15),cw_ammo_762x51(cw_g3a3),cw_ammo_9x19(cw_mp5),cw_ammo_50ae(cw_deagle),cw_ammo_338lapua(cw_l115),cw_ammo_44magnum(cw_mr96)

core.config.roles = {
  gman = {
    title = "G-MAN",
    group = "citizens",
    model = "models/player/gman_high.mdl",
    access = {"all"},
    weapons = {"weapon_physgun"}
  },
  -- Мирные жители
  citizen = {
    title = "Мирный житель",
    group = "citizens",
    model = "models/humans/Group01/Male_01.mdl",
    access = {},
    weapons = {}
  },
  rebelsCitizen = {
    title = "Доверенное лицо Повстанцев",
    group = "citizens",
    model = "models/humans/Group01/Male_01.mdl",
    access = {},
    weapons = {}
  },
  allianceCitizen = {
    title = "Доверенное лицо Альянса",
    group = "citizens",
    model = "models/humans/Group01/Male_01.mdl",
    access = {},
    weapons = {}
  },
  weaponTrader = {
    title = "Продавец оружия",
    group = "traders",
    model = "models/humans/Group01/Male_01.mdl",
    access = {},
    weapons = {}
  },
  armorTrader = {
    title = "Продавец брони",
    group = "traders",
    model = "models/humans/Group01/Male_01.mdl",
    access = {},
    weapons = {}
  },
  representativeMayor = {
    title = "Представитель мера",
    group = "administration",
    model = "",
    access = {},
    weapons = {}
  },
  deputyMayor = {
    title = "Заместитель мера",
    group = "administration",
    model = "",
    access = {},
    weapons = {}
  },
  mayor = {
    title = "Мер",
    group = "administration",
    model = "models/player/breen.mdl",
    access = {"managment"},
    weapons = {}
  },
  -- Гражданская оборона
  recruit = {
    title = "Рекрут",
    group = "civilianDefence",
    model = "models/player/Police.mdl",
    access = {},
    weapons = {"weapon_stunstick","guigui_handcuffs","weapon_stunner2","weapon_stunner"}
  },
  patrol = {
    title = "Патрульный",
    group = "civilianDefence",
    model = "models/player/Police.mdl",
    access = {},
    weapons = {"weapon_stunstick","cw_deagle","guigui_handcuffs","weapon_stunner2","weapon_stunner"}
  },
  corporalGuard = {
    title = "Разводящий",
    group = "civilianDefence",
    model = "models/player/Police.mdl",
    access = {},
    weapons = {"weapon_stunstick","weapon_pistol","guigui_handcuffs","weapon_stunner2","weapon_stunner"}
  },
  chiefCivilDefence = {
    title = "Начальник Гражданской обороны",
    group = "civilianDefence",
    model = "models/player/Combine_Soldier_PrisonGuard.mdl",
    access = {"managment"},
    weapons = {"weapon_stunstick","weapon_pistol","guigui_handcuffs","weapon_stunner2","weapon_stunner","cw_ak74"}
  },
  -- Армия Альянс
  combineRanker = {
    title = "Рядовой",
    group = "allianceArmy",
    model = "models/player/Combine_Soldier.mdl",
    access = {},
    weapons = {"weapon_pistol"}
  },
  combineSoldier = {
    title = "Солдат",
    group = "allianceArmy",
    model = "models/player/Combine_Soldier.mdl",
    access = {},
    weapons = {"cw_ar15","weapon_smg1","weapon_pistol"}
  },
  combineHeavySoldier = {
    title = "Тяжелый солдат",
    group = "allianceArmy",
    model = "models/player/Combine_Soldier.mdl",
    access = {},
    weapons = {"weapon_shotgun","weapon_smg1","weapon_pistol"}
  },
  combineSergeant = {
    title = "Сержант",
    group = "allianceArmy",
    model = "models/player/Combine_Soldier.mdl",
    access = {},
    weapons = {"weapon_ar2","weapon_smg1","weapon_pistol"}
  },
  -- Отдел внедрения
  scout = {
    title = "Разведчик",
    group = "implementationDepartment",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_357","cw_g3a3"},
    camouflage = {
      citizen = "models/player/Group01/Male_01.mdl"
    }
  },
  spy = {
    title = "Шпион",
    group = "implementationDepartment",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_357"},
    camouflage = {
      citizen = "models/player/Group01/Male_01.mdl",
      recruit = "models/player/Police.mdl"
    }
  },
  saboteur = {
    title = "Диверсант",
    group = "implementationDepartment",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_357"},
    camouflage = {
      citizen = "models/player/Group01/Male_01.mdl",
      recruit = "models/player/Police.mdl",
      soldier = "models/player/Combine_Soldier.mdl"
    }
  },
  chiefImplementationDepartament = {
    title = "Глава Отдела внедрения",
    group = "implementationDeprtament",
    model = "models/player/Group03/Male_01.mdl",
    access = {"managment"},
    weapons = {"weapon_357"},
    camouflage = {
      citizen = "models/player/Group01/Male_01.mdl",
      recruit = "models/player/Police.mdl",
      soldier = "models/player/Combine_Soldier.mdl"
    }
  },
  -- Армия Сопративления
  rebelsRanker = {
    title = "Рядовой",
    group = "rebels",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_pistol"}
  },
  rebelsSoldier = {
    title = "Солдат",
    group = "rebels",
    model = "models/player/Group03/Male_02.mdl",
    access = {},
    weapons = {"weapon_smg1","weapon_pistol"}
  },
  rebelsAssaulter = {
    title = "Штурмовик",
    group = "rebels",
    model = "models/player/Group03/Male_03.mdl",
    access = {},
    weapons = {"weapon_smg1","weapon_pistol"}
  },
  rebelSniper = {
    title = "Снайпер",
    group = "rebels",
    model = "models/player/Group03/Male_03.mdl",
    access = {},
    weapons = {"cw_l115","weapon_pistol"}
  },
  rebelsSergeant = {
    title = "Сержант",
    group = "rebels",
    model = "models/player/Group03/Male_04.mdl",
    access = {},
    weapons = {"weapon_smg1","weapon_pistol"}
  },
}
