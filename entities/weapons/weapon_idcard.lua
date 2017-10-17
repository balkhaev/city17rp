AddCSLuaFile()

SWEP.HoldType               = "normal"

if CLIENT then
  SWEP.PrintName           = "ID Card"
  SWEP.Slot                = 1

  SWEP.ViewModelFlip       = false
  SWEP.ViewModelFOV        = 10

  SWEP.EquipMenuData = {
    type="Weapon",
    model="models/props_lab/reciever01b.mdl",
    desc="Broadcasts a location to everyone.\n\nUse to warn or group innocents."
  };

  SWEP.Icon                = "vgui/ttt/icon_beacon"
end

SWEP.Base                   = "weapon_c17base"

SWEP.ViewModel              = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel             = "models/props_lab/reciever01b.mdl"

SWEP.Primary.ClipSize       = 3
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "slam"
SWEP.Primary.Delay          = 1.0

SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = true
SWEP.Secondary.Ammo         = "none"
SWEP.Secondary.Delay        = 1.0

SWEP.LimitedStock           = true -- only buyable once

SWEP.Spawnable              = true
SWEP.AllowDrop              = false
SWEP.NoSights               = true

function SWEP:OnDrop()
  self:Remove()
end

function SWEP:PrimaryAttack()
  self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

  if self:CanPrimaryAttack() then
    self:ShowCard()
  end
end
function SWEP:SecondaryAttack()
  self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

  if self:CanPrimaryAttack() then
    self:BeaconStick()
  end
end

function SWEP:ShowCard()
  if SERVER then
    local ply = self.Owner
    if not IsValid(ply) then return end

    chat.AddText(Color( 100, 100, 255 ), ply, " показал свою ID карту. \n"..ply:getRoleTitle())
  end
end

function SWEP:BeaconStick()
  if SERVER then
    local ply = self.Owner
    if not IsValid(ply) then return end
  end
end

-- Ammo hackery after getting bought
function SWEP:WasBought(buyer)
  self:SetClip1(self:Clip1() + 2)
end

function SWEP:Reload()
  return false
end

function SWEP:OnRemove()
  if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:IsTerror() then
    RunConsoleCommand("lastinv")
  end
end

if CLIENT then
  function SWEP:Initialize()
    self:AddHUDHelp("Click to place the beacon")

    return self.BaseClass.Initialize(self)
  end
end

function SWEP:Deploy()
  self.Owner:DrawViewModel(false)
  return true
end

function SWEP:DrawWorldModel()
  if not IsValid(self.Owner) then
    self:DrawModel()
  end
end

function SWEP:DrawWorldModelTranslucent()
end
