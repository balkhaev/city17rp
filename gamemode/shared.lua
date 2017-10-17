DeriveGamemode( "sandbox" )

GM.Name = "City 17 RP"
GM.Author = "Narkeba"
GM.Email = "narkeba@gmail.com"
GM.Website = "narkeba.name"

if SERVER then
  concommand.Add("cl_keypress",function(pl,cmd,args)
    local n = tonumber(args[1])
    hook.Call("PlayerKeyPress",GAMEMODE,pl,n)
  end)
else
  local keys_pressed = {}
  hook.Add("Think","CheckKeyPress",function()
    for i =1, 130 do
      if input.IsKeyDown( i ) then
        if keys_pressed[i] then return end
        RunConsoleCommand( "cl_keypress", i )
        hook.Call("PlayerKeyPress",GAMEMODE,LocalPlayer(),i)
        keys_pressed[i] = true
      elseif keys_pressed[i] then keys_pressed[i] = nil
      end
    end
  end)
end
