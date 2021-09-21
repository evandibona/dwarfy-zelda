local tsk = {}
local trk = require("./lib/track.lua")

tsk.log = {}
function tsk.print_log()
  for i=1,#tsk.log do
    print(tsk.log[i])
  end
end

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

local function simpledir(x, y, tx, ty)
  local a, b = tx-x, ty-y
  if a~=0 then a = a/math.abs(a) end
  if b~=0 then b = b/math.abs(b) end
  return a, b
end

local function direction(x, y, tx, ty)
  local a, b = tx-x, ty-y
  if a~=0 and b~=0 then
    if (math.abs(a) >= math.abs(b)) then
      b = b/math.abs(a) a = a/math.abs(a) 
    else
      a = a/math.abs(b) b = b/math.abs(b)
    end
  end
  return a, b
end

local function angirection(x, y, tx, ty)
  local a, b = tx-x, ty-y
  a = math.atan(b, a)
  b = math.atan(b, a)
  return math.atan(b, a)
end

local function distance(x, y, tx, ty)
  return math.floor(math.sqrt( (tx-x)^2 + (ty-y)^2 ))
end

local function moveto(c, m, tx, ty)
  local da, db = simpledir(c.X(), c.Y(), tx, ty)
  local s = tsk.surroundings(m, c.X(), c.Y())
  
  local h = s[2][2]
  c.x = c.x + da*h*c.speed   c.y = c.y + db*h*c.speed

  --print("-----------------")
  --print(s[1][1],s[1][2],s[1][3])
  --print(s[2][1],s[2][2],s[2][3])
  --print(s[3][1],s[3][2],s[3][3])

  if s[2+db][2+da] <= 0.1 then return true 
  elseif distance(c.X(), c.Y(), tx, ty) < 1 then return true 
  elseif c.speed <= 0 then return true
  end
end

local function journeyto(c, m, last, tx, ty)
  local cx, cy = c.X(), c.Y()
  local dist   = distance(cx, cy, tx, ty)
  local dx, dy = direction(cx, cy, tx, ty)
  local seg = 5

  local ldist = 99
  if #last > 0 then 
    ldist = distance(last[1], last[2], cx, cy)
  end

  if ldist < 1 then
    dx, dy = love.math.random(-1, 1), love.math.random(-1, 1)
  elseif ldist < seg then
    local g,h = {-1,0,1,dx,dx,dx},{-1,0,1,dy,dy,dy}
    dx = g[love.math.random(1,6)]
    dy = h[love.math.random(1,6)] 
  end

  if dist <= 2 then
    return true -- our journey is over.
  elseif dist <= 999 then  -- Simple angle method. 
    table.insert(c.tasks, { 'moveto', cx+(dx*seg), cy+(dy*seg) })
  end
  print( ldist, " travelled." )
  last[1], last[2] = cx, cy
end

local fxs = {
  ["moveto"] = function(c, t, m)
    return moveto(c, m, t[2], t[3])
  end, 
  ["journey"] = function(c, t, m)
    return journeyto(c, m, t[4], t[2], t[3])
  end, 
}

local function run_task(char, task, map)
  if #task > 0 then
    local fx = fxs[task[1]]
    if fx then
      if fx(char, task, map) then
        table.insert(tsk.log, math.floor(map.time_of_day).." : "..task[1]
          ..", completed by, "..char.name)
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
