core.panel = {}
core.panel.isOpen = false
core.panel.current = {}

function core.panel.createPanel(ply)
  core.panel.isOpen = true

  core.panel.current = vgui.Create( "DFrame" )
  --core.panel.current:SetPos( 50,50 )
  core.panel.current:SetSize( 1100, 900 )
  core.panel.current:SetTitle("City 17 Panel")
  core.panel.current:SetSizable( true )
  core.panel.current:SetVisible( true )
  core.panel.current:SetDraggable( true )
  core.panel.current:ShowCloseButton( true )
  core.panel.current:MakePopup()
  core.panel.current:Center()

  local PropertySheet = vgui.Create( "DColumnSheet", core.panel.current )
  PropertySheet:SetPos( 5, 30 )
  PropertySheet:SetSize( core.panel.current:GetWide()-10, core.panel.current:GetTall()-35 )

  core.panel.createSettingsSheet(PropertySheet, ply)

  net.Start( "getPlayerRoles" )
  net.SendToServer()

  net.Receive("receivePlayerRoles", function()
    local accesses = net.ReadTable()

    if ply:IsAdmin() or table.HasValue(accesses,"managment") then
      core.panel.createManagmentSheet(PropertySheet, ply)
    end
    if ply:IsAdmin() or table.HasValue(accesses,"trade") then
      core.panel.createTradeSheet(PropertySheet, ply)
    end
    if ply:IsAdmin() or table.HasValue(accesses,"camouflage") then
      core.panel.createCamouflageSheet(PropertySheet, ply)
    end
    if ply:IsAdmin() or table.HasValue(accesses,"poll") then
      core.panel.createPollSheet(PropertySheet, ply)
    end
    if ply:IsAdmin() then
      core.panel.createAdminSheet(PropertySheet, ply)
    end

    core.panel.createHelpSheet(PropertySheet, ply)
    core.panel.createAboutSheet(PropertySheet, ply)
  end)
end

function core.panel.createSettingsSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DIconLayout", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem:SetSpaceY( 5 )
  SheetItem:SetSpaceX( 5 )

  local ListItem = SheetItem:Add( "DPanel" )
  ListItem:SetSize( 110, 80 )

  local lab = Label("Сменить ник", ListItem)
  lab:SetPos(10, 3)
  lab:SetColor( Color( 0, 0, 0 ) )

  local textInput = vgui.Create("DTextEntry", ListItem)
  textInput:SetSize( 90, 20 )
  textInput:SetPos( 10, 25 )
  textInput:SetText(ply:Nick())

  local button = vgui.Create( "DButton", ListItem )
  button:SetSize( 90, 20 )
  button:SetPos( 10, 50 )
  button:SetText( "Сменить" )
  button.DoClick = function( button )
    ply:setNick(textInput:GetValue())
  end

  local ListItem2 = SheetItem:Add( "DPanel" )
  ListItem2:SetSize( 110, 80 )

  local lab2 = Label("Передать деньги", ListItem2)
  lab2:SetSize(90,20)
  lab2:SetPos(10, 3)
  lab2:SetColor( Color( 0, 0, 0 ) )

  local textInput2 = vgui.Create("DTextEntry", ListItem2)
  textInput2:SetSize( 90, 20 )
  textInput2:SetPos( 10, 25 )
  textInput2:SetText(0)

  local button2 = vgui.Create( "DButton", ListItem2 )
  button2:SetSize( 90, 20 )
  button2:SetPos( 10, 50 )
  button2:SetText( "Передать" )
  button2.DoClick = function( button )
    net.Start( "takeMoney" )
    net.WriteInt(textInput2:GetValue(),32)
    net.SendToServer()
  end

  Sheet:AddSheet( "Настройки", SheetItem, "icon16/cog.png", false, false, "Персональные настройки игрока" )
end

function core.panel.createManagmentSheet(Sheet, ply)
  local locPly = LocalPlayer()

  local SheetItem = vgui.Create( "DPanel", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem.Paint = function()
    surface.SetDrawColor( 50, 50, 50, 255 )
    surface.DrawRect( 0, 0, SheetItem:GetWide(), SheetItem:GetTall() )
  end

  local AppList = vgui.Create( "DListView", SheetItem )
  AppList:SetSize( SheetItem:GetWide()/2 - 100, SheetItem:GetTall() - 40 )
  AppList:SetMultiSelect( false )
  AppList:AddColumn( "Nick" )
  AppList:AddColumn( "Group" )
  AppList:AddColumn( "Role" )
  AppList:AddColumn( "SteamID" )

  local AppList2 = vgui.Create( "DListView", SheetItem )
  AppList2:SetSize( SheetItem:GetWide()/2-20, Sheet:GetTall() - 40 )
  AppList2:SetPos( SheetItem:GetWide()/2 - 100, 0 )
  AppList2:SetMultiSelect( false )
  AppList2:AddColumn( "Role" )
  AppList2:AddColumn( "Group" )
  AppList2:AddColumn( "Name" )

  net.Start( "getPlayerRoles" )
  net.SendToServer()

  net.Receive("receivePlayerRoles", function()
    AppList:Clear()
    AppList2:Clear()

    local roles = net.ReadTable()

    if ply:hasAccess("admin") then
      for _,v in ipairs(player.GetAll()) do
        AppList:AddLine(v:Name(), v:getGroupTitle(), v:getRoleTitle(), v:SteamID())
      end
    else
      for _,v in ipairs(player.GetAll()) do
        if v:SteamID() ~= locPly:SteamID() and (v:isGroup("citizens") or v:getGroupName() == ply:getGroupName()) then
          AppList:AddLine(v:Name(), v:getGroupTitle(), v:getRoleTitle(), v:SteamID())
        end
      end
    end

    for _,role in pairs(roles) do
      AppList2:AddLine(role.title, role.groupTitle, role.name)
    end

    AppList2:SortByColumn(2)
    AppList2:SelectFirstItem()

    AppList:SortByColumn(3)
    AppList:SelectFirstItem()
  end)

  local button1 = vgui.Create( "DButton", SheetItem )
  button1:SetPos( SheetItem:GetWide() - 195, SheetItem:GetTall()-35 )
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

  local AppList2 = vgui.Create( "DListView", SheetItem )
  AppList2:SetSize( SheetItem:GetWide() - 120, SheetItem:GetTall() )
  AppList2:SetPos( 0, 0 )
  AppList2:SetMultiSelect( false )
  AppList2:AddColumn( "Роль" )
  AppList2:AddColumn( "Группа" )
  AppList2:AddColumn( "Тех" )

  net.Start( "getCamouflages" )
  net.SendToServer()

  net.Receive("receiveCamouflages", function()
    AppList2:Clear()
    local camouflages = net.ReadTable()

    for _,camoRole in pairs(camouflages) do
      AppList2:AddLine(camoRole.title, camoRole.groupTitle, camoRole.name)
    end

    AppList2:SelectFirstItem()
  end)

  function AppList2:DoDoubleClick(num, line)
    net.Start("setCamouflage")
    net.WriteString(line:GetColumnText(3))
    net.SendToServer()
  end

  Sheet:AddSheet( "Камуфляж", SheetItem, "icon16/user_suit.png", false, false, "Выбор камуфляжа" )
end

function core.panel.createTradeSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DPropertySheet", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )

  net.Start("getTraderGoods")
  net.SendToServer()

  net.Receive("receiveTraderGoods", function()
    local goodWithTypes = net.ReadTable()

    for goodType, goods in pairs(goodWithTypes) do
      local grid = vgui.Create( "DGrid", SheetItem )
      grid:SetColWide( 76 )
      grid:SetRowHeight( 76 )

      for _, good in pairs(goods) do
        local SpawnI = vgui.Create( "SpawnIcon", grid ) -- SpawnIcon
        SpawnI:SetModel( good.model )
        SpawnI:SetText( good.title )

        SpawnI.DoClick = function(btn)
          net.Start("traderBuy")
          net.WriteString(goodType)
          net.WriteString(good.entity)
          net.SendToServer()
        end

        grid:AddItem( SpawnI )
      end

      SheetItem:AddSheet( goodType, grid )
    end
  end)

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

function core.panel.createHelpSheet(Sheet, ply)
  local SheetItem = vgui.Create( "HTML", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem:OpenURL("http://telegra.ph/Pomoshch-HL2RP-10-12")

  Sheet:AddSheet( "Помощь", SheetItem, "icon16/help.png", false, false )
end

function core.panel.createAboutSheet(Sheet, ply)
  local SheetItem = vgui.Create( "HTML", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )
  SheetItem:OpenURL("http://telegra.ph/City-17-RP-10-12-2")

  Sheet:AddSheet( "О режиме", SheetItem, "icon16/information.png", false, false )
end

function core.panel.createAdminSheet(Sheet, ply)
  local SheetItem = vgui.Create( "DPropertySheet", Sheet )
  SheetItem:SetPos( 0, 0 )
  SheetItem:SetSize( Sheet:GetWide(), Sheet:GetTall() )

  local panel = vgui.Create( "DPanel", SheetItem )

  local AppList = vgui.Create( "DListView", panel )
  AppList:SetSize( SheetItem:GetWide()/2 - 200, Sheet:GetTall() )
  AppList:SetMultiSelect( false )
  AppList:AddColumn( "Nick" )
  AppList:AddColumn( "Group" )
  AppList:AddColumn( "Role" )
  AppList:AddColumn( "SteamID" )
  for _,v in ipairs(player.GetAll()) do
    AppList:AddLine(v:Name(), v:getGroupTitle(), v:getRoleTitle(), v:SteamID())
  end
  AppList:SelectFirstItem()

  local textInput = vgui.Create("DTextEntry", panel)
  textInput:SetPos( SheetItem:GetWide() - 200, Sheet:GetTall() - 230 )
  textInput:SetSize( 90, 20 )
  textInput:SetText(0)

  local button1 = vgui.Create( "DButton", panel )
  button1:SetPos( SheetItem:GetWide() - 200, Sheet:GetTall() - 200 )
  button1:SetSize( 70, 30 )
  button1:SetText( "Set Money" )
  button1.DoClick = function( button )
    local AppLine = AppList:GetSelected()[1]

    net.Start( "giveMoney" )
    net.WriteString(AppLine:GetColumnText(4))
    net.WriteInt(textInput:GetValue(), 32)
    net.SendToServer()
  end

  SheetItem:AddSheet( "Игроки", panel )

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
