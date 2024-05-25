local classes = require("Scripts/Classes/classes")
local ScreenObject = require("Scripts/Classes/ScreenObject")
local ScreenSize = require("Scripts/Models/ScreenSize")
local MovementManager = require("Scripts/Managers/MovementManager")

local Drop = classes.class(ScreenObject)

function Drop:init(dropParams)
    print("Drop init!")
    self.super:init(dropParams)
    self.x = math.random(self.offsetX, ScreenSize.screenWidth - self.offsetX)
    self.y = - self.h
    self.movement = MovementManager.getMovement(dropParams.movementType)
    self.params = dropParams
end

function Drop:reset()
    self.x = math.random( self.offsetX, ScreenSize.screenWidth - self.offsetX)
    self.y = - self.h
end

function Drop:update(dt)  
    self.x, self.y = self.movement:update(dt, self.speed, self.x, self.y)
end

return Drop