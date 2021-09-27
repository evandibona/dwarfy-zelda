local trk = require("./lib/track.lua")
local geo = {}

function geo.surroundings(map, x, y)
  local function s(n)
    if n ==     trk.tls.water then return 0.1
    elseif n == trk.tls.thick then return 0.5
    else return 1 end
  end
  return { 
    { s(map[y-1][x-1][1]), s(map[y-1][x][1]),   s(map[y-1][x+1][1]) },
    {   s(map[y][x-1][1]),   s(map[y][x][1]),     s(map[y][x+1][1]) }, 
    { s(map[y+1][x-1][1]), s(map[y+1][x][1]),   s(map[y+1][x+1][1]) } 
  }
end


return geo
