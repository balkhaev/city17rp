core.panel = {}

function core.panel.createPanel()
  local DermaPanel = vgui.Create( "DFrame" )
  DermaPanel:SetPos(ScrW() / 2, ScrH() / 2)
  DermaPanel:SetSize( 200, 250 )
  DermaPanel:SetTitle( "Testing Derma Stuff" )
  DermaPanel:SetVisible( true )
  DermaPanel:SetDraggable( true )
  DermaPanel:ShowCloseButton( true )
  DermaPanel:MakePopup()

  local DermaButton = vgui.Create( "DButton" )
  DermaButton:SetParent( DermaPanel ) -- Set parent to our "DermaPanel"
  DermaButton:SetText( "Kill yourself" )
  DermaButton:SetPos( 25, 50 )
  DermaButton:SetSize( 150, 50 )
  DermaButton.DoClick = function ()
      RunConsoleCommand( "kill" ) -- What happens when you press the button
  end
end
