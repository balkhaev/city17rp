DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.DisplayName = "City 17 RP Base Player Class"
PLAYER.WalkSpeed = 200
PLAYER.RunSpeed = 400

PLAYER.TeammateNoCollide = false

--[[
PLAYER.WalkSpeed 			= 100
PLAYER.JumpPower            = 300
PLAYER.RunSpeed				= 160
]]--

function PLAYER:Loadout()
  -- Let gamemode decide
end

function PLAYER:SetModel()
  -- Let gamemode decide
end

player_manager.RegisterClass( "player_custom", PLAYER, "player_default" )