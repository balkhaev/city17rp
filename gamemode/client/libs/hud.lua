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
 
function core.hud.paintText( x, y, text, font, colors, size )
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
