core.utils = {}

function core.utils.getPlayerByNick(nick)
  nick = string.lower(nick);
  for _,v in ipairs(player.GetHumans()) do
    if string.find(string.lower(v:Nick()),nick,1,true) ~= nil then
      return v
    end
  end
end

function core.utils.getRandomVector(table)
  local spawnpos = table.Random( table )
  local explopos = string.Explode(",", spawnpos)

  return Vector(explopos[1],explopos[2],explopos[3])
end
