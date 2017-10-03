GM.Name = "City 17 RP"
GM.Author = "Narkeba"
GM.Email = "narkeba@gmail.com"
GM.Website = "narkeba.name"

core = {}

include("config/general.lua")
include("libs/core.lua")
include("libs/team.lua")
include("libs/group.lua")
include("libs/role.lua")

core.init(core.config)

for teamKey, team in pairs(core.team.store) do
  team.SetUp(team.index, team.name, team.color)
end
