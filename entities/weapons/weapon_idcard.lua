SWEP.PrintName			= "ID карта" -- This will be shown in the spawn menu, and in the weapon selection menu
SWEP.Author			= "Narkeba" -- These two options will be shown when you have the weapon highlighted in the weapon selection menu
SWEP.Instructions		= "ЛКМ что бы показать свою ID карту"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot			= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

SWEP.ViewModel			= ""
SWEP.WorldModel			= ""

function SWEP:PrimaryAttack()
  self.Weapon:SetNextPrimaryFire( CurTime() + 2 )

  if CLIENT then
    chat.AddText(Color( 100, 100, 255 ), ply, " показал свою ID карту. \n"..ply:getRoleTitle())
  end
end
