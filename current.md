# Проблемы

- Патроны - выдавать при респауне? сделать ящик? продавать?
- Проставить спауны для нашествия зомби
- LOOC, OOC, PM
- Сделать motd окошко
- Переделать 3D Escape
- Доперевести Tab
- Доработать HUD

# Введения

- Система голосований
- Сделать здания и управляющих
- Доделать систему героев
- Биржа труда
- Систему дня и ночи
- Аренду квартир и номеров

```lua
GM:PlayerCanSeePlayersChat( string text, boolean teamOnly, Player listener, Player speaker )
```

```lua
if SERVER then
	util.AddNetworkString('LOOC') -- Whenever you are networking, you need to add the string like so or you will get an error.
	hook.Add('PlayerSay', 'LOOCcommand', function(ply, text, public)
		if text:sub(1,5) == '!looc' then
			for _, e in pairs(ents.FindInSphere(ply:GetPos(), 50)) do -- Here we iterate through all of the entities within 50 units of the player.
				if e:IsPlayer() then -- This detects all entities, so make sure the entity is a player.
					net.Start('LOOC')
						net.WriteEntity(ply) -- Write the sender
						net.WriteString(text:sub(7)) -- Write the text
					net.Send(e) -- Send it to the player.
				end
			end
		return '' -- Make sure that the actual message does not appear.
		end
	end)
else
	net.Receive('LOOC', function(len)
		local ply = net.ReadEntity() -- Read the player and text clientside.
		local text = net.ReadString()
		chat.AddText(Color(0,255,0), '[LOOC] ', team.GetColor(ply:Team()), ply:Name(), Color(255,255,255), ': '..text  ) -- Use the chat.AddText format to display the LOOC tag, the player's name, and the text.
	end)
end
```
