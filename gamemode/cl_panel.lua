local menuIsOpen  = false

hook.Add("Think", "openGeneralMenu", function()

  if input.IsKeyDown(KEY_Q) and menuIsOpen == false then
    menuIsOpen = true
    core.panel.createPanel(LocalPlayer())
  elseif menuIsOpen == true then
    core.panel.destroyPanel()
  end

end)
