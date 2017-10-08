function KeyPressedUse (ply, key)
  if key == IN_USE then
    local t = {}
    t.start = ply:GetPos()
    t.endpos = ply:GetShootPos() + ply:GetAimVector() * 100
    t.filter = ply
    local trace = util.TraceLine(t)
    if trace.Entity and trace.Entity:IsValid() and (trace.Entity:GetClass() == "func_door" or trace.Entity:GetClass() == "prop_door_rotating" or trace.Entity:GetClass() == "prop_dynamic") then
      trace.Entity:Fire("Open")
    end
  end
end
hook.Add( "KeyPress", "KeyPressedUse", KeyPressedUse )