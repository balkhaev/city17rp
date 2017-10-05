--[[
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
--]]

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
  Msg(ply:hasAccess("managment").."\n")
  if key == KEY_Q then
    if core.panel.isOpen then
      core.panel.destroyPanel()
    else
      core.panel.createPanel(ply)
    end
  end
end)
