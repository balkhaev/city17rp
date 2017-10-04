core.panel = {}
core.panel.current = {}

function core.panel.createPanel(ply)
  core.panel.current = vgui.Create( "DFrame" )
  core.panel.current:SetPos( 50,50 )
  core.panel.current:SetSize( 512, 512 )
  core.panel.current:SetTitle("City Panel")
  core.panel.current:SetVisible( true )
  core.panel.current:SetDraggable( true )
  core.panel.current:ShowCloseButton( true )
  core.panel.current:MakePopup()

  local PropertySheet = vgui.Create( "DPropertySheet" )
  PropertySheet:SetParent( core.panel.current )
  PropertySheet:SetPos( 5, 30 )
  PropertySheet:SetSize( 500, 470 )

  local SheetItemOne = vgui.Create( "DPanel", PropertySheet )
  SheetItemOne:SetPos( 0, 0 )
  SheetItemOne:SetSize( PropertySheet:GetWide(), PropertySheet:GetTall() )
  SheetItemOne.Paint = function()
    surface.SetDrawColor( 50, 50, 50, 255 )
    surface.DrawRect( 0, 0, SheetItemOne:GetWide(), SheetItemOne:GetTall() )
  end

  local myText = vgui.Create("DTextEntry", SheetItemOne)
  myText:SetText(ply:Nick())

  local button = vgui.Create( "DButton", SheetItemOne )
  button:SetPos( 50, 30 )
  button:SetText( "Set Nick" )
  button.DoClick = function( button )
    ply:setNick(myText:GetValue())
  end

  if (ply:hasAccess("managment")) then
    local SheetItemTwo = vgui.Create( "DPanel", PropertySheet )
    SheetItemTwo:SetPos( 0, 0 )
    SheetItemTwo:SetSize( PropertySheet:GetWide(), PropertySheet:GetTall() )
    SheetItemTwo.Paint = function()
      surface.SetDrawColor( 50, 50, 50, 255 )
      surface.DrawRect( 0, 0, SheetItemTwo:GetWide(), SheetItemTwo:GetTall() )
    end

    local DComboBoxOne = vgui.Create( "DComboBox", SheetItemTwo )
    DComboBoxOne:SetPos( 10, 10 )
    DComboBoxOne:SetSize( 200, 425 )
    DComboBoxOne:SetMultiple( false )
    for _,v in ipairs(player.GetAll()) do
      DComboBoxOne:AddItem(v:Name())
    end
  end

  PropertySheet:AddSheet( "Настройки", SheetItemOne, "gui/silkicons/user", false, false, "Punishment Commands" )
  PropertySheet:AddSheet( "Хуемае", SheetItemTwo, "gui/silkicons/group", false, false, "Fun Commands" )
end

function core.panel.destroyPanel()
  core.panel.current:Remove()
end
