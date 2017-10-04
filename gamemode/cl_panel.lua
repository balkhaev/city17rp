local menuOpen = false

function GetKeyPress(ply)
  if input.IsKeyDown(KEY_Q) and menuOpen == false then
    core.panel.createPanel(ply)
    menuOpen = true
  elseif not input.IsKeyDown(KEY_Q) and menuOpen == true then
    core.panel.destroyPanel()
  end
end
hook.Add( "Think", "GetKeyPress", GetKeyPress )

	
function KeyPressed (P, key)
	Msg (P:GetName().." pressed "..key.."\n")
end
 
hook.Add( "KeyPress", "KeyPressedHook", KeyPressed )

local function printKeyReleased( ply, key )
	print( ply:GetName() .. " released " .. key )
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
