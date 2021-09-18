#!/usr/bin/lua5.3
---------0 --------0 --------0 --------0 --------0 --------0 --------0 --------0

local maps = require("./lib/maps.lua")
local gen  = require("./lib/gen.lua")
local x_off,  y_off = 60, 20

local map = gen.load_bitmap_layers({
  "./gfx/gen/island-base.bmp", 
  "./gfx/gen/island-landscape.bmp"
})

--[[
function love.load()
  love.window.setMode( 1920, 1080, {fullscreen = true} )
  teratlas = love.graphics.newImage("gfx/beach-tiles.png")
    atlas:setFilter("nearest", "nearest")
  objatlas = love.graphics.newImage("gfx/object-tiles.png")
    atlas:setFilter("nearest", "nearest")
end

function love.update( dt )
  local speed = 33 * dt
  if love.keyboard.isDown("a") then x_off = x_off - speed end
  if love.keyboard.isDown("d") then x_off = x_off + speed end
  if love.keyboard.isDown("w") then y_off = y_off - speed end
  if love.keyboard.isDown("s") then y_off = y_off + speed end
  if love.keyboard.isDown("escape") then love.event.quit() end
end

function love.draw()
  love.graphics.scale( 2 )
  maps.drawMap( teratlas, objatlas, map, 
    math.floor(x_off), math.floor(y_off) )
end
--]]
