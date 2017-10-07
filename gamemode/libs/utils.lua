core.utils = {}

function core.utils.getPlayerByNick(nick)
  nick = string.lower(nick);
  for _,v in ipairs(player.GetHumans()) do
    if string.find(string.lower(v:Nick()),nick,1,true) ~= nil then
      return v
    end
  end
end

function core.utils.getPlayerBySteamID(steamID)
  for _,v in ipairs(player.GetHumans()) do
    if string.find(v:SteamID(),steamID,1,true) ~= nil then
      return v
    end
  end
end