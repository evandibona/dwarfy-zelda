local maps = {}
maps.a_w, maps.a_h = 24, 24
maps.t_s = 16
maps.w = maps.a_w * maps.t_s
maps.h = maps.a_h * maps.t_s

local function nxy( n ) 
  return math.fmod(n, maps.a_h), math.floor(n/maps.a_w) end

local function getTile(t_x, t_y)
  return love.graphics.newQuad( 
    t_x*maps.t_s, t_y*maps.t_s, maps.t_s, maps.t_s, maps.w, maps.h ) end

function maps.drawMap(tatl, oatl, map, x_off, y_off)
  for j=1,#map do
    for i=1,#(map[j]) do
      if  (i>=x_off and i<x_off+30) 
        and (j>=y_off and j<y_off+17) then
        local a, b = map[j][i][1], map[j][i][2]
        love.graphics.draw( tatl, getTile(nxy(a)), 
          (i-x_off)*maps.t_s, (j-y_off)*maps.t_s )
        if b  then
          love.graphics.draw( oatl, getTile(nxy(b)), 
            (i-x_off)*maps.t_s, (j-y_off)*maps.t_s )
        end
      end
    end
  end
  --[[
  for j=1,#map do
    for i=1,#(map[j]) do
      local a, b = map[j][i][1], map[j][i][2]
      love.graphics.draw( tatl, getTile(nxy(a)), 
        (i-x_off)*maps.t_s, (j-y_off)*maps.t_s )
      if b  then
        love.graphics.draw( oatl, getTile(nxy(b)), 
          (i-x_off)*maps.t_s, (j-y_off)*maps.t_s )
      end
    end
  end
  --]]
end

function maps.drawSprite(sheet, xo, yo)
  local spriteQuad = 
    love.graphics.newQuad( 0, 0, 16, 32, 64, 128 )
  love.graphics.draw( sheet, spriteQuad, xo, yo )
end

return maps
