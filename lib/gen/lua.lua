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
  elseif cmatch(r,g,b,100,171,227) then return trk.tls.water
  elseif cmatch(r,g,b,210,216,174) then return trk.tls.thin
  elseif cmatch(r,g,b,185,192,141) then return trk.tls.thick
  else                                  return trk.tls.sand
  end
end

local function getObj( bmp, x, y )
  local r,g,b = bmp:get_pixel( x, y )
  if r == 255 then                      return nil
  elseif cmatch(r,g,b,223,229,108) then return trk.obj.shruba
  elseif cmatch(r,g,b,194,198,131) then return trk.obj.shrubb
  elseif cmatch(r,g,b,167,167,167) then return trk.obj.roca 
  elseif cmatch(r,g,b,154,154,154) then return trk.obj.rocb 
  elseif cmatch(r,g,b,125,125,125) then return trk.obj.rocc 
  else                                  return nil
  end
end

function gen.load_bitmap_layers( fns )
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
        end
      end
    end
  end
  return map
end

return gen

