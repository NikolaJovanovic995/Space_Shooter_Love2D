local classes = require("Scripts/Classes/classes")
local Model = require("Scripts/Models/Model")
local EnemyMoveStraight = classes.class()

local stageWidth = nil
local stageHeight = nil

function EnemyMoveStraight:init()
    
    stageWidth = Model.stage.stageWidth
    stageHeight = Model.stage.stageHeight
    
end

function EnemyMoveStraight:update(dt, speed, x, y)  
    return x, y + speed * dt
end


return EnemyMoveStraight