local tsk = {}
local trk = require("./lib/track.lua")

-- move up, left, right, down, sets the target as those spaces ahead. 

local function beneath(map, x, y)
  return map[math.floor(y/16)][math.floor(x/16)][1]
end

local function moveto(c, m, tx, ty)
  local x, y = math.ceil(c.x/16),  math.ceil(c.y/16)
  local hindrance = 0
  local til = beneath(m, c.x, c.y)
  if til == trk.tls.water then
    hindrance = c.speed
  elseif til == trk.tls.thick then
    hindrance = (c.speed/3)
  end
  local spd = c.speed - hindrance
  
  if love.math.random(1,2) == 1 then
    if     x < tx then c.x = c.x + spd
    elseif x > tx then c.x = c.x - spd end
  else
    if     y < ty then c.y = c.y + spd
    elseif y > ty then c.y = c.y - spd end
  end

  if (x==tx) and (y==ty) then return true 
  elseif hindrance >= c.speed then return true
  elseif c.speed <= 0 then return true
  end
end

local fxs = {
  ["moveto"] = function(c, p, m)
    return moveto(c, m, p[2], p[3])
  end, 
}

local function run_task(char, task, map)
  if #task > 0 then
    local fx = fxs[task[1]]
    if fx then
      if fx(char, task, map) then
        print(task[1], " is done.")
        table.remove(char.tasks)
      end
    end
  end
end

function tsk.run_all(chars, map)
  for i=1,#chars do
    local char = chars[i]
    if char.tasks[#char.tasks] then
      run_task(char, char.tasks[#char.tasks], map)
    end
  end
end

return tsk
