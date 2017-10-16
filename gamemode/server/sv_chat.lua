function GM:PlayerCanSeePlayersChat(text, teamOnly, p1 , p2)
  if ( not IsValid( p1 ) or not IsValid( p2 ) ) then return false end

  if string.lower(string.sub( text, 1, 4) ) == "/ooc" or string.sub( text, 1, 2) == "//" then
    return true
  end

  if teamOnly then
    return p1:Team() == p2:Team()
  end

  if p1:GetPos():Distance(p2:GetPos()) <= core.config.defaults.chatRadius then
    if string.sub(text, 1, 3) == "/me" then
      p1:ChatPrint(p2:Nick().." "..string.sub(text, 4))
      return false
    end

    if string.lower(text) == "/roll" then
      p1:ChatPrint(p2:Nick().." выкинул "..math.random(1,100)..".")
      return false
    end

    return true
  end

  return false
end

hook.Add( "PlayerSay", "Chat", function (pl, text, teamonly )
  if string.sub( text, 1, 2) == "//" then
    return "[OOC] ".. string.sub( text, 3 )
  end
  if string.lower(string.sub( text, 1, 4) ) == "/ooc" then
    return "[OOC]".. string.sub( text, 5 )
  end
end)
