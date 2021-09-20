function charTemplate()
  local char = {}
  char.x, char.y = 273*16, 146*16
  char.X = function() return math.ceil((char.x/16)-0.14) end
  char.Y = function() return math.floor((char.y/16)) end
  char.tasks = {}
  char.speed = 0.5
  char.boredom = 0
  return char
end

local a, b, c = charTemplate(), charTemplate(), charTemplate()

a.boredom = 60
b.boredom = 60
c.boredom = 60

a.name = "Perry McCormick"
  a.speed = 0.6
b.name = "Rayne Blanchard"
  b.y = b.y - 3*16
  b.speed = 0.7
c.name = "Bee Bob"
  c.y = c.y - 3*16
  c.x = c.x + 3*16
  c.speed = 0.62

local chars = {a}
--table.insert(chars, { a, b, c, d, e, f, g})
return chars

--[[
  Let's figure out tasks. 
    * first, every movement must be limited by surrounding tiles. 
    * record last move / progress toward goal. 
    * semi-random
    * very simple algorithm

  States of a character can be handled less frequently. 
  Position must be handled every moment. 
--]]
