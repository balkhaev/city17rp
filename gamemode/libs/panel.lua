core.panel = {}
core.panel.isOpen = false
core.panel.current = {}

function core.panel.createPanel(ply)
  core.panel.isOpen = true

  core.panel.current = vgui.Create( "DFrame" )
  core.panel.current:SetPos( 50,50 )
  core.panel.current:SetSize( 512, 512 )
  core.panel.current:SetTitle("City Panel")
  core.panel.current:SetVisible( true )
  core.panel.current:SetDraggable( true )
  core.panel.current:ShowCloseButton( true )
  core.panel.current:MakePopup()

  local PropertySheet = vgui.Create( "DColumnSheet" )
  PropertySheet:SetParent( core.panel.current )
  PropertySheet:SetPos( 5, 30 )
  PropertySheet:SetSize( 500, 470 )

  local role = ply:getRole()

  core.panel.createSettingsSheet(PropertySheet, ply)

  if (ply:hasAccess("managment")) then
    core.panel.createManagmentSheet(PropertySheet, ply)
  end
  if role.camouflage ~= nil then
    core.panel.createCamouflageSheet(PropertySheet, ply)
  end
  if (ply:hasAccess("drones")) then
    core.panel.createDroneSheet(PropertySheet, ply)
  end
  if (ply:hasAccess("poll")) then
    core.panel.createPollSheet(PropertySheet, ply)
  end

  core.panel.createHelpSheet(PropertySheet, ply)
  core.panel.createAboutSheet(PropertySheet, ply)
end

function core.panel.destroyPanel()
  core.panel.current:Remove()
  core.panel.isOpen = false
end

function core.panel.createSettingsSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DPanel", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem.Paint = function()
    surface.SetDrawColor( 50, 50, 50, 255 )
    surface.DrawRect( 0, 0, SheetItem:GetWide(), SheetItem:GetTall() )
  end

  local textInput = vgui.Create("DTextEntry", SheetItem)
  textInput:SetPos( 10, 10 )
  textInput:SetSize( 100, 30 )
  textInput:SetText(ply:Nick())

  local button = vgui.Create( "DButton", SheetItem )
  button:SetPos( 110, 10 )
  button:SetSize( 70, 30 )
  button:SetText( "Set Nick" )
  button.DoClick = function( button )
    ply:setNick(myText:GetValue())
  end

  local textInput2 = vgui.Create("DTextEntry", SheetItem)
  textInput2:SetPos( 10, 110 )
  textInput2:SetSize( 100, 30 )
  textInput2:SetText(0)

  local button2 = vgui.Create( "DButton", SheetItem )
  button2:SetPos( 110, 110 )
  button2:SetSize( 70, 30 )
  button2:SetText( "Take Money" )
  button2.DoClick = function( button )
    ply:TakeMoney(textInput2:GetValue())
  end

  Sheet:AddSheet( "Настройки", SheetItem, "icon16/cog.png", false, false, "Персональные настройки игрока" )
end

function core.panel.createManagmentSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DPanel", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem.Paint = function()
    surface.SetDrawColor( 50, 50, 50, 255 )
    surface.DrawRect( 0, 0, SheetItem:GetWide(), SheetItem:GetTall() )
  end

  local DComboBox1 = vgui.Create( "DComboBox", SheetItem )
  DComboBox1:SetPos( 10, 10 )
  DComboBox1:SetSize( 100, 30 )
  for _,v in ipairs(player.GetAll()) do
    DComboBox1:AddChoice(v:Name(), v:SteamID())
  end

  local DComboBox2 = vgui.Create( "DComboBox", SheetItem )
  DComboBox2:SetPos( 110, 10 )
  DComboBox2:SetSize( 100, 30 )

  if ply:hasAccess("all") then
    for _,role in pairs(core.role.store) do
      DComboBox2:AddChoice("["..role.group.."]"..role.title, role.name)
    end
  else
    for _,v in pairs(core.group.getPlayerGroupRoles(ply)) do
      local role = core.role.getRole(v)

      if not role.hasAccess("managment") then
        DComboBox2:AddChoice(role.title, v)
      end
    end
  end


  local button1 = vgui.Create( "DButton", SheetItem )
  button1:SetPos( 210, 10 )
  button1:SetSize( 70, 30 )
  button1:SetText( "Set Role" )
  button1.DoClick = function( button )
    net.Start("setPlayerRole")
    net.WriteString(DComboBox1:GetOptionData(DComboBox1:GetSelectedID()))
    net.WriteString(DComboBox2:GetOptionData(DComboBox2:GetSelectedID()))
    net.SendToServer()
  end

  Sheet:AddSheet( "Управление", SheetItem, "icon16/group_edit.png", false, false, "Управление группой ролей" )
end

function core.panel.createCamouflageSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DPanel", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem.Paint = function()
    surface.SetDrawColor( 50, 50, 50, 255 )
    surface.DrawRect( 0, 0, SheetItem:GetWide(), SheetItem:GetTall() )
  end

  local role = ply:getRole()

  local DComboBox1 = vgui.Create( "DComboBox", SheetItem )
  DComboBox1:SetPos( 10, 10 )
  DComboBox1:SetSize( 200, 425 )
  for _,v in pairs(role.camouflage) do
    DComboBox1:AddChoice(v)
  end

  local DComboBox2 = vgui.Create( "DComboBox", SheetItem )
  DComboBox2:SetPos( 50, 10 )
  DComboBox2:SetSize( 200, 425 )
  for _,v in ipairs(core.group.getPlayerGroupRoles(ply)) do
    DComboBox2:AddChoice(v)
  end
  DComboBox2.OnSelect = function( panel, index, value )
    core.role.setPlayerRole(DComboBox2:GetSelected())
  end

  local button2 = vgui.Create( "DButton", SheetItem )
  button2:SetPos( 50, 30 )
  button2:SetText( "Set Role" )
  button2.DoClick = function( button )
    core.role.setPlayerRole(DComboBox1:GetSelected(), DComboBox2:GetSelected())
  end

  Sheet:AddSheet( "Камуфляж", SheetItem, "icon16/user_suit.png", false, false, "Выбор камуфляжа" )
end

function core.panel.createDroneSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DPanel", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem.Paint = function()
    surface.SetDrawColor( 50, 50, 50, 255 )
    surface.DrawRect( 0, 0, SheetItem:GetWide(), SheetItem:GetTall() )
  end

  local SpawnI = vgui.Create( "SpawnIcon" , SheetItem ) -- SpawnIcon
  SpawnI:SetPos( 75, 75 )
  SpawnI:SetModel( "models/dronesrewrite/spydr/spydr.mdl" ) -- Model we want for this spawn icon

  Sheet:AddSheet( "Дроны", SheetItem, "icon16/joystick.png", false, false, "Создание дронов" )
end

function core.panel.createHelpSheet(Sheet, ply)
  local SheetItem = vgui.Create( "HTML", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem:OpenURL("https://gist.github.com/balkhaev/8ba71987ccbcf08beb2bd9c9548ee910")

  Sheet:AddSheet( "Помощь", SheetItem, "icon16/help.png", false, false )
end

function core.panel.createAboutSheet(Sheet, ply)
  local SheetItem = vgui.Create( "HTML", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem:OpenURL("https://github.com/balkhaev/city17rp/blob/master/README.md")

  Sheet:AddSheet( "О режиме", SheetItem, "icon16/information.png", false, false )
end

function core.panel.createPollSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DPanel", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem.Paint = function()
    surface.SetDrawColor( 50, 50, 50, 255 )
    surface.DrawRect( 0, 0, SheetItem:GetWide(), SheetItem:GetTall() )
  end

  local myText = vgui.Create("DTextEntry", SheetItem)
  myText:SetText(ply:Nick())

  local button = vgui.Create( "DButton", SheetItem )
  button:SetPos( 50, 30 )
  button:SetText( "Set Nick" )
  button.DoClick = function( button )
    ply:setNick(myText:GetValue())
  end

  Sheet:AddSheet( "Голосование", SheetItem, "icon16/thumb_up.png", false, false, "Проведение голосований" )
end
