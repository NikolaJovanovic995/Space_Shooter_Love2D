local classes = require("Scripts/Classes/classes")
local MoveStraight = classes.class()


function MoveStraight:update(dt, speed, x, y)  
    return x, y + speed * dt
end


return MoveStraight