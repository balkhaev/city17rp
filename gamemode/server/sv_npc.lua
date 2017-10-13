local conf = {
  alyxSpawnVector = Vector()
}

hook.Add( "InitPostEntity", "SpawnAlyx", function()
  local alyx = ents.Create( "npc_alyx" )
  alyx:StripWeapons()
  alyx:SetPos( conf.alyxSpawnVector )
  alyx:SetName("Alyx")
  alyx:Spawn()

  local allianceGangs = core.role.getTeamGangs("alliance")
  local rebelsGangs = core.role.getTeamGangs("rebels")

  for steamID, playerName in pairs(allianceGangs) do
    alyx:AddEntityRelationship( steamID, D_FR, 99 )
  end

  for steamID, playerName in pairs(rebelsGangs) do
    alyx:AddEntityRelationship( steamID, D_LI, 99 )
  end
end )
