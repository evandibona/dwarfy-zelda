local bhv = {}


local function normal(n)
  if n <= 0 then return 0 
  elseif n>= 100 then return 100
  else return n end end

local function piddle(char)
  local function pick() 
    local p = {-3,-2,-1,-1, 0, 0, 0, 0, 1, 1, 2, 3}
    return p[love.math.random(1,10)]
  end
  return {'moveto', char.X()+pick(), char.Y()+pick()}
end

local function assess_impulses(char, map)
  if #char.tasks > 0 then
    -- Currently busy
    char.boredom = normal(char.boredom * 0.7 - 5) -- reduce   boredom
  else
    -- No Tasks
    if char.boredom > 60 then table.insert(char.tasks, piddle(char))
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
