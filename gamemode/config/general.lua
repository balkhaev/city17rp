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
    spawn = {"548.93084716797,3056.7243652344,80.03125"},
    access = {"poll"}
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
    spawn = {"4419.1293945313,312.06140136719,76.03125"},
    access = {"arrest"}
  },
  allianceArmy = {
    title = "Армия Альянса",
    team = "alliance",
    spawn = {"4419.1293945313,312.06140136719,76.03125"},
    access = {}
  },
  -- Повстанцы
  implementationDepartment = {
    title = "Отдел внедрения",
    team = "rebels",
    spawn = {"-3369.4533691406,-2147.1401367188,80.03125"},
    access = {"camouflage"}
  },
  rebelsArmy = {
    title = "Армия Повстанцев",
    team = "rebels",
    spawn = {"-2779.6267089844,-1745.1755371094,80.03125","-3369.4533691406,-2147.1401367188,80.03125"},
    access = {}
  }
}

-- CW: cw_ammo_545x39(cw_ak74),cw_ammo_556x45(cw_ar15),cw_ammo_762x51(cw_g3a3),cw_ammo_9x19(cw_mp5),cw_ammo_50ae(cw_deagle),cw_ammo_338lapua(cw_l115),cw_ammo_44magnum(cw_mr96)
-- ECW: cw_shorty,cw_vss,cw_makarov,cw_p99,cw_mac11,cw_m3super90,cw_m249_official,cw_m1911,cw_m14,cw_l85a2
-- HLMelee: weapon_hl2axe,weapon_hl2bottle,weapon_hl2brokenbottle,weapon_hl2hook,weapon_hl2pan,weapon_hl2pipe,weapon_hl2pickaxe,weapon_hl2pot,weapon_hl2shovel
-- weapon_stunner_stun,weapon_stunner_shock

core.config.roles = {
  gman = {
    title = "G-MAN",
    group = "citizens",
    model = "models/player/gman_high.mdl",
    access = {"all"},
    weapons = {"weapon_physgun","gods_little_finger_v2"},
    salary = 0
  },
  -- Мирные жители
  citizen = {
    title = "Мирный житель",
    group = "citizens",
    model = "models/humans/Group01/Male_02.mdl",
    access = {},
    weapons = {"weapon_empty_hands","weapon_hl2pan"},
    salary = 5
  },
  --[[
  rebelsCitizen = {
    title = "Доверенное лицо Повстанцев",
    group = "citizens",
    model = "models/humans/Group01/Male_01.mdl",
    access = {},
    weapons = {"weapon_empty_hands","weapon_hl2pan"}
  },
  allianceCitizen = {
    title = "Доверенное лицо Альянса",
    group = "citizens",
    model = "models/humans/Group01/Male_01.mdl",
    access = {},
    weapons = {"weapon_hl2pan"}
  },
  --]]
  weaponTrader = {
    title = "Продавец оружия",
    group = "citizens",
    model = "models/humans/Group01/Male_03.mdl",
    access = {"trade","weaponTrade"},
    weapons = {"weapon_empty_hands","weapon_hl2pan","cw_mr96"},
    salary = 10
  },
  droneTrader = {
    title = "Продавец дронов",
    group = "citizens",
    model = "models/humans/Group01/Male_04.mdl",
    access = {"trade","droneTrade"},
    weapons = {"weapon_empty_hands","weapon_hl2pan","cw_mr96"},
    salary = 10
  },
  armorTrader = {
    title = "Продавец брони",
    group = "citizens",
    model = "models/humans/Group01/Male_05.mdl",
    access = {"trade","armorTrade"},
    weapons = {"weapon_empty_hands","weapon_hl2pan","cw_mr96"},
    salary = 10
  },
  -- Мерия
  representativeMayor = {
    title = "Представитель мера",
    group = "administration",
    model = "models/humans/suitfem/female_02.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_deagle"},
    salary = 15
  },
  deputyMayor = {
    title = "Заместитель мера",
    group = "administration",
    model = "models/taggart/gallahan.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_deagle"},
    salary = 20
  },
  mayor = {
    title = "Мер",
    group = "administration",
    model = "models/player/breen.mdl",
    access = {"managment"},
    weapons = {"weapon_empty_hands","cw_deagle"},
    salary = 25
  },
  -- Гражданская оборона
  recruit = {
    title = "Рекрут",
    group = "civilianDefence",
    model = "models/dpfilms/metropolice/playermodels/pm_retrocop.mdl",
    access = {},
    weapons = {"weapon_empty_hands","guigui_handcuffs","weapon_stunner_stun"},
    salary = 5
  },
  patrol = {
    title = "Патрульный",
    group = "civilianDefence",
    model = "models/dpfilms/metropolice/playermodels/pm_urban_police.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_p99","guigui_handcuffs","weapon_stunner_stun"},
    salary = 10
  },
  corporalGuard = {
    title = "Разводящий",
    group = "civilianDefence",
    model = "models/dpfilms/metropolice/playermodels/pm_policetrench.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_p99","cw_mp5","guigui_handcuffs","weapon_stunner_stun"},
    salary = 15
  },
  deputyChiefCivilDefence = {
    title = "Заместитель начальника Гражданской обороны",
    group = "civilianDefence",
    model = "models/dpfilms/metropolice/playermodels/pm_hunter_police.mdl",
    access = {"managment"},
    weapons = {"weapon_empty_hands","cw_p99","guigui_handcuffs","weapon_stunner_stun","cw_ar15"},
    salary = 20
  },
  chiefCivilDefence = {
    title = "Начальник Гражданской обороны",
    group = "civilianDefence",
    model = "models/dpfilms/metropolice/playermodels/pm_rtb_police.mdl",
    access = {"managment"},
    weapons = {"weapon_empty_hands","cw_p99","guigui_handcuffs","weapon_stunner_stun","cw_ar15"},
    salary = 25
  },
  -- Армия Альянс
  combineRanker = {
    title = "Рядовой",
    group = "allianceArmy",
    model = "models/player/Combine_Soldier.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_fiveseven"},
    salary = 5
  },
  combineSoldier = {
    title = "Солдат",
    group = "allianceArmy",
    model = "models/player/Combine_Soldier.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_ar15","cw_ump45","cw_fiveseven"},
    salary = 10
  },
  combineHeavySoldier = {
    title = "Тяжелый солдат",
    group = "allianceArmy",
    model = "models/player/Combine_Soldier.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_shorty","cw_m249_official","weapon_hexshield","weapon_pistol"},
    salary = 15
  },
  combineSergeant = {
    title = "Сержант",
    group = "allianceArmy",
    model = "models/player/Combine_Soldier.mdl",
    access = {},
    weapons = {"weapon_empty_hands","weapon_ar2","cw_m14","cw_ump45","weapon_pistol"},
    salary = 20
  },
  -- Отдел внедрения
  scout = {
    title = "Разведчик",
    group = "implementationDepartment",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_empty_hands","weapon_357","cw_g3a3"},
    salary = 10,
    camouflage = { "citizen" }
  },
  spy = {
    title = "Шпион",
    group = "implementationDepartment",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_empty_hands","weapon_357","cw_m14"},
    salary = 15,
    camouflage = { "citizen", "recruit" }
  },
  saboteur = {
    title = "Диверсант",
    group = "implementationDepartment",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_empty_hands","weapon_357","cw_vss"},
    salary = 20,
    camouflage = { "citizen", "recruit", "combineSoldier" }
  },
  chiefImplementationDepartament = {
    title = "Глава Отдела внедрения",
    group = "implementationDeprtament",
    model = "models/player/Group03/Male_01.mdl",
    access = {"managment"},
    weapons = {"weapon_empty_hands","weapon_357","cw_vss"},
    salary = 25,
    camouflage = { "citizen", "recruit", "combineSoldier" }
  },
  -- Армия Сопративления
  rebelsRanker = {
    title = "Рядовой",
    group = "rebelsArmy",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_mac11","cw_makarov"},
    salary = 5
  },
  rebelsSoldier = {
    title = "Солдат",
    group = "rebelsArmy",
    model = "models/player/Group03/Male_02.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_ak74","cw_makarov"},
    salary = 10
  },
  rebelsAssaulter = {
    title = "Штурмовик",
    group = "rebelsArmy",
    model = "models/player/Group03/Male_03.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_ak74","cw_ump45","cw_makarov"},
    salary = 15
  },
  rebelSniper = {
    title = "Снайпер",
    group = "rebelsArmy",
    model = "models/player/Group03/Male_03.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_l115","cw_makarov"},
    salary = 15
  },
  rebelsSergeant = {
    title = "Сержант",
    group = "rebelsArmy",
    model = "models/player/Group03/Male_04.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_ak74","cw_ump45","cw_makarov"},
    salary = 20
  },
}
