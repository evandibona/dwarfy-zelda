function charTemplate()
  local char = {}
  char.x, char.y = 294*16, 150*16
  char.tasks = {}
  char.speed = 0.5
  return char
end

local a, b, c = charTemplate(), charTemplate(), charTemplate()

a.name = "Perry McCormick"
  table.insert(a.tasks, { 'moveto', 270, 140 })
  a.speed = 0.6
b.name = "Rayne Blanchard"
  table.insert(b.tasks, { 'moveto', 270, 140 })
  b.y = b.y - 2*16
  b.speed = 0.7
c.name = "Bee Bob"
  table.insert(c.tasks, { 'moveto', 270, 140 })
  c.y = c.y - 10*16
  c.speed = 0.62

local chars = {a, b, c}
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
