core.panel = {}

function core.panel.createPanel(ply)
  local DermaPanel = vgui.Create( "DFrame" )
  DermaPanel:SetPos( 50,50 )
  DermaPanel:SetSize( 512, 512 )
  DermaPanel:SetTitle("City Panel")
  DermaPanel:SetVisible( true )
  DermaPanel:SetDraggable( true )
  DermaPanel:ShowCloseButton( true )
  DermaPanel:MakePopup()

  local PropertySheet = vgui.Create( "DPropertySheet" )
  PropertySheet:SetParent( DermaPanel )
  PropertySheet:SetPos( 5, 30 )
  PropertySheet:SetSize( 500, 470 )

  local SheetItemOne = vgui.Create( "DPanel", PropertySheet )
  SheetItemOne:SetPos( 0, 0 )
  SheetItemOne:SetSize( PropertySheet:GetWide(), PropertySheet:GetTall() )
  SheetItemOne.Paint = function()
    surface.SetDrawColor( 50, 50, 50, 255 )
    surface.DrawRect( 0, 0, SheetItemOne:GetWide(), SheetItemOne:GetTall() )
  end

  local DComboBoxOne = vgui.Create( "DComboBox", SheetItemOne )
  DComboBoxOne:SetPos( 10, 10 )
  DComboBoxOne:SetSize( 200, 425 )
  DComboBoxOne:SetMultiple( false )
  for _,v in ipairs(player.GetAll()) do
    DComboBoxOne:AddItem(v:Name())
  end

  local myText = vgui.Create("DTextEntry", SheetItemOne)
  myText:SetText(ply:Nick())

  local button = vgui.Create( "DButton", SheetItemOne )
  button:SetSize( 100, 30 )
  button:SetPos( 50, 30 )
  button:SetText( "Set Nick" )
  button.DoClick = function( button )
    myText:GetValue()
  end

  local SheetItemTwo = vgui.Create( "DPanel", PropertySheet )
  SheetItemTwo:SetPos( 0, 0 )
  SheetItemTwo:SetSize( PropertySheet:GetWide(), PropertySheet:GetTall() )
  SheetItemTwo.Paint = function()
    surface.SetDrawColor( 50, 50, 50, 255 )
    surface.DrawRect( 0, 0, SheetItemTwo:GetWide(), SheetItemTwo:GetTall() )
  end

  PropertySheet:AddSheet( "Настройки", SheetItemOne, "gui/silkicons/user", false, false, "Punishment Commands" )
  PropertySheet:AddSheet( "Хуемае", SheetItemTwo, "gui/silkicons/group", false, false, "Fun Commands" )
end
