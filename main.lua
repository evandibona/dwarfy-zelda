#!/usr/bin/lua5.3
---------0 --------0 --------0 --------0 --------0 --------0 --------0 --------0

local chars= require("./lib/characters.lua")
local draw = require("./lib/draw.lua")
local gen  = require("./lib/gen.lua")
local bhv  = require("./lib/behaviour.lua")
local tsk  = require("./lib/tasking.lua")
local x_off,  y_off = 250, 144
local ww, wh = 30, 17
local time_of_day = 0

local map = gen.load_bitmap_layers({
  "./gfx/gen/island-base.bmp", 
  "./gfx/gen/island-landscape.bmp"
})

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
      chars[1].tasks[#chars[1].tasks][3] = chars[1].tasks[#chars[1].tasks][3] - 2
    else table.insert( chars[1].tasks, {'moveto', chars[1].X(), chars[1].Y()-1 })
    end
  elseif key == "down" then
    if #chars[1].tasks > 0 then
      chars[1].tasks[#chars[1].tasks][3] = chars[1].tasks[#chars[1].tasks][3] + 2
    else table.insert( chars[1].tasks, {'moveto', chars[1].X(), chars[1].Y()+1 })
    end
  elseif key == "left" then
    if #chars[1].tasks > 0 then
      chars[1].tasks[#chars[1].tasks][2] = chars[1].tasks[#chars[1].tasks][2] - 2
    else table.insert( chars[1].tasks, {'moveto', chars[1].X()-1, chars[1].Y() })
    end
  elseif key == "right" then
    if #chars[1].tasks > 0 then
      chars[1].tasks[#chars[1].tasks][2] = chars[1].tasks[#chars[1].tasks][2] + 2
    else table.insert( chars[1].tasks, {'moveto', chars[1].X()+1, chars[1].Y() })
    end
  end
end

function love.update( dt )
  time_of_day = time_of_day + dt
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
  if love.keyboard.isDown("escape") then love.event.quit() end

  -- TIME
  if      time_of_day >= 1200 then time_of_day = 0
  elseif (time_of_day % 2 ) <= dt then 
    -- bhv.assess_all(chars, map)
    -- tsk.surroundings( map, chars[1].X(), chars[1].Y() )
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
