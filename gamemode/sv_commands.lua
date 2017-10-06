concommand.Add("getspawnpoint", function(ply, cmd, args)
  local x,y,z = ply:GetPos().x,ply:GetPos().y,ply:GetPos().z
  Msg(x..","..y..","..z)
end)

concommand.Add("setrole", function(ply, cmd, args)
    PrintTable(ply)
  if not ply:IsUserGroup("superadmin") and not ply:hasAccess("managment") then
    return
  end

  if args[1] == nil then
    return
  end
  if args[2] ~= nil then
    core.role.setPlayerRole(ply:getPlayerByName(args[1]), args[2])
    return
  end

  core.role.setPlayerRole(ply, args[1])
end)
