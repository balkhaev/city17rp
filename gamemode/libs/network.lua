net.Receive("createDrone", function()
  local droneName = net.ReadString()
  local dronePos = string.Explode(",", net.ReadString())

  local drone = ents.Create(droneName)
  if not IsValid( drone ) then return end
  drone:SetPos( Vector( dronePos ) )
  drone:Spawn()
end)