hook.Add("PlayerKeyPress","BindMenu",function(ply,key)
  if key == KEY_Q then core.panel.createPanel(ply) end
end)
