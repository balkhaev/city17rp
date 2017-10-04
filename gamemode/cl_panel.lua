local menuIsOpen  = false

hook.Add("Think", "openGeneralMenu", function()

  if input.IsKeyDown(KEY_Q) and menuIsOpen == false then
    menuIsOpen = true
    core.panel.createPanel(LocalPlayer())
  elseif not input.IsKeyDown(KEY_Q) and menuIsOpen == true then
    menuIsOpen = false
    core.panel.destroyPanel()
  end

end)
