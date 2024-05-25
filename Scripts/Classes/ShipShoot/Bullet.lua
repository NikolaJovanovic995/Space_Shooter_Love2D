local classes = require("Scripts/Classes/classes")
local ScreenObject = require("Scripts/Classes/ScreenObject")

local Bullet = classes.class(ScreenObject)

function Bullet:init(params)
    self.super:init(params)
    
    self.bulletType = params.bulletType
    self.speed = params.speed
    self.fireRate = params.fireRate
    self.damage = params.damage
end

function Bullet:setPositionAndVector(x , y, dx, dy, r)
    self.x = x
    self.y = y
    self.dx = dx
    self.dy = dy
    self.rotation = r or 0
end

function Bullet:reset()
end

function Bullet:update(dt)  
    local dist = dt * self.speed
    self.x = self.x + dist * self.dx
    self.y = self.y + dist * self.dy
end

return Bullet