local classes = require("Scripts/Classes/classes")
local EnemyMoveStraight = classes.class()

function EnemyMoveStraight:init()
    
end

function EnemyMoveStraight:update(dt, speed, x, y)  
    return x, y + speed * dt
end


return EnemyMoveStraight