--[[
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

function GM:ShowSpare2( ply )
  core.panel.createPanel(ply)
end

hook.Add( "OnSpawnMenuOpen", "SpawnMenuOpen", function()
  print("msg111")
  local ply = LocalPlayer()

  if ply:IsAdmin() then
    return true
  end

  core.panel.createPanel(LocalPlayer())

  return false
end )

hook.Add( "OnSpawnMenuClose", "SpawnMenuClose", function()
  print("msg222")

  if ply:IsAdmin() then
    return true
  end

  core.panel.destroyPanel()
end )
