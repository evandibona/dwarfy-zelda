local bhv = {}
local tsk = require("./lib/tasking.lua")


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

local function assess_impulses(char, map)
  local sur = tsk.surroundings(map, char.X(), char.Y())
  print( " >", char.boredom )
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

function bhv.assess_all(chars, map)
  for i=1,#chars do
    local char = chars[i]
    assess_impulses(char, map)
  end
end

return bhv
