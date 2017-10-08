AddCSLuaFile("shared.lua")
AddCSLuaFile("config/general.lua")
AddCSLuaFile("libs/core.lua")
AddCSLuaFile("libs/role/team.lua")
AddCSLuaFile("libs/role/group.lua")
AddCSLuaFile("libs/role/role.lua")
AddCSLuaFile("libs/player.lua")
AddCSLuaFile("libs/hud.lua")
AddCSLuaFile("libs/panel.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_panel.lua")

-- resource.AddWorkshop("299164995") -- Call Of Duty: Black Ops II Weapons Pack
resource.AddWorkshop("349050451") -- Customizable Weaponry 2.0
resource.AddWorkshop("358608166") -- Extra Customizable Weaponry 2.0
resource.AddWorkshop("975698959") -- Stunners Pack
resource.AddWorkshop("647098998") -- Stunner
resource.AddWorkshop("627908510") -- Easy Thirdperson
resource.AddWorkshop("746876505") -- Handcuffs
resource.AddWorkshop("675824914") -- Half-Life 2 Melee Pack
resource.AddWorkshop("314312925") -- [C3] Hand Cuff SWEP
resource.AddWorkshop("104491619") -- Metropolice Pack
-- resource.AddWorkshop("1077528956") -- Accurate HL2 Beta HUD - White
resource.AddWorkshop("245482078") -- Empty Hands Swep

core = {}

include("shared.lua")
include("config/general.lua")
include("libs/core.lua")
include("libs/utils.lua")
include("libs/role/team.lua")
include("libs/role/group.lua")
include("libs/role/role.lua")
include("libs/zombie.lua")
include("libs/player.lua")
include("sv_commands.lua")
include("sv_combinedoors.lua")

core.init(core.config)

util.AddNetworkString("setPlayerRole")

function GM:PlayerInitialSpawn(ply)
  ply.SID = ply:UserID()

  if not core.role.existsPlayerRole(ply) then
    if ply:GetPData("role") then
      core.role.setPlayerRole(ply, ply:GetPData("role"))
    else
      core.role.setPlayerRole(ply, core.config.defaults.role)
    end
  end

  local cash = ply:GetPData("money")

  if cash == nil then
    ply:SetPData("money", core.config.defaults.money)
    ply:SetMoney( core.config.defaults.money )
  else
    ply:SetMoney( cash )
  end
end

function GM:PlayerLoadout(ply)
  core.role.giveRoleItems(ply, ply:getRoleName())
end

function GM:PlayerSetModel( ply )
  local role = ply:getRole()
  ply:SetModel(role.model)
end

hook.Add("PlayerSpawn", "SpawnPlayer", function(ply)
  local group = ply:getGroup()

  if group.spawn and group.spawn ~= "" then
    local tab = string.Explode(",", group.spawn)
    ply:SetPos(Vector(tab[1],tab[2],tab[3]))
  end
end)

hook.Add( "Think", "ZombieSpawner", function()
  if core.zombie.needSpawn() then
    core.zombie.timer = CurTime() + 10

    core.zombie.spawnZombie()

    if (core.zombie.isLimit()) then
      core.zombie.startEvent()
    end
  end
end)
