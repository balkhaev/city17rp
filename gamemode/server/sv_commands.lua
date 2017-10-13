concommand.Add("setrole", function(ply, cmd, args)
  if args[2] == nil then
    return
  end

  local player = core.utils.getPlayerByNick(args[1])

  player:setRole(args[2])
end)

concommand.Add( "rollthedice", function( ply )
  PrintMessage( HUD_PRINTTALK, ply:Nick().." выкинул "..math.random(1,100)..".")
end )
