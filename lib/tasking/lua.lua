local tsk = {}
local trk = require("./lib/track.lua")
local bhv = require("./lib/behaviour.lua")
local geo = require("./lib/geometry.lua")

tsk.log = {}
function tsk.print_log()
  for i=1,#tsk.log do
    print(tsk.log[i])
  end
end

-- move up, left, right, down, sets the target as those spaces ahead. 

function tsk.glance(char, map, x, y)
  local l = { {-1,-1},{0,-1},{1,-1}, {-1,0},{1,0}, {-1,1},{0,1},{1,1} }
  local obs = {}
  for i=1,#l do
    local lx, ly = l[i][1], l[i][2]
    local obj = map[y+ly][x+lx][2]
    if obj then 
      --Consider an action
      bhv.sees_obj(char, trk.lookup[obj])
    end
  end
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
  local s = geo.surroundings(m, c.X(), c.Y())
  local h = s[2][2]
  c.x = c.x + da*h*c.speed   c.y = c.y + db*h*c.speed

  if (math.floor((c.x%24)*3)==0) or (math.floor((c.y%24)*3)==0) then 
    --actions while moving
    tsk.glance(c, m, c.X(), c.Y())
  end

  if s[2+db][2+da] <= 0.1 then return true 
  elseif distance(c.X(), c.Y(), tx, ty) < 1 then return true 
  elseif c.speed <= 0 then return true
  end
end

local function journeyto(c, m, last, tx, ty)
  local cx, cy = c.X(), c.Y()
  local dist   = distance(cx, cy, tx, ty)
  local dx, dy = direction(cx, cy, tx, ty)
  local seg = 6

  local ldist = 99
  if #last > 0 then 
    ldist = distance(last[1], last[2], cx, cy)
  end

  if ldist and last.prgs then
    if ldist/seg < 0.6 then
      last.prgs = last.prgs - 1
      if last.prgs < -9 then last.prgs = -9 end
    else
      last.prgs = last.prgs + 1
      if last.prgs > 5 then last.prgs = 5 end
    end
    --if last.prgs < 0 then
    --  dx, dy = -dx*2, -dy*2
    --end
  elseif not last.prgs then
    last.prgs = 0
  end

  if ldist < 2 then
    dx, dy = love.math.random(-1, 1), love.math.random(-1, 1)
  elseif last.prgs < 3 then
    local g,h = {-1,0,1,dx,dx,dx},{-1,0,1,dy,dy,dy}
    dx = g[love.math.random(1,6)]
    dy = h[love.math.random(1,6)] 
  end

  if dist <= 2 then
    return true -- our journey is over.
  elseif dist < seg then
    table.insert(c.tasks, { 'moveto', tx, ty })
  elseif dist <= 999 then  -- Simple angle method. 
    table.insert(c.tasks, { 'moveto', cx+(dx*seg), cy+(dy*seg) })
  else
    print("dist is greater than 999!!!")
  end
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

function tsk.assess_all(chars, map)
  for i=1,#chars do
    local char = chars[i]
    bhv.assess_impulses(char, map)
  end
end


return tsk
