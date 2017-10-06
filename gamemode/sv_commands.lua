concommand.Add("getspawnpoint", function(ply, cmd, args)
  local x,y,z = ply:GetPos().x,ply:GetPos().y,ply:GetPos().z
  Msg(x..","..y..","..z)
end)

concommand.Add("setrole", function(ply, cmd, args)
  if args[2] == nil then
    return
  end

  core.role.setPlayerRole(player:getPlayerByName(args[1]), args[2])
end)
