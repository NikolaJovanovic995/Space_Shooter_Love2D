local classes = require("Scripts/Classes/classes")
local Model = require("Scripts/Models/Model")
local EnemyMoveSin = classes.class()

local stageWidth = nil
local stageHeight = nil
local frequency = 5

function EnemyMoveSin:init()
    
    stageWidth = Model.stage.stageWidth
    stageHeight = Model.stage.stageHeight
    self.time = 0
end

function EnemyMoveSin:update(dt, speed, x, y)  
    self.time = self.time + dt * frequency        
    return x + math.sin(self.time) * dt * speed, y + speed * dt
end


return EnemyMoveSin