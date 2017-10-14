core.npc = {}
core.npc.store = {}

local conf = {
  alyxSpawnVector = Vector(4365.419434,-711.756287,140.031250)
}

hook.Add( "InitPostEntity", "SpawnAlyx", function()
  local alyx = ents.Create( "npc_alyx" )
  alyx:SetPos( conf.alyxSpawnVector )
  alyx:SetName("Alyx")
  alyx:Spawn()

  table.insert(core.npc.store, alyx)
end )

function core.npc.addRelation(ply)
  for i,npc in pairs(core.npc.store) do
    local team = ply:getTeam()

    if team.name == "rebels" then
      npc:AddEntityRelationship( ply, D_LI, 99 )
    elseif team.name == "alliance" then
      npc:AddEntityRelationship( ply, D_FR, 99 )
    end
  end
end