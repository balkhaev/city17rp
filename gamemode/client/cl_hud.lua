local vars = {
  font = "TargetID",
  text_spacing = 2,
  padding = 10
};

local colors = {
  background = {
    border = Color( 190, 255, 128, 0 ),
    background = Color( 0, 0, 0, 120 )
  },
  text = {
    shadow = Color( 0, 0, 0, 200 ),
    text = Color( 255, 221, 85 )
  }
};

hook.Add( "HUDPaint", "PaintOurHud", function()
  client = client or LocalPlayer();

  if not client:Alive() then return; end

  local _, th = core.hud.textSize("TEXT", vars.font);

  local width = 230;
  local height = 80;

  local x = 35;
  local y = ScrH( ) - height - 120;

  local cx = x + vars.padding;
  local cy = y + vars.padding;

  core.hud.paintPanel( x, y, width, height, colors.background );

  local by = th + vars.text_spacing;

  core.hud.paintText( cx, cy, "Денег: "..client:GetMoney() .. "$", vars.font, colors.text );
  core.hud.paintText( cx, cy + by, "Роль: "..client:getRoleTitle(), vars.font, colors.text );
end);


hook.Add("PostDrawOpaqueRenderables", "drawadminname", function()
  for k, ply in pairs( player.GetAll() ) do
    if (ply:GetPos():Distance(LocalPlayer():GetPos()) > 200) then return end

    if not ply:Alive() then return end

    local offset = Vector(0, 0, 80)
    local offset2 = Vector(0, 0, 75)
    local ang = LocalPlayer():EyeAngles()
    local pos = ply:GetPos() + offset + ang:Up()
    local pos2 = ply:GetPos() + offset2 + ang:Up()
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 90)

    cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.25)
    draw.SimpleText(ply:Nick(), "Trebuchet24", 1, 1, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, 1, 1, HSVToColor( ply:Health(), 1, 1) )
    cam.End3D2D()
    cam.Start3D2D(pos2, Angle(0, ang.y, 90), 0.25)
    draw.SimpleText(ply:getRoleTitle(), "Trebuchet24", 2, 2, HSVToColor(math.abs(math.sin(CurTime() * 0.1) * 335), 1, 1), TEXT_ALIGN_CENTER, 1, 1, Color(0, 0, 0))
    cam.End3D2D()
  end
end)
