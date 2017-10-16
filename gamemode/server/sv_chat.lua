hook.Add("PlayerCanSeePlayersChat" , "ChatRadius" , function( text, teamOnly, p1 , p2 )
  if ( not IsValid( p1 ) or not IsValid( p2 ) ) then return false end

  if string.lower(string.sub( text, 1, 4) ) == "/ooc" or string.sub( text, 1, 3) == "// " then
    print("ooc worked")
    return true
  end

  if teamOnly then
    print("team only worked")
    return p1:Team() == p2:Team()
  end

  return (p1:GetPos():Distance(p2:GetPos()) <= core.config.defaults.chatRadius)
end)

hook.Add( "PlayerSay", "Chat", function (pl, text, teamonly )
  if string.lower(string.sub(text, 1, 4)) == "/ooc" then
    return "[OOC]".. string.sub( text, 5 )
  elseif string.lower(text) == "/roll" then
    return pl:Nick().." выкинул "..math.random(1,100).."."
  elseif string.sub(text, 1, 3) == "/me" then
    chat.AddText( Color( 100, 100, 255 ), pl, pl:Nick().." "..string.sub(text, 5) )
    return pl:Nick().." "..string.sub(text, 5)
  end
end)
