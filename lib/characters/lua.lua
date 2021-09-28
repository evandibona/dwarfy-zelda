function charTemplate()
  local char = {}
  char.x, char.y = 280*16, 130*16
  char.X = function() return math.floor((char.x/16)+0.5) end
  char.Y = function() return math.floor((char.y/16)+1.5-.1) end
  char.tasks = {}
  char.speed = 0.5
  char.color = 0
  char.boredom    = 0
  char.hunger     = 70
  char.exhaustion = 0

  char.openn, char.consc, char.extro, char.agree, char.neuro = 50,50,50,50,50

  return char
end

local a, b, c, d = charTemplate(), charTemplate(), charTemplate(), charTemplate()

a.boredom = 50
b.boredom = 50
c.boredom = 50
d.boredom = 50

local meethere = {170, 120}
-- table.insert(a.tasks, { "journey", meethere[1], meethere[2], {}})
table.insert(a.tasks, { "moveto", 254, 131 })
table.insert(b.tasks, { "moveto", 254, 133 })

a.name = "Perry McCormick"
  a.speed = 0.5
  a.color = 3
  a.openn, a.consc, a.extro, a.agree, a.neuro  = 50, 50, 50, 50, 80
b.name = "Rayne Blanchard"
  b.y = b.y + 3*16
  b.speed = 0.5
  b.color = 1
  a.openn, a.consc, a.extro, a.agree, a.neuro  = 50, 80, 50, 50, 50
c.name = "Bee Bob"
  c.y = c.y - love.math.random(-3,3)*16
  c.x = c.x + love.math.random(-3,3)*16
  c.speed = 0.62
  c.color = 2
d.name = "Johnson"
  d.y = d.y - love.math.random(-3,3)*16
  d.x = d.x + love.math.random(-3,3)*16
  d.speed = 0.22
  d.color = 0


local chars = {a,b}--, d}
--table.insert(chars, { a, b, c, d, e, f, g})
return chars
