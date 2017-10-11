core.panel = {}
core.panel.isOpen = false
core.panel.current = {}

function core.panel.createPanel(ply)
  core.panel.isOpen = true

  core.panel.current = vgui.Create( "DFrame" )
  --core.panel.current:SetPos( 50,50 )
  core.panel.current:Center()
  core.panel.current:SetSize( 700, 700 )
  core.panel.current:SetTitle("City 17 Panel")
  core.panel.current:SetVisible( true )
  core.panel.current:SetDraggable( true )
  core.panel.current:ShowCloseButton( true )
  core.panel.current:MakePopup()

  local PropertySheet = vgui.Create( "DColumnSheet", core.panel.current )
  PropertySheet:SetPos( 5, 30 )
  PropertySheet:SetSize( core.panel.current:GetWide()-10, core.panel.current:GetTall()-35 )

  core.panel.createSettingsSheet(PropertySheet, ply)

  if ply:hasAccess("managment") then
    core.panel.createManagmentSheet(PropertySheet, ply)
  end
  if ply:hasAccess("trade") then
    core.panel.createTradeSheet(PropertySheet, ply)
  end
  if ply:hasAccess("camouflage") then
    core.panel.createCamouflageSheet(PropertySheet, ply)
  end
  if ply:hasAccess("drones") then
    core.panel.createDroneSheet(PropertySheet, ply)
  end
  if ply:hasAccess("poll") then
    core.panel.createPollSheet(PropertySheet, ply)
  end
  if ply:IsUserGroup("superadmin") then
    core.panel.createAdminSheet(PropertySheet, ply)
  end

  core.panel.createHelpSheet(PropertySheet, ply)
  core.panel.createAboutSheet(PropertySheet, ply)
end

--[[
function core.panel.createSettingsSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DPanel", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem.Paint = function()
    surface.SetDrawColor( 50, 50, 50, 255 )
    surface.DrawRect( 0, 0, SheetItem:GetWide(), SheetItem:GetTall() )
  end

  Label("Поменять ник", SheetItem)

  local textInput = vgui.Create("DTextEntry", SheetItem)
  textInput:SetPos( 10, 10 )
  textInput:SetSize( 100, 30 )
  textInput:SetText(ply:Nick())

  local button = vgui.Create( "DButton", SheetItem )
  button:SetPos( 110, 10 )
  button:SetSize( 70, 30 )
  button:SetText( "Поменять" )
  button.DoClick = function( button )
    ply:setNick(textInput:GetValue())
  end

  Label("Передать деньги", SheetItem)

  local textInput2 = vgui.Create("DTextEntry", SheetItem)
  textInput2:SetPos( 10, 40 )
  textInput2:SetSize( 100, 30 )
  textInput2:SetText(0)

  local button2 = vgui.Create( "DButton", SheetItem )
  button2:SetPos( 110, 40 )
  button2:SetSize( 70, 30 )
  button2:SetText( "Передать" )
  button2.DoClick = function( button )
    ply:TakeMoney(textInput2:GetValue())
  end

  Sheet:AddSheet( "Настройки", SheetItem, "icon16/cog.png", false, false, "Персональные настройки игрока" )
end
--]]

function core.panel.createSettingsSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DTileLayout", Sheet )
  SheetItem:SetBaseSize( 32 )
  SheetItem:Dock( FILL )
  SheetItem:SetDrawBackground( true )
  SheetItem:SetBackgroundColor( Color( 50, 50, 50 ) )

  Label("Поменять ник", SheetItem)

  local textInput = vgui.Create("DTextEntry", SheetItem)
  --textInput:SetSize( 100, 30 )
  textInput:SetText(ply:Nick())

  local button = vgui.Create( "DButton", SheetItem )
  --button:SetSize( 70, 30 )
  button:SetText( "Поменять" )
  button.DoClick = function( button )
    ply:setNick(textInput:GetValue())
  end

  Label("Передать деньги", SheetItem)

  local textInput2 = vgui.Create("DTextEntry", SheetItem)
  --textInput2:SetSize( 100, 30 )
  textInput2:SetText(0)

  local button2 = vgui.Create( "DButton", SheetItem )
  --button2:SetSize( 70, 30 )
  button2:SetText( "Передать" )
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

  local AppList = vgui.Create( "DListView", SheetItem )
  AppList:SetSize( SheetItem:GetWide()/2 - 100, Sheet:GetTall() )
  AppList:SetMultiSelect( false )
  AppList:AddColumn( "Nick" )
  AppList:AddColumn( "Group" )
  AppList:AddColumn( "Role" )
  AppList:AddColumn( "SteamID" )
  if ply:hasAccess("all") then
    for _,v in ipairs(player.GetAll()) do
      AppList:AddLine(v:Name(), v:getGroupTitle(), v:getRoleTitle(), v:SteamID())
    end
  else
    for _,v in ipairs(player.GetAll()) do
      if v:isGroup("citizens") or v:getGroupName() == ply:getGroupName() then
        AppList:AddLine(v:Name(), v:getGroupTitle(), v:getRoleTitle(), v:SteamID())
      end
    end
  end
  AppList:SelectFirstItem()


  local AppList2 = vgui.Create( "DListView", SheetItem )
  AppList2:SetSize( SheetItem:GetWide()/2 - 100, Sheet:GetTall() )
  AppList2:SetPos( SheetItem:GetWide()/2 - 100, 0 )
  AppList2:SetMultiSelect( false )
  AppList2:AddColumn( "Role" )
  AppList2:AddColumn( "Group" )
  AppList2:AddColumn( "Name" )

  net.Start( "getPlayerRoles" )
  net.SendToServer()

  net.Receive("receivePlayerRoles", function()
    AppList2:Clear()
    local roles = net.ReadTable()

    for _,role in pairs(roles) do
      AppList2:AddLine(role.title, core.group.getGroupTitle(role.group), role.name)
    end

    AppList2:SelectFirstItem()
  end)

  local button1 = vgui.Create( "DButton", SheetItem )
  button1:SetPos( SheetItem:GetWide() - 195, Sheet:GetTall() - 40 )
  button1:SetSize( 70, 30 )
  button1:SetText( "Set Role" )
  button1.DoClick = function( button )
    local AppLine1 = AppList:GetSelected()[1]
    local AppLine2 = AppList2:GetSelected()[1]

    net.Start("setPlayerRole")
    net.WriteString(AppLine1:GetColumnText(4))
    net.WriteString(AppLine2:GetColumnText(3))
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

  if ply:hasAccess("all") then
    for i,camoRole in pairs(core.role.store) do
      local DButton = vgui.Create( "DButton", SheetItem )
      DButton:SetPos( 200 * (i-1) + 10, 10 )
      DButton:SetSize( 200, 425 )
      DButton:AddChoice(camoRole.title)
      DButton.DoClick = function()
        net.Start("setCamouflage")
        net.WriteString(camoRole.name)
        net.SendToServer()
      end
    end
  else
    local role = ply:getRole()

    for i,v in pairs(role.camouflage) do
      local camoRole = core.role.getRole(v)
      local DButton = vgui.Create( "DButton", SheetItem )
      DButton:SetPos( 200 * (i-1) + 10, 10 )
      DButton:SetSize( 200, 425 )
      DButton:AddChoice(camoRole.title)
      DButton.DoClick = function()
        net.Start("setCamouflage")
        net.WriteString(camoRole.name)
        net.SendToServer()
      end
    end
  end

  Sheet:AddSheet( "Камуфляж", SheetItem, "icon16/user_suit.png", false, false, "Выбор камуфляжа" )
end

function core.panel.createTradeSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DPropertySheet", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )

  if (ply:hasAccess("weaponTrade")) then
    local grid1 = vgui.Create( "DGrid", SheetItem )
    grid1:SetColWide( 76 )
    grid1:SetRowHeight( 76 )

    for i,weapon in pairs(core.config.goods.weapons) do
      local weaponEnt = ents.CreateClientProp(weapon.entity)
      if not IsValid( weaponEnt ) then return end

      local SpawnI = vgui.Create( "SpawnIcon", grid1 ) -- SpawnIcon
      SpawnI:SetModel( weaponEnt:GetModel() )
      SpawnI:SetText( weapon.title )

      SpawnI.DoClick = function(btn)
        net.Start("traderBuy")
        net.WriteString("weapons")
        net.WriteString(weapon.entity)
        net.SendToServer()
      end

      grid1:AddItem( SpawnI )
    end

    SheetItem:AddSheet( "Оружие", grid1 )

    local grid2 = vgui.Create( "DGrid", SheetItem )
    grid2:SetColWide( 76 )
    grid2:SetRowHeight( 76 )

    for i,ammo in pairs(core.config.goods.ammo) do
      local ammoEnt = ents.CreateClientProp(ammo.entity)
      if not IsValid( ammoEnt ) then return end

      local SpawnI = vgui.Create( "SpawnIcon" , grid2 )
      SpawnI:SetModel( ammoEnt:GetModel() )
      SpawnI:SetText( ammo.title )

      SpawnI.DoClick = function(btn)
        net.Start("traderBuy")
        net.WriteString("ammo")
        net.WriteString(ammo.entity)
        net.SendToServer()
      end
      grid2:AddItem( SpawnI )
    end

    SheetItem:AddSheet( "Патроны", grid2 )

    local grid3 = vgui.Create( "DGrid", SheetItem )
    grid3:SetColWide( 76 )
    grid3:SetRowHeight( 76 )

    for i,equip in pairs(core.config.goods.equips) do
      local equipEnt = ents.CreateClientProp(equip.entity)
      if not IsValid( equipEnt ) then return end

      local SpawnI = vgui.Create( "SpawnIcon" , grid3 )
      SpawnI:SetModel( equipEnt:GetModel() )
      SpawnI:SetText( equip.title )

      SpawnI.DoClick = function(btn)
        net.Start("traderBuy")
        net.WriteString("equips")
        net.WriteString(equip.entity)
        net.SendToServer()
      end

      grid3:AddItem( SpawnI )
    end

    SheetItem:AddSheet( "Обвесы", grid3 )
  end

  Sheet:AddSheet( "Торговля", SheetItem, "icon16/money.png", false, false, "Покупка товаров для продажи" )
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

function core.panel.createDroneSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DPanel", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem.Paint = function()
    surface.SetDrawColor( 50, 50, 50, 255 )
    surface.DrawRect( 0, 0, SheetItem:GetWide(), SheetItem:GetTall() )
  end

  local grid = vgui.Create( "DGrid", SheetItem )
  grid:SetColWide( 76 )
  grid:SetRowHeight( 76 )

  local SpawnI = vgui.Create( "SpawnIcon" , grid ) -- SpawnIcon
  SpawnI:SetPos( 0, 0 )
  SpawnI:SetModel( "models/dronesrewrite/spydr/spydr.mdl" ) -- Model we want for this spawn icon

  SpawnI.DoClick = function(btn)
    net.Start("traderBuy")
    net.WriteString("drones")
    net.WriteString("dronesrewrite_spy")
    net.SendToServer()
  end

  grid:AddItem( SpawnI )

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

function core.panel.createAdminSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DPropertySheet", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )

  local AppList = vgui.Create( "DListView", SheetItem )
  AppList:SetSize( SheetItem:GetWide()/2 - 100, Sheet:GetTall() )
  AppList:SetMultiSelect( false )
  AppList:AddColumn( "Nick" )
  AppList:AddColumn( "Group" )
  AppList:AddColumn( "Role" )
  AppList:AddColumn( "SteamID" )
  for _,v in ipairs(player.GetAll()) do
    AppList:AddLine(v:Name(), v:getGroupTitle(), v:getRoleTitle(), v:SteamID())
  end
  AppList:SelectFirstItem()

  SheetItem:AddSheet( "Игроки", AppList )

  Sheet:AddSheet( "Админ", SheetItem, "icon16/award_star_bronze_1.png", false, false )
end

function core.panel.destroyPanel()
  core.panel.current:Remove()
  core.panel.isOpen = false
end

--[[
function fridge()
        local food = {}

        food[1] = "models/props_junk/garbage_milkcarton002a.mdl"
	food[2] = "models/props_junk/PopCan01a.mdl"
	food[3] = "models/props_junk/garbage_takeoutcarton001a.mdl"
	food[4] = "models/props_junk/watermelon01.mdl"
	food[5] = "models/props_junk/garbage_metalcan001a.mdl"
	food[6] = "models/props_lab/box01a.mdl"
	food[7] = "models/props_lab/box01b.mdl"

        local frame = vgui.Create("DFrame")
	local IconList = vgui.Create( "DPanelList", frame )

	frame:Center()
	frame:SetSize(220,200)
	frame:SetTitle("Fridge")
	frame:MakePopup()

 	IconList:EnableVerticalScrollbar( true )
 	IconList:EnableHorizontal( true )
 	IconList:SetPadding( 4 )
	IconList:SetPos(10,30)
	IconList:SetSize(200, 160)

	for k,v in pairs(food) do
	local icon = vgui.Create( "SpawnIcon", IconList )
	icon:SetModel( v )
 	IconList:AddItem( icon )
	icon.DoClick = function( icon ) surface.PlaySound( "ui/buttonclickrelease.wav" ) RunConsoleCommand("gm_spawn", v) end
	end
end
--]]
