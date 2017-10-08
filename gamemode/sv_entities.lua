hook.Add( "InitPostEntity", "SpawnAmmoCrate", function()
  local ammoCrate = ents.Create("cw_ammo_crate_regular")
  if not IsValid( ammoCrate ) then return end
  ammoCrate:SetPos( Vector( 3408.012207,-1483.628174,162.946945 ) )
  ammoCrate:Spawn()
end )