local classes = require("Scripts/Classes/classes")
local ScreenSize = require("Scripts/Models/ScreenSize")
local UserInput = require("Scripts/Models/UserInput")
local ShipShootingManager = require("Scripts/Managers/ShipShootingManager")
local MathUtil = require("Scripts/Utils/MathUtils")
local ScreenObject = require("Scripts/Classes/ScreenObject")
local AssetsManager = require("Scripts/Managers/AssetsManager")

local Ship = classes.class(ScreenObject)
local bulletType = "bullet"

function Ship:init(params)
    print("Ship init!")
    
    self.super:init(params)
    
    self.health = params.health
    self.speed = params.speed
    self.x = ScreenSize.screenWidth / 2
    self.y = ScreenSize.screenHeight * 3 / 4
    self.rightBoundry = ScreenSize.screenWidth - self.offsetX
    self.bottomBoundry = ScreenSize.screenHeight - self.offsetY
    
    ShipShootingManager.init()
    self.shooting = ShipShootingManager.getShooting("tripleAngle")
end

function Ship:update(dt)

    local x = 0
    local y = 0

    if UserInput.left then
        x = x + -1
    end
    if UserInput.right then
        x = x + 1
    end

    if UserInput.up then
        y = y + -1
    end
    if UserInput.down then
        y = y + 1
    end

    self.x = MathUtil.clamp(self.x + (x * self.speed * dt), self.offsetX, self.rightBoundry)
    self.y = MathUtil.clamp(self.y + (y * self.speed * dt), self.offsetY, self.bottomBoundry)
    
    
    if UserInput.space then
        self.shooting:shoot(bulletType, self.x, self.y - self.offsetY)
    end
    
    self.shooting:update(dt)
end

function Ship:draw()
    self.super.draw(self)
    self.shooting:draw()
end

function Ship:makeDamage(damage)
    self.health = self.health - damage
    return self.health <= 0
end


return Ship