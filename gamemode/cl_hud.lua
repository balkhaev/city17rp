local vars = {
  font = "TargetID",

  padding = 10,
  margin = 35,

  text_spacing = 2,
  bar_spacing = 5,

  bar_height = 16,

  width = 0.25
};

local colors = {
  background = {
    border = Color( 190, 255, 128, 255 ),
    background = Color( 120, 240, 0, 75 )
  },
  text = {
    shadow = Color( 0, 0, 0, 200 ),
    text = Color( 255, 255, 255, 255 )
  },
  health_bar = {
    border = Color( 255, 0, 0, 255 ),
    background = Color( 255, 0, 0, 75 ),
    shade = Color( 255, 104, 104, 255 ),
    fill = Color( 232, 0, 0, 255 )
  },
  suit_bar = {
    border = Color( 0, 0, 255, 255 ),
    background = Color( 0, 0, 255, 75 ),
    shade = Color( 136, 136, 255, 255 ),
    fill = Color( 0, 0, 219, 255 )
  }
};

local function HUDPaint()
  client = client or LocalPlayer();

  if not client:Alive() then
    return;
  end

  local _, th = core.hud.textSize("TEXT", vars.font);

  local i = 2;              -- shortcut to how many items( bars + text ) we have

  local width = vars.width * ScrW( );        -- calculate width
  local bar_width = width - ( vars.padding * i );      -- calculate bar width and element height
  local height = ( vars.padding * i ) + ( th * i ) + ( vars.text_spacing * i ) + ( vars.bar_height * i ) + vars.bar_spacing;

  local x = vars.margin;            -- get x position of element
  local y = ScrH( ) - vars.margin - height;      -- get y position of element

  local cx = x + vars.padding;          -- get x and y of contents
  local cy = y + vars.padding;

  core.hud.paintPanel( x, y, width, height, colors.background );  -- paint the background panel

  local by = th + vars.text_spacing;        -- calc text position

  local text = string.format( "Health: %iHP", client:Health( ) );  -- get health text
  core.hud.paintText( cx, cy, text, vars.font, colors.text );  -- paint health text and health bar
  core.hud.paintBar( cx, cy + by, bar_width, vars.bar_height, colors.health_bar, client:Health( ) / 100 );

  by = by + vars.bar_height + vars.bar_spacing;			-- increment text position

  local text = string.format( "Money: %iSP", client:GetMoney( ) );
  core.hud.paintText( cx, cy + by, text, vars.font, colors.text );
end

hook.Add( "HUDPaint", "PaintOurHud", HUDPaint );


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
