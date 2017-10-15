core.config = {}

core.config.defaults = {
  role = "citizen",
  access = {"settings"},
  spawnTime = 10,
  voiceRadius = 1000,
  money = 1000,
  zombieLimit = 60,
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
    spawn = {"6437.854004,-1430.561279,4220.031250"},
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
    spawn = {"4419.1293945313,312.06140136719,90.03125","4095.565918,313.184845,90.031250","3966.547852,212.987381,90.031250","4004.686768,347.076691,90.031250","4281.187988,190.602524,90.031250","4706.687012,357.306213,90.031250","4853.449219,341.679016,90.031250","4839.239258,201.259186,90.031250","4831.524414,67.929428,90.031250","4753.032715,63.711517,90.031250","4753.472168,151.331009,90.031250","4742.128418,248.027023,90.031250"},
    access = {}
  },
  ota = {
    title = "Overwatch Transhuman Arm",
    team = "alliance",
    spawn = {"4419.1293945313,312.06140136719,90.03125","4095.565918,313.184845,90.031250","3966.547852,212.987381,90.031250","4004.686768,347.076691,90.031250","4281.187988,190.602524,90.031250","4706.687012,357.306213,90.031250","4853.449219,341.679016,90.031250","4839.239258,201.259186,90.031250","4831.524414,67.929428,90.031250","4753.032715,63.711517,90.031250","4753.472168,151.331009,90.031250","4742.128418,248.027023,90.031250"},
    access = {}
  },
  -- Повстанцы
  implementationDepartment = {
    title = "Отдел внедрения",
    team = "rebels",
    spawn = {"-3369.4533691406,-2147.1401367188,80.03125","-3383.854248,-2053.615723,80.031250","-3388.353271,-1961.415161,80.031250","-3307.349121,-1958.488647,80.031250","-3306.977295,-2045.555054,80.031250","-3307.333252,-2135.121826,80.031250","-3307.865967,-2232.508057,80.031250","-3308.638428,-2335.323242,80.031250","-3309.332031,-2402.856934,80.031250","-3426.955566,-2423.624512,80.031250","-3424.474854,-2340.374023,80.031250"},
    access = {"camouflage"}
  },
  rebelsArmy = {
    title = "Армия Повстанцев",
    team = "rebels",
    spawn = {"-3369.4533691406,-2147.1401367188,80.03125","-3383.854248,-2053.615723,80.031250","-3388.353271,-1961.415161,80.031250","-3307.349121,-1958.488647,80.031250","-3306.977295,-2045.555054,80.031250","-3307.333252,-2135.121826,80.031250","-3307.865967,-2232.508057,80.031250","-3308.638428,-2335.323242,80.031250","-3309.332031,-2402.856934,80.031250","-3426.955566,-2423.624512,80.031250","-3424.474854,-2340.374023,80.031250"},
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
    access = {"admin"},
    weapons = {"weapon_physgun","gods_little_finger_v2"},
    salary = 0
  },
  -- Мирные жители
  citizen = {
    title = "Мирный житель",
    group = "citizens",
    model = "models/player/Group01/Male_09.mdl",
    access = {},
    weapons = {"weapon_empty_hands","weapon_fists"},
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
    model = "models/player/Group01/Male_03.mdl",
    access = {"trade","weaponTrade"},
    weapons = {"weapon_empty_hands","weapon_hl2pan","cw_mr96"},
    salary = 10
  },
  droneTrader = {
    title = "Продавец дронов",
    group = "citizens",
    model = "models/player/Group01/Male_04.mdl",
    access = {"trade","droneTrade"},
    weapons = {"weapon_empty_hands","weapon_hl2pan","cw_mr96"},
    salary = 10
  },
  -- Мерия
  representativeMayor = {
    title = "Представитель мера",
    group = "administration",
    model = "models/player/female_02_suit.mdl",
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
  crct = {
    title = "Рекрут",
    group = "civilianDefence",
    model = "models/dpfilms/metropolice/playermodels/pm_retrocop.mdl",
    access = {},
    weapons = {"weapon_empty_hands","weapon_stunner_stun","weapon_cuff_standard"},
    salary = 5
  },
  cpvt = {
    title = "Рядовой",
    group = "civilianDefence",
    model = "models/dpfilms/metropolice/playermodels/pm_urban_police.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_p99","weapon_stunner_stun","weapon_cuff_elastic"},
    salary = 10
  },
  ccpl = {
    title = "Капрал",
    group = "civilianDefence",
    model = "models/dpfilms/metropolice/playermodels/pm_policetrench.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_g36c","cw_p99","weapon_stunner_stun","weapon_cuff_elastic"},
    salary = 15
  },
  ccpt = {
    title = "Капитан ГО",
    group = "civilianDefence",
    model = "models/dpfilms/metropolice/playermodels/pm_hunter_police.mdl",
    access = {"managment"},
    weapons = {"weapon_empty_hands","cw_ar15","cw_p99","weapon_stunner_stun","weapon_cuff_elastic"},
    salary = 20
  },
  ccmd = {
    title = "Командир ГО",
    group = "civilianDefence",
    model = "models/dpfilms/metropolice/playermodels/pm_rtb_police.mdl",
    access = {"managment"},
    weapons = {"weapon_empty_hands","cw_l85a2","cw_deagle","weapon_stunner_stun","weapon_cuff_elastic"},
    salary = 25
  },
  -- Армия Альянс
  ows = {
    title = "Солдат",
    group = "ota",
    model = "models/player/Combine_Soldier.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_ar15","cw_fiveseven"},
    salary = 10
  },
  owc = {
    title = "Тяжелый солдат",
    group = "ota",
    model = "models/player/Combine_Soldier_PrisonGuard.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_shorty","cw_m249_official","weapon_hexshield","cw_fiveseven"},
    salary = 15
  },
  eow = {
    title = "Элитный солдат",
    group = "ota",
    model = "models/player/Combine_Super_Soldier.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_m14","cw_scarh","weapon_hexshield","cw_fiveseven"},
    salary = 20
  },
  -- Отдел внедрения
  scout = {
    title = "Разведчик",
    group = "implementationDepartment",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_mp5","cw_m1911"},
    salary = 10,
    camouflage = { "citizen", "crct" }
  },
  spy = {
    title = "Шпион",
    group = "implementationDepartment",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_ump45","cw_m1911"},
    salary = 15,
    camouflage = { "citizen", "crct", "ows" }
  },
  saboteur = {
    title = "Диверсант",
    group = "implementationDepartment",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_vss","cw_m1911"},
    salary = 20,
    camouflage = { "citizen", "crct", "ows", "owc" }
  },
  chiefID = {
    title = "Глава Отдела внедрения",
    group = "implementationDepartment",
    model = "models/player/Group03/Male_01.mdl",
    access = {"managment"},
    weapons = {"weapon_empty_hands","cw_vss","cw_m1911"},
    salary = 25,
    camouflage = { "citizen", "crct", "ows", "owc" }
  },
  -- Армия Сопративления
  rrct = {
    title = "Рекрут",
    group = "rebelsArmy",
    model = "models/player/Group03/Male_01.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_mac11","cw_makarov","weapon_hl2pan"},
    salary = 5
  },
  rpvt = {
    title = "Рядовой",
    group = "rebelsArmy",
    model = "models/player/Group03/Male_02.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_ak74","cw_makarov","weapon_hl2pan"},
    salary = 10
  },
  rcpl = {
    title = "Капрал",
    group = "rebelsArmy",
    model = "models/player/Group03/Male_03.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_ak74","cw_ump45","cw_makarov","weapon_hl2pickaxe"},
    salary = 15
  },
  rsgt = {
    title = "Сержант",
    group = "rebelsArmy",
    model = "models/player/Group03/Male_04.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_g3a3","cw_ump45","cw_makarov","weapon_hl2hook"},
    salary = 20
  },
  rlt = {
    title = "Лейтенант",
    group = "rebelsArmy",
    model = "models/player/Group03/Male_03.mdl",
    access = {},
    weapons = {"weapon_empty_hands","cw_l115","cw_g3a3","cw_makarov","weapon_hl2shovel"},
    salary = 15
  }
}
