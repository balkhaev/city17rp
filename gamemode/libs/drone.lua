-- dronesrewrite_medic,dronesrewrite_ardrone,dronesrewrite_balltur,dronesrewrite_bomb,dronesrewrite_camera,dronesrewrite_turret,dronesrewrite_defender,dronesrewrite_dropship,dronesrewrite_dxl,dronesrewrite_firestorm,dronesrewrite_helicopter,dronesrewrite_laser,dronesrewrite_attackdr(sick!),dronesrewrite_gunner,dronesrewrite_minedr,dronesrewrite_nanodr,dronesrewrite_plasmadr,dronesrewrite_racerdr,dronesrewrite_scout,dronesrewrite_sniper,dronesrewrite_spyspider,dronesrewrite_spy

local drone = ents.Create("dronesrewrite_scout")
if not IsValid( drone ) then return end
drone:SetPos( Vector( 1821.3947753906,261.98876953125,80.03125 ) )
drone:Spawn()

local drone2 = ents.Create("dronesrewrite_minedr")
if not IsValid( drone2 ) then return end
drone2:SetPos( Vector( 1581.99609375,252.29948425293,80.03125 ) )
drone2:Spawn()

local drone3 = ents.Create("dronesrewrite_spy")
if not IsValid( drone3 ) then return end
drone3:SetPos( Vector( -2933.1882324219,-2970.8256835938,612.03125 ) )
drone3:Spawn()

local drone4 = ents.Create("dronesrewrite_racerdr")
if not IsValid( drone4 ) then return end
drone4:SetPos( Vector( -3363.310546875,-1746.154296875,144.03125 ) )
drone4:Spawn()