--[[
local FirstPressed = false

hook.Add( "Think", "CallBinding", function()
  local cache = input.IsButtonDown(KEY_Q)

  if cache and FirstPressed then
    core.panel.createPanel(LocalPlayer())
  end

  FirstPressed = !cache
end )
--]]

hook.Add("PlayerKeyPress","BindMenu",function(ply,key)
  if key == KEY_Q then
    if core.panel.isOpen then
      core.panel.destroyPanel()
    else
      core.panel.createPanel(ply)
    end
  end
end)
