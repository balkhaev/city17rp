AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_player.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("client/libs/hud.lua")
AddCSLuaFile("client/libs/panel.lua")
AddCSLuaFile("client/cl_hud.lua")
AddCSLuaFile("client/cl_panel.lua")
AddCSLuaFile("client/cl_network.lua")

-- gmod_admin_cleanup

resource.AddWorkshop("349050451") -- Customizable Weaponry 2.0
resource.AddWorkshop("358608166") -- Extra Customizable Weaponry 2.0
resource.AddWorkshop("975698959") -- Stunners Pack
resource.AddWorkshop("746876505") -- Handcuffs
resource.AddWorkshop("675824914") -- Half-Life 2 Melee Pack
-- resource.AddWorkshop("314312925") -- [C3] Hand Cuff SWEP
resource.AddWorkshop("104491619") -- Metropolice Pack
resource.AddWorkshop("245482078") -- Empty Hands Swep
resource.AddWorkshop("834188196") -- Over-the-Shoulder Thirdperson
resource.AddWorkshop("682125090") -- Portable Force Field
--resource.AddWorkshop("669642096") -- Drones Rewrite

core = {}

include("shared.lua")
include("sh_player.lua")
include("config/general.lua")
include("config/goods.lua")
include("libs/core.lua")
include("libs/utils.lua")
include("libs/good.lua")
include("libs/zombie.lua")
include("libs/role/team.lua")
include("libs/role/group.lua")
include("libs/role/role.lua")
include("server/sv_npc.lua")
include("server/sv_player.lua")
include("server/sv_network.lua")
include("server/sv_entities.lua")
include("server/sv_commands.lua")
include("server/sv_combinedoors.lua")

core.init(core.config)

hook.Add( "PlayerInitialSpawn", "CityInitialSpawn", function(ply)
  if not core.role.existsPlayerRole(ply) then
    if ply:GetPData("role") then
      ply:setRole(ply:GetPData("role"))
    else
      ply:setRole(core.config.defaults.role)
    end
  end

  local cash = ply:GetPData("money")

  if cash == nil then
    ply:SetPData("money", core.config.defaults.money)
    ply:SetMoney( core.config.defaults.money )
  else
    ply:SetMoney( cash )
  end
end)

function GM:PlayerLoadout(ply)
  core.role.giveRoleItems(ply, ply:getRoleName())
end

hook.Add("PlayerSpawn", "SpawnPlayer", function(ply)
  local group = ply:getGroup()

  if group.spawn and group.spawn ~= "" then
    ply:SetPos(core.utils.getRandomVector( group.spawn ))
  end
end)

hook.Add( "Think", "ZombieSpawner", function()
  if core.zombie.needSpawn() then
    core.zombie.timer = CurTime() + core.zombie.getTimout()
    local zombieSpawns

    if core.zombie.isEvent then
      zombieSpawns = core.zombie.spawnPos
    else
      zombieSpawns = core.zombie.spawnPos
    end

    core.zombie.spawnZombie(core.utils.getRandomVector(zombieSpawns))

    if core.zombie.isEvent then
      if core.zombie.isMinLimit() then
        core.zombie.endEvent()
      end
    else
      if core.zombie.isLimit() then
        core.zombie.startEvent()
      end
    end
  end
end)

hook.Add("PlayerCanHearPlayersVoice" , "VoiceRadius" , function( p1 , p2 )
  return (p1:GetPos():Distance(p2:GetPos()) <= 2000)
end)

hook.Add( "PlayerSay", "Chat", function (pl, text, teamonly )
  if text == "/roll" then
    PrintMessage( HUD_PRINTTALK, ply:Nick().." выкинул "..math.random(1,100)..".")
    return ""
  elseif string.sub(text, 1, 3) == "/me" then
    PrintMessage( HUD_PRINTTALK, ply:Nick().." "..string.sub(text, 3))
    return ""
  end
end)


local function RespawnPlayer(ply)
  ply:UnLock()
  ply:ChatPrint("Вы можете возродиться")
end

hook.Add("PlayerDeath", "ForcePlayerRespawn", function (ply)
  if core.config.defaults.spawnTime ~= 0 then
    ply:Lock()
    ply:ChatPrint("Вы должны подождать " .. core.config.defaults.spawnTime .. " секунд перед возрождением")
    timer.Simple(core.config.defaults.spawnTime, RespawnPlayer, ply)
  end
end)

function GM:PostGamemodeLoaded()
  timer.Create("hlrp_payday", 300, 0, function()
    for k,v in pairs(player.GetAll()) do
      local role = core.role.getPlayerRole( v )

      v:AddMoney(role.salary);

      v:ChatPrint("You have earned $" .. string.Comma(role.salary) .. ". It has been sent to your bank.");
    end
  end);
end