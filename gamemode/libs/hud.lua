core.hud = { };
 
local function clr( color ) return color.r, color.g, color.b, color.a; end
 
function core.hud.paintBar( x, y, w, h, colors, value )
  core.hud.paintPanel( x, y, w, h, colors );

  x = x + 1; y = y + 1;
  w = w - 2; h = h - 2;

  local width = w * math.Clamp( value, 0, 1 );
  local shade = 4;

  surface.SetDrawColor( clr( colors.shade ) );
  surface.DrawRect( x, y, width, shade );

  surface.SetDrawColor( clr( colors.fill ) );
  surface.DrawRect( x, y + shade, width, h - shade );
end
 
function core.hud.paintPanel( x, y, w, h, colors )
  surface.SetDrawColor( clr( colors.border ) );
  surface.DrawOutlinedRect( x, y, w, h );

  x = x + 1; y = y + 1;
  w = w - 2; h = h - 2;

  surface.SetDrawColor( clr( colors.background ) );
  surface.DrawRect( x, y, w, h );
end
 
function core.hud.paintText( x, y, text, font, colors )
  surface.SetFont( font );

  surface.SetTextPos( x + 1, y + 1 );
  surface.SetTextColor( clr( colors.shadow ) );
  surface.DrawText( text );

  surface.SetTextPos( x, y );
  surface.SetTextColor( clr( colors.text ) );
  surface.DrawText( text );
end

function core.hud.textSize( text, font )
  surface.SetFont( font );
  return surface.GetTextSize( text );
end


local ply = LocalPlayer();

hook.Add("PlayerIsReady", "InitPanels", function()
  hook.Add("PostDrawOpaqueRenderables", "drawadminname", function()
    if not IsValid(LocalPlayer()) then
      return
    end

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
      local tag = ply:getGroupTitle()
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
end)
