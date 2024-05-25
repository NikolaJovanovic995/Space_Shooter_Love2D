local classes = require("Scripts/Classes/classes")
local ScreenObject = require("Scripts/Classes/ScreenObject")
local ScreenSize = require("Scripts/Models/ScreenSize")

local Drop = classes.class(ScreenObject)

function Drop:init(dropParams)
    print("Drop init!")
    
    self.super:init(dropParams)
    
    self.x = math.random(self.offsetX, ScreenSize.screenWidth - self.offsetX)
    self.y = - self.h
    self.params = dropParams
end

function Drop:reset()
    self.x = math.random( self.offsetX, ScreenSize.screenWidth - self.offsetX)
    self.y = - self.h
end

function Drop:update(dt)  
    self.y = self.y + dt * self.params.speed
end

return Drop