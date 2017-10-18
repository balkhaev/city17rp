--[[
local FirstPressed = false

hook.Add( "Think", "CallBinding", function()
  local cache = input.IsButtonDown(KEY_Q)

  if cache and FirstPressed then
    core.panel.createPanel(LocalPlayer())
  end

  FirstPressed = !cache
end )

hook.Add("PlayerKeyPress","BindMenu",function(ply,key)
  if key == KEY_Q then
    if core.panel.isOpen then
      core.panel.destroyPanel()
    else
      core.panel.createPanel(ply)
    end
  end
end)
--]]

hook.Add( "OnSpawnMenuOpen", "SpawnMenuOpen", function()
  print("msg111")
  core.panel.createPanel(LocalPlayer())

  return false
end )

hook.Add( "OnSpawnMenuClose", "SpawnMenuClose", function()
  print("msg222")
  core.panel.destroyPanel()
end )
