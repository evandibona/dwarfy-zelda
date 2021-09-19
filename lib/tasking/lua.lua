local tsk = {}

-- move up, left, right, down, sets the target as those spaces ahead. 

local fxs = {
  ["moveUp"] = function(c, p)
    c.y = c.y - c.speed
    p[2] = p[2] - c.speed 
    if p[2] <= 0 then return true end
  end, 
  ["moveLeft"] = function(c, p) end, 
}

local function run_task(char, task)
  if #task > 0 then
    local fx = fxs[task[1]]
    if fx then
      if fx(char, task) then
        table.remove(char.tasks)
      end
    end
  end
end

function tsk.run_all(chars)
  for i=1,#chars do
    local char = chars[i]
    if #char.tasks > 0 then
      for j=#char.tasks,1,-1 do
        run_task(char, char.tasks[j])
      end
    end
  end
end

return tsk
