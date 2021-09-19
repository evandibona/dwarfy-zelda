function charTemplate()
  local char = {}
  char.x, char.y = 194*16, 182*16
  char.tasks = {}
  char.speed = 0.25
  return char
end

local a, b = charTemplate(), charTemplate()

a.name = "Perry McCormick"
  table.insert(a.tasks, { 'moveLeft', 50 })
  table.insert(a.tasks, { 'moveUp', 20*16 })
  table.insert(a.tasks, { 'work', 0 })
b.name = "Rayne Blanchard"
  b.x = b.x + 5*16

local chars = {a, b}
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
