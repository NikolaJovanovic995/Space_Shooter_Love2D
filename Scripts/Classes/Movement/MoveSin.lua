local classes = require("Scripts/Classes/classes")
local MoveSin = classes.class()

local frequency = 4

function MoveSin:init()
  
    self.time = 0
end

function MoveSin:update(dt, speed, x, y)  
    self.time = self.time + dt * frequency        
    return x + math.sin(self.time) * dt * speed, y + speed * dt
end


return MoveSin