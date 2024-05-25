local classes = require("Scripts/Classes/classes")
local ScreenObject = require("Scripts/Classes/ScreenObject")

local Drop = classes.class(ScreenObject)

function Drop:init(dropParams)
    print("Drop init!")
    
    self.super:init(dropParams)
    
    self.params = dropParams
end

function Drop:reset()
end

function Drop:update(dt)  
    self.y = self.y + dt * self.params.speed
end

return Drop