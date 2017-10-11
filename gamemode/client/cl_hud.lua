local vars = {
  font = "TargetID",
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

  local width = 230;        -- calculate width
  local height = 80;

  local x = 35;            -- get x position of element
  local y = ScrH( ) - height - 120;      -- get y position of element

  local cx = x + vars.padding;          -- get x and y of contents
  local cy = y + vars.padding;

  core.hud.paintPanel( x, y, width, height, colors.background );

  local text = "Money: "..client:GetMoney() .. "$";
  core.hud.paintText( cx, cy, text, vars.font, colors.text );
end);


hook.Add("PostDrawOpaqueRenderables", "drawadminname", function()
  for k, ply in pairs( player.GetAll() ) do
    if ply:getRole() == nil then return end
    if not ply:Alive() then return end

    local offset = Vector(0, 0, 80)
    local offset2 = Vector(0, 0, 75)
    local ang = LocalPlayer():EyeAngles()
    local pos = ply:GetPos() + offset + ang:Up()
    local pos2 = ply:GetPos() + offset2 + ang:Up()
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 90)
    local tag = ply:getGroupTitle()
    if tag and (team.GetName(LocalPlayer():Team()) == team.GetName(ply:Team())) then
      cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.25)
      draw.SimpleText(ply:Nick(), "Trebuchet24", 1, 1, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, 1, 1, HSVToColor( ply:Health(), 1, 1) )
      cam.End3D2D()
      cam.Start3D2D(pos2, Angle(0, ang.y, 90), 0.25)
      draw.SimpleText(tag, "Trebuchet24", 2, 2, HSVToColor(math.abs(math.sin(CurTime() * 0.1) * 335), 1, 1), TEXT_ALIGN_CENTER, 1, 1, Color(0, 0, 0))
      cam.End3D2D()
    end
  end
end)
