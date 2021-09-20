local tsk = {}
local trk = require("./lib/track.lua")

-- move up, left, right, down, sets the target as those spaces ahead. 

function tsk.surroundings(map, x, y)
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

local function direction(x, y, tx, ty)
  local a, b = tx-x, ty-y
  if a ~= 0 then a = a/math.abs(a) end
  if b ~= 0 then b = b/math.abs(b) end
  return a, b
end

local function moveto(c, m, tx, ty)
  
  local da, db = direction(c.X(), c.Y(), tx, ty)
  local s = tsk.surroundings(m, c.X(), c.Y())
  
  local h = s[2][2]
  c.x = c.x + da*h*c.speed   c.y = c.y + db*h*c.speed

  --print("-----------------")
  --print(s[1][1],s[1][2],s[1][3])
  --print(s[2][1],s[2][2],s[2][3])
  --print(s[3][1],s[3][2],s[3][3])

  if s[2+db][2+da] == 0 then return true 
  elseif (c.X()==tx) and (c.Y()==ty) then return true 
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
