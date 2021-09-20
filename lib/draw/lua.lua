local draw = {}
draw.a_w, draw.a_h = 24, 24
draw.t_s = 16
draw.w = draw.a_w * draw.t_s
draw.h = draw.a_h * draw.t_s

local function nxy( n ) 
  return math.fmod(n, draw.a_h), math.floor(n/draw.a_w) end

local function getTile(t_x, t_y)
  return love.graphics.newQuad( 
    t_x*draw.t_s, t_y*draw.t_s, draw.t_s, draw.t_s, draw.w, draw.h ) end

function draw.map(tatl, oatl, map, x_off, y_off, ww, wh)
  for j=1,#map do
    for i=1,#(map[j]) do
      if  (i>=x_off-1 and i<x_off+ww) 
        and (j>=y_off-1 and j<y_off+wh) then
        local a, b = map[j][i][1], map[j][i][2]
        love.graphics.draw( tatl, getTile(nxy(a)), 
          (i-x_off)*draw.t_s, (j-y_off)*draw.t_s )
        if b  then
          love.graphics.draw( oatl, getTile(nxy(b)), 
            (i-x_off)*draw.t_s, (j-y_off)*draw.t_s )
        end
      end
    end
  end
end

function draw.chars(sheet, chars, x_off, y_off, ww, wh)
  for i=1,#chars do
    local char = chars[i]
    local charq = love.graphics.newQuad( 0, 0, 16, 32, 64, 128 )
    if true then -- If in view-port
      love.graphics.draw( sheet, charq, 
        char.x-(x_off*draw.t_s), char.y-(y_off*draw.t_s) )

      local ct = char.tasks[#char.tasks] 
      if ct then
        local charqq = love.graphics.newQuad( 32, 32, 16, 32, 64, 128 )
        love.graphics.draw( sheet, charqq, 
          ct[2]*16-(x_off*draw.t_s), ct[3]*16-(y_off*draw.t_s) )
      end
    end
  end
end

return draw
