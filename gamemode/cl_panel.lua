function KeyPressed (P, key)
  Msg(key)
  if key == 8 then
    core.panel.createPanel(ply)
  end
end
 
hook.Add( "KeyPress", "KeyPressedHook", KeyPressed )

local function printKeyReleased( ply, key )
  if key == 8 then
    core.panel.destroyPanel(ply)
  end
end
 
hook.Add( "KeyRelease", "KeyReleasedHook", printKeyReleased )

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
