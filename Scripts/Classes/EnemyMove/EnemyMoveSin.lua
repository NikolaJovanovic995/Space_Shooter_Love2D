local classes = require("Scripts/Classes/classes")
local EnemyMoveSin = classes.class()

local stageWidth = nil
local stageHeight = nil
local frequency = 4

function EnemyMoveSin:init()
  
    self.time = 0
end

function EnemyMoveSin:update(dt, speed, x, y)  
    self.time = self.time + dt * frequency        
    return x + math.sin(self.time) * dt * speed, y + speed * dt
end


return EnemyMoveSin