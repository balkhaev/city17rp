local menuIsOpen  = false

hook.Add("Think", "openGeneralMenu", function()

  if input.IsKeyDown(KEY_Q) and menuIsOpen == false then
    menuIsOpen = true -- Enables antispam, doesn't make them like say it 5000 times a second lol
    core.panel.createPanel(core.player)
  elseif menuIsOpen == true then
    core.panel.destroyPanel()
  end

end)
