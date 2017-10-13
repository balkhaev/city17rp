local conf = {
  alyxSpawnVector = Vector()
}

hook.Add( "InitPostEntity", "SpawnAlyx", function()
  local alyx = ents.Create( "npc_alyx" )
  alyx:StripWeapons()
  alyx:SetPos( conf.alyxSpawnVector )
  alyx:SetName("Alyx")
  alyx:Spawn()
end )
