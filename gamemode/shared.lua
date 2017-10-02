GM.Name = "City 17 RP"
GM.Author = "Narkeba"
GM.Email = "narkeba@gmail.com"
GM.Website = "narkeba.name"

for teamKey, team in pairs(core.team.store) do
  team.SetUp(team.index, team.name, team.color)
end
