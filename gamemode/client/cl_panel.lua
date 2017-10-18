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

function GM:ShowSpare1( ply )
  core.panel.createPanel(ply)
end

function GM:ShowHelp( ply )
  umsg.Start( "motd", ply )
  umsg.End()
  print("asd")
  core.panel.createPanel(ply)
end

hook.Add( "OnSpawnMenuOpen", "SpawnMenuOpen", function()
  local ply = LocalPlayer()

  if not ply:IsAdmin() then
    core.panel.createPanel(ply)

    return false
  end
end )

hook.Add( "OnSpawnMenuClose", "SpawnMenuClose", function()
  if not LocalPlayer():IsAdmin() then
    core.panel.destroyPanel()
  end
end )