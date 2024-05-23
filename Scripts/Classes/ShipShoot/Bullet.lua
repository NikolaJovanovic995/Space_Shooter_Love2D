local classes = require("Scripts/Classes/classes")
local Model = require("Scripts/Models/Model")
local ScreenObject = require("Scripts/Classes/ScreenObject")

local Bullet = classes.class(ScreenObject)

local stageWidth = nil
local stageHeight = nil

function Bullet:init(params)
    print("Bullet init!")
    
    self.super:init(params)
    
    stageWidth = Model.stage.stageWidth
    stageHeight = Model.stage.stageHeight
    
    self.bulletType = params.bulletType
    
    self.speed = params.speed
    self.fireRate = params.fireRate
    self.damage = params.damage
    
end

function Bullet:setPositionAndVector(x , y, dx, dy)
    
    self.x = x
    self.y = y
    self.dx = dx
    self.dy = dy
    
end

function Bullet:reset()
end

function Bullet:update(dt)  
    local dist = dt * self.speed
    self.x = self.x + dist * self.dx
    self.y = self.y + dist * self.dy
end

return Bullet