#!/usr/bin/lua5.3

local chars= require("./lib/characters.lua")
local draw = require("./lib/draw.lua")
local gen  = require("./lib/gen.lua")
local tsk  = require("./lib/tasking.lua")
local x_off,  y_off = 254, 133
--x_off,  y_off = 0, 0
local ww, wh = 30, 17
local map = gen.load_bitmap_layers({
  "./gfx/gen/island-base.bmp", 
  "./gfx/gen/island-items.bmp", 
--  "./gfx/gen/island-landscape.bmp"
})

map.time_of_day = 0

function love.load()
  love.window.setMode( 960, 540)--, {fullscreen = true} )
  teratlas = love.graphics.newImage("gfx/beach-tiles.png")
    teratlas:setFilter("nearest", "nearest")
  objatlas = love.graphics.newImage("gfx/object-tiles.png")
    objatlas:setFilter("nearest", "nearest")
  guysheet = love.graphics.newImage("gfx/guy.png")
    guysheet:setFilter("nearest", "nearest")
end

function love.keyreleased( key )
  if key == "up" then
    if #chars[1].tasks > 0 then
      chars[1].tasks[#chars[1].tasks][3] = chars[1].tasks[#chars[1].tasks][3] - 1
    else table.insert( chars[1].tasks, {'moveto', chars[1].X(), chars[1].Y()-1 })
    end
  elseif key == "down" then
    if #chars[1].tasks > 0 then
      chars[1].tasks[#chars[1].tasks][3] = chars[1].tasks[#chars[1].tasks][3] + 1
    else table.insert( chars[1].tasks, {'moveto', chars[1].X(), chars[1].Y()+1 })
    end
  elseif key == "left" then
    if #chars[1].tasks > 0 then
      chars[1].tasks[#chars[1].tasks][2] = chars[1].tasks[#chars[1].tasks][2] - 1
    else table.insert( chars[1].tasks, {'moveto', chars[1].X()-1, chars[1].Y() })
    end
  elseif key == "right" then
    if #chars[1].tasks > 0 then
      chars[1].tasks[#chars[1].tasks][2] = chars[1].tasks[#chars[1].tasks][2] + 1
    else table.insert( chars[1].tasks, {'moveto', chars[1].X()+1, chars[1].Y() })
    end
  end
end

function love.update( dt )
  map.time_of_day = map.time_of_day + dt
  local speed = 18 
  if love.keyboard.isDown("a") then
    x_off = x_off - (speed * dt)
  elseif love.keyboard.isDown("d") then
    x_off = x_off + (speed * dt)
  end
  if love.keyboard.isDown("w") then
    y_off = y_off - (speed * dt)
  elseif love.keyboard.isDown("s") then
    y_off = y_off + (speed * dt)
  end
  if love.keyboard.isDown("escape") then 
    love.event.quit() 
    tsk.print_log()
  end

  -- TIME
  if      map.time_of_day >= 1200 then map.time_of_day = 0
  elseif (map.time_of_day % 2 ) <= dt then 
    tsk.assess_all(chars, map)
  end

  tsk.run_all( chars, map )

end

function love.draw()
  love.graphics.scale( 2 )
  draw.map(   teratlas, objatlas, map, x_off, y_off, ww, wh )
  draw.chars( guysheet, chars, x_off, y_off, ww, wh )
end
--[[
--]]
