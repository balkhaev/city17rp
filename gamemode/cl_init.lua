core = {}

include("shared.lua")
include("config/general.lua")
include("libs/core.lua")
include("libs/role/team.lua")
include("libs/role/group.lua")
include("libs/role/role.lua")

core.init(core.config)

for teamKey, teamVal in pairs(core.team.store) do
  team.SetUp(teamVal.index, teamVal.name, teamVal.color)
end
