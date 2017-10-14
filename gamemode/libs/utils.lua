core.utils = {}

function core.utils.getPlayerByNick(nick)
  nick = string.lower(nick);
  for _,v in ipairs(player.GetHumans()) do
    if string.find(string.lower(v:Nick()),nick,1,true) ~= nil then
      return v
    end
  end
end

function core.utils.getRandomVector(spawns)
  local spawnpos = table.Random( spawns )
  local explopos = string.Explode(",", spawnpos)

  return Vector(explopos[1],explopos[2],explopos[3])
end

function core.utils.tableConcat(t1,t2)
  for i=1,#t2 do
    t1[#t1+1] = t2[i]
  end
  return t1
end