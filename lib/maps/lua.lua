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
      local a, b = nxy(map[j][i][1])
      love.graphics.draw( overAtlas, 
        getTile(nxy(map[j][i][1])), 
        (i-x_off)*maps.t_s, (j-y_off)*maps.t_s )
      if map[j][i][2] then
        love.graphics.draw( overAtlas, 
          getTile(nxy(map[j][i][2])), 
          (i-x_off)*maps.t_s, (j-y_off)*maps.t_s )
      end
    end
  end
end

function maps.drawSprite(sheet, xo, yo)
  local spriteQuad = 
    love.graphics.newQuad( 0, 0, 16, 32, 64, 128 )
  love.graphics.draw( sheet, spriteQuad, xo, yo )
end

return maps
