GM.Name = "City 17 RP"
GM.Author = "Narkeba"
GM.Email = "narkeba@gmail.com"
GM.Website = "narkeba.name"

core = {}

include("config/general.lua")
include("libs/team.lua")
include("libs/group.lua")
include("libs/role.lua")

core.team.init(core.config.teams)
core.role.init(core.config.roles)

for teamKey, team in pairs(core.team.store) do
  team.SetUp(team.index, team.name, team.color)
end
