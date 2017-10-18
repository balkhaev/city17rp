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

ENT.MinCost = 1
ENT.MaxCost = 10000

function ENT:SetupDataTables()

  self:NetworkVar( "Float", 0, "Cost" )

end

function ENT:SpawnFunction( ply, tr, ClassName )

  if not tr.Hit then return end

  local size = math.random( 16, 48 )

  local ent = ents.Create( ClassName )
  ent:SetPos( tr.HitPos + tr.HitNormal * size )
  ent:Spawn()
  ent:Activate()

  return ent

end

function ENT:Initialize()

  -- We do NOT want to execute anything below in this FUNCTION on CLIENT
  if ( CLIENT ) then return end

  -- Use the helibomb model just for the shadow (because it's about the same size)
  self:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )

  -- We will put this here just in case, even though it should be called from OnBallSizeChanged in any case
  self:RebuildPhysics()

end

function ENT:RebuildPhysics( value )

  -- This is necessary so that the vphysics.dll will not crash when attaching constraints to the new PhysObj after old one was destroyed
  -- TODO: Somehow figure out why it happens and/or move this code/fix to the constraint library
  self.ConstraintSystem = nil

  local size = math.Clamp( value or self:GetBallSize(), self.MinSize, self.MaxSize ) / 2.1
  self:PhysicsInitSphere( size, "metal_bouncy" )
  self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )

  self:PhysWake()

end

function ENT:OnBallSizeChanged( varname, oldvalue, newvalue )

  -- Do not rebuild if the size wasn't changed
  if ( oldvalue == newvalue ) then return end

  self:RebuildPhysics( newvalue )

end

function ENT:OnTakeDamage( dmginfo )

  -- React physically when shot/getting blown
  self:TakePhysicsDamage( dmginfo )

end

function ENT:Use( activator, caller )

  self:Remove()

  if ( activator:IsPlayer() ) then

    -- Give the collecting player some free health
    local health = activator:Health()
    activator:SetHealth( health + 5 )

  end

end

if ( SERVER ) then return end -- We do NOT want to execute anything below in this FILE on SERVER

function ENT:Draw()
end
