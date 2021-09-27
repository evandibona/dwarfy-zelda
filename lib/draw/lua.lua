local draw = {}
draw.a_w, draw.a_h = 24, 24
draw.t_s = 16
draw.w = draw.a_w * draw.t_s
draw.h = draw.a_h * draw.t_s

local function nxy( n ) 
  return math.fmod(n, draw.a_h), math.floor(n/draw.a_w) end

local function getTile(t_x, t_y)
  return love.graphics.newQuad( 
    t_x*16, t_y*16, 16, 16, 384, 384 ) end

local function draw_task_visuals(sheet, x_off, y_off, tasks)
  local function q( x, y )
    return love.graphics.newQuad( x*16, y*16, 16, 16, 256, 144 )
  end
  local yellowDot, cyanDot = q(10, 8), q(12, 8)
  if tasks[#tasks] then
    for i=#tasks,1,-1 do
      local t = tasks[i]
      if t[1] == "moveto" then
        love.graphics.draw( sheet, yellowDot, 
          t[2]*16-x_off*draw.t_s, t[3]*16-y_off*draw.t_s )
      elseif t[1] == "journey" then
        love.graphics.draw( sheet, cyanDot, 
          t[2]*16-x_off*draw.t_s, t[3]*16-y_off*draw.t_s )
      end
    end
  end
end

function draw.map(tatl, oatl, map, x_off, y_off, ww, wh)
  for j=1,#map do
    for i=1,#(map[j]) do
      if  (i>=x_off-1 and i<x_off+ww) 
        and (j>=y_off-1 and j<y_off+wh) then
        local a, b = map[j][i][1], map[j][i][2]
        love.graphics.draw( tatl, getTile(nxy(a)), 
          (i-x_off)*16, (j-y_off)*16 )
        if b then
          love.graphics.draw( oatl, getTile(nxy(b)), 
            (i-x_off)*16, (j-y_off)*16 )
        end
      end
    end
  end
end

function draw.chars(sheet, chars, x_off, y_off, ww, wh)
  for i=1,#chars do
    local char = chars[i]
    local charq = love.graphics.newQuad( 
      0+64*char.color, 0, 16, 32, 256, 144 )
    if true then -- If in view-port
      love.graphics.draw( sheet, charq, 
        char.x-(x_off*draw.t_s), (char.y-1)-(y_off*draw.t_s) )

      draw_task_visuals(sheet, x_off, y_off, char.tasks)
    end
  end
end

return draw
