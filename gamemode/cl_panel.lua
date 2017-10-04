hook.Add("Think", "openGeneralMenu", function()
  if input.WasKeyPressed(27) then
    core.panel.createPanel(ply)
  end
  if input.WasKeyReleased(27) then
    core.panel.destroyPanel()
  end
end)

--[[
local antispam 	= false -- Dont edit c:
local time 		= 60 -- Set your anti spam time here

hook.Add("Think", "Call_Admin_Thingy", function()
  Msg("Think")
  if input.IsKeyDown(27) and antispam == false then
		antispam = true -- Enables antispam, doesn't make them like say it 5000 times a second lol
		core.panel.createPanel(ply)

		timer.Simple(time, function() -- This part resets the antispam, making it re-useable after _N_ seconds.
			antispam = false
		end)
  end
end)
--]]
