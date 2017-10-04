hook.Add("PlayerKeyPress","BindMenu",function(ply,key)
  Msg("PlayerKeyPress")
  if key == KEY_Q then core.panel.createPanel(ply) end
end)

hook.Add("Think", "Call_Admin_Thingy", function()
  Msg("Think")
	if input.IsKeyDown(KP_F9) and antispam == false then
		antispam = true -- Enables antispam, doesn't make them like say it 5000 times a second lol
		LocalPlayer():ConCommand("say /calladmin") -- makes them say the command

		timer.Simple(time, function() -- This part resets the antispam, making it re-useable after _N_ seconds.
			antispam = false
		end)
	end
end)
