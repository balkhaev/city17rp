hook.Add("PlayerKeyPress","BindMenu",function(ply,key)
  Msg("PlayerKeyPress")
  if key == KEY_Q then core.panel.createPanel(ply) end
end)

hook.Add("Think", "Call_Admin_Thingy", function()
  Msg("Think")
  if input.IsKeyDown(27) then
    core.panel.createPanel(ply)
  end
end)
