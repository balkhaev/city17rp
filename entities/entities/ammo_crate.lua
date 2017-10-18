AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName = "Buyable Item"
ENT.Author = "Narkeba"
ENT.Information = "Base Buyable Item"
ENT.Category = "Buyable Items"

ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()

  -- We do NOT want to execute anything below in this FUNCTION on CLIENT
  if ( CLIENT ) then return end

  -- Use the helibomb model just for the shadow (because it's about the same size)
  self:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )

end

function ENT:Use( activator, caller )
  if ( activator:IsPlayer() ) then

    local plyWeapon = activator:GetActiveWeapon():GetClass()
    print(plyWeapon)

  end
end
