#!/usr/bin/lua5.3
---------0 --------0 --------0 --------0 --------0 --------0 --------0 --------0

local maps = require("./lib/maps.lua")
local gen  = require("./lib/gen.lua")
local x_off,  y_off = 82, 12


function love.load()
  atlas = love.graphics.newImage("gfx/beach-tiles.png")
  atlas:setFilter("nearest", "nearest")
end

function love.update( dt )
  local speed = 33 * dt
  if love.keyboard.isDown("left")  then x_off = x_off - speed end
  if love.keyboard.isDown("right") then x_off = x_off + speed end
  if love.keyboard.isDown("up")    then y_off = y_off - speed end
  if love.keyboard.isDown("down")  then y_off = y_off + speed end
  if love.keyboard.isDown("escape") then love.event.quit() end
end

function love.draw()
  love.graphics.scale( 2 )
  maps.drawMap( atlas, gen.island, 
    math.floor(x_off), math.floor(y_off) )
end
