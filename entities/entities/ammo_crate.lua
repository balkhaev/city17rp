AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName = "Ammo Box"
ENT.Author = "Narkeba"
ENT.Information = "Buyable Ammo Box"
ENT.Category = "Buyable Items"

ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
  if ( CLIENT ) then return end

  self:SetModel( "models/Items/BoxMRounds.mdl" )
  self:PhysicsInit( SOLID_VPHYSICS )
  self:SetMoveType( MOVETYPE_VPHYSICS )
  self:SetSolid( SOLID_VPHYSICS )
  self:SetUseType( SIMPLE_USE )

  local phys = self:GetPhysicsObject()
  if (phys:IsValid()) then
    phys:Wake()
  end

end

function ENT:Use( activator, caller )
  if ( activator:IsPlayer() ) then

    local plyWeapon = activator:GetActiveWeapon():GetClass()

    if string.find(plyWeapon, "cw_") then
      print(plyWeapon)
    end

  end
end
