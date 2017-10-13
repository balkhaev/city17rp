concommand.Add("setrole", function(ply, cmd, args)
  if args[2] == nil then
    return
  end

  local player = core.utils.getPlayerByNick(args[1])

  player:setRole(args[2])
end)
