local menuIsOpen  = false

hook.Add("Think", "openGeneralMenu", function()

  if input.IsKeyDown(KEY_Q) and menuIsOpen == false then
    local ply = core.role.getRoleBySteamID(LocalPlayer():SteamID())
    menuIsOpen = true
    core.panel.createPanel(ply)
  elseif menuIsOpen == true then
    core.panel.destroyPanel()
  end

end)
