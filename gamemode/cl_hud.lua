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

  --[[
  by = by + vars.bar_height + vars.bar_spacing;			-- increment text position

  local text = string.format( "Suit: %iSP", client:Armor( ) );	-- get suit text
  core.hud.paintText( cx, cy + by, text, vars.font, colors.text );	-- paint suit text and suit bar
  core.hud.paintBar( cx, cy + by + th + vars.text_spacing, bar_width, vars.bar_height, colors.suit_bar, client:Armor( ) / 100 );
  --]]
end

hook.Add( "HUDPaint", "PaintOurHud", HUDPaint );
