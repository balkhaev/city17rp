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
  if key == KEY_Q then
    if core.panel.isOpen then
      core.panel.destroyPanel()
    else
      core.panel.createPanel(ply)
    end
  end
end)

local ply = LocalPlayer();
local Tags = {}
Tags["owner"] = "Owner";
Tags["superadmin"] = "Super Admin";
Tags["admin"] = "Administrator";
Tags["mod"] = "Moderator";
Tags["vip"] = "VIP";
Tags["operator"] = "DJ";
Tags["user"] = "";
-- Example Tags["USERGROUP"] = "DISPLAY NAME";

hook.Add("PostDrawOpaqueRenderables", "drawadminname", function()
  for k, ply in pairs( player.GetAll() ) do
    if not ply:Alive() then
      return
    end

    local offset = Vector(0, 0, 85)
    local offset2 = Vector(0, 0, 80)
    local offset3 = Vector(0, 0, 75)
    local offset4 = Vector(0, 0, 70)
    local ang = LocalPlayer():EyeAngles()
    local pos = ply:GetPos() + offset + ang:Up()
    local pos2 = ply:GetPos() + offset2 + ang:Up()
    local pos3 = ply:GetPos() + offset3 + ang:Up()
    local pos4 = ply:GetPos() + offset4 + ang:Up()
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 90)
    local tag = Tags[ply:GetUserGroup()]
    if tag and (team.GetName(LocalPlayer():Team()) == team.GetName(ply:Team())) then
      cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.25)
      draw.SimpleTextOutlined(ply:Nick(), "Trebuchet24", 1, 1, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, 1, 1, HSVToColor( ply:Health(), 1, 1) )
      cam.End3D2D()
      cam.Start3D2D(pos2, Angle(0, ang.y, 90), 0.25)
      draw.SimpleTextOutlined(tag, "Trebuchet24", 2, 2, HSVToColor(math.abs(math.sin(CurTime() * 0.1) * 335), 1, 1), TEXT_ALIGN_CENTER, 1, 1, Color(0, 0, 0))
      cam.End3D2D()
      cam.Start3D2D(pos3, Angle(0, ang.y, 90), 0.25)
      draw.SimpleTextOutlined("Armor: " .. ply:Armor(), "Trebuchet24", 3, 3, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, 1, 1, HSVToColor( ply:Armor(), 1, 1) )
      cam.End3D2D()
      cam.Start3D2D(pos4, Angle(0, ang.y, 90), 0.25)
      draw.SimpleTextOutlined("Health: " .. ply:Health(), "Trebuchet24", 3, 3, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, 1, 1, HSVToColor( ply:Health(), 1, 1) )
      cam.End3D2D()
    end
  end
end)