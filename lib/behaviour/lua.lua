local bhv = {}
local geo = require("./lib/geometry.lua")


local function normal(n)
  if n <= 0 then return 0 
  elseif n>= 100 then return 100
  else return n end end

local function piddle(char, s)
  local o = {}
  for j=1,3 do for i=1,3 do
    if s[j][i] > 0.8 then
      table.insert(o, {i-2, j-2})
    end
  end end
  if #o > 0 then
    o = o[love.math.random(1,#o)]
    o[1] = o[1] * love.math.random(1,1,1,2)
    o[2] = o[2] * love.math.random(1,1,1,2)
    return {'moveto', char.X()+o[1], char.Y()+o[2]}
  else
    return {}
  end
end

function bhv.assess_impulses(char, map)
  local sur = geo.surroundings(map, char.X(), char.Y())
  if #char.tasks > 0 then
    -- Currently busy
    char.boredom = 0 -- reduce   boredom
  else
    -- No Tasks
    if char.boredom > 60 then 
      table.insert(char.tasks, piddle(char, sur))
      char.boredom = normal( char.boredom * 0.5 + 5 )
    else char.boredom = normal(char.boredom * 1.15 + 2) -- increase boredom
    end
  end
end

function bhv.obj_affinity(a, b)
  local function proc(ay,be,tr)
    return math.abs(ay[tr]-be[tr])/100
  end
  local averaged_dist = 
   (proc(a,b,'openn')+proc(a,b,'consc')+proc(a,b,'extro')+
    proc(a,b,'agree')+proc(a,b,'neuro')) / 5
  return 1 / ( 4 * averaged_dist + 0.4 ) - 0.225
end

function bhv.need_of_obj(a, b)
  local need = 0
  if b.food then need = a.hunger/100 end
  return need
end

function bhv.sees_obj(c, o)
  local thoughts = ""
  print( "desire: ", bhv.obj_affinity(c,o), "need: ",bhv.need_of_obj(c,o), "ya/na: ", 
    bhv.obj_affinity(c,o)*bhv.need_of_obj(c,o))
end

return bhv
