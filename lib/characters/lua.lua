function charTemplate()
  local char = {}
  char.x, char.y = 273*16, 146*16
  --char.x, char.y = 3*16, 3*16
  char.X = function() return math.floor((char.x/16)+0.5) end
  char.Y = function() return math.floor((char.y/16)+1.5-.1) end
  char.tasks = {}
  char.speed = 0.5
  char.boredom = 0
  return char
end

local a, b, c = charTemplate(), charTemplate(), charTemplate()

a.boredom = 30
b.boredom = 30
c.boredom = 30

a.name = "Perry McCormick"
  a.speed = 0.6
  table.insert(a.tasks, { "journey", 250, 150, {} })
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
