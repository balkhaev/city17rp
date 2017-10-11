concommand.Add("setrole", function(ply, cmd, args)
  if args[2] == nil then
    return
  end

  core.role.setPlayerRole(core.utils.getPlayerByNick(args[1]), args[2])
end)
