local tsk = {}
local trk = require("./lib/track.lua")

-- move up, left, right, down, sets the target as those spaces ahead. 

function tsk.surroundings(map, x, y)
  local function s(n)
    if n ==     trk.tls.water then return 1
    elseif n == trk.tls.thick then return 0.25
    else return 0 end
  end

  local d = { 
    s(map[y-1][x-1][1]), s(map[y-1][x][1]),   s(map[y-1][x+1][1]),
    s(map[y][x+1][1]),   s(map[y+1][x+1][1]), s(map[y+1][x][1]), 
    s(map[y+1][x-1][1]), s(map[y][x-1][1]),   s(map[y][x][1]), 
  }
  return d
end

local function direction(x, y, tx, ty)
  local a, b = tx-x, ty-y
  if a ~= 0 then a = a/math.abs(a) end
  if b ~= 0 then b = b/math.abs(b) end
  local ds = { {1,2,3},{8,9,4},{7,6,5} }
  return ds[2+b][2+a]
end

local function moveto(c, m, tx, ty)

  --local hindrance = 0
  --local spd = c.speed * hindrance

  -- If movement is possible, it's not ideal, but the target has not been reached
  --  Pick a random direction of available options

  -- determine the direction from cur_pos to target. 

  -- Pick the closest next step from there. 
  
  local s = 
    { {-1,-1}, {0,-1}, {1,-1}, {1,0}, {1,1}, {0,1}, {-1,1}, {-1,0} }
  local d = direction(c.X(), c.Y(), tx, ty)

  c.x = c.x + s[d][1] c.y = c.y + s[d][2]

  if (c.X()==tx) and (c.Y()==ty) then return true 
  --elseif hindrance >= 1 then return true
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
        --print(task[1], " is done.")
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
