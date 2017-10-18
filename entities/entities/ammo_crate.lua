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

  -- We do NOT want to execute anything below in this FUNCTION on CLIENT
  if ( CLIENT ) then return end

  -- Use the helibomb model just for the shadow (because it's about the same size)
  self:SetModel( "models/Items/BoxMRounds.mdl" )

end

function ENT:Use( activator, caller )
  if ( activator:IsPlayer() ) then

    local plyWeapon = activator:GetActiveWeapon():GetClass()
    print(plyWeapon)

  end
end
