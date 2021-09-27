---------0 --------0 --------0 --------0 --------0 --------0 --------0 --------0
local gen = {}

local bitmap = require("./lib/bitmap.lua")
local trk = require("./lib/track.lua")

local function cmatch(dr, dg, db, a, b, c)
  return ((dr == a) and (dg == b) and (db == c))
end

local function getTile( bmp, x, y)
  local r,g,b = bmp:get_pixel( x, y )
  if r == 1 then return trk.tls.water
  elseif cmatch(r,g,b,100,171,227) then return trk.tls['water']
  elseif cmatch(r,g,b,210,216,174) then return trk.tls['thin']
  elseif cmatch(r,g,b,185,192,141) then return trk.tls['thick']
  else                                  return trk.tls['sand']
  end
end

local function getObj( bmp, x, y )
  local r,g,b = bmp:get_pixel( x, y )
  if r == 255 then                      return nil
  elseif cmatch(r,g,b,249,247,221) then return trk.item['sushi']
  elseif cmatch(r,g,b,106,191, 30) then return trk.item['watermelon']
  elseif cmatch(r,g,b,243, 58, 58) then return trk.item['matches']
  elseif cmatch(r,g,b,87,93,95)    then return trk.item['knife']
  elseif cmatch(r,g,b,252,248,124) then return trk.item['goldCoin']
  elseif cmatch(r,g,b,202,206,210) then return trk.item['silverCoin']
  elseif cmatch(r,g,b,236,216, 88) then return trk.item['goldBar']
  elseif cmatch(r,g,b,171,175,179) then return trk.item['silverBar']
  else                                  return nil
  end
end

function gen.load_bitmap_layers( fns )
  print(">>> ", trk.item['watermelon'])

  local mw, mh = 0, 0
  local map = {}
  for z=1,#fns do
    lyr = bitmap.from_file(fns[z])
    mw, mh = lyr.width, lyr.height
    for y=1,mh do
      if z ==1 then
        table.insert( map, {} )
      end
      for x=1,mw do
        if z==1 then
          table.insert( map[y], { getTile(lyr, x-1, y-1) } )
        else
          table.insert( map[y][x], getObj(lyr, x-1, y-1) )
          if map[y][x][2] then print( "added: ", map[y][x][2], x..", "..y ) end
        end
      end
    end
  end
  return map
end

return gen

