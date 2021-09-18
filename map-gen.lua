#!/usr/bin/lua5.3
---------0 --------0 --------0 --------0 --------0 --------0 --------0 --------0

-- Convert img-data into Lua array. 

local bitmap = require("./lib/bitmap.lua")
local island = bitmap.from_file("./gfx/gen/gen-test.bmp")
local maps = {
  bitmap.from_file("./gfx/gen/island-base.bmp"),
  bitmap.from_file("./gfx/gen/island-landscape.bmp")
}

local hdr = "local gen = {}\ngen.island = {\n"
local ftr = "\n}\n\nreturn gen\n"

local t = {}


print("\n\n")

io.write(hdr)

local function ritel(s) io.write(s..",") end

for y=0,bmp.height-1 do
  io.write("\n  { ")
  for x=0,bmp.width-1 do
    local r,g,b,a = bmp:get_pixel(x,y)
    if r <= 120 then 
      ritel(t.water)
    elseif ((r > 220) and (g > 220))  then 
      ritel(t.sand)
    elseif b <= 130  then 
      ritel(t.thick)
    else
      ritel(t.thin)
    end
  end
  if y<bmp.height-1 then 
       io.write(" },") 
  else io.write(" }" ) end
end
io.write(ftr)
print("")
