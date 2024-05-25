local classes = require("Scripts/Classes/classes")
local ScreenSize = require("Scripts/Models/ScreenSize")
local UserInput = require("Scripts/Models/UserInput")
local ShipShootingManager = require("Scripts/Managers/ShipShootingManager")
local MathUtil = require("Scripts/Utils/MathUtil")
local ScreenObject = require("Scripts/Classes/ScreenObject")
local AssetsManager = require("Scripts/Managers/AssetsManager")

local Ship = classes.class(ScreenObject)

local DEFAULT_BULLET = "bullet"
local DEFAULT_SHOOTING = "single"

function Ship:init(params)
    print("Ship init!")
    
    self.super:init(params)
    
    self.health = params.health
    self.speed = params.speed
    self.score = 0
    self.x = ScreenSize.screenWidth / 2
    self.y = ScreenSize.screenHeight * 3 / 4
    self.rightBoundry = ScreenSize.screenWidth - self.offsetX
    self.bottomBoundry = ScreenSize.screenHeight - self.offsetY
    self.activePowerups = {}
    
    ShipShootingManager.init()
    Ship:setShootingType(DEFAULT_SHOOTING)
end

function Ship:update(dt)

    local x = 0
    local y = 0

    if UserInput.left then
        x = x - 1 
    end
    if UserInput.right then
        x = x + 1
    end

    if UserInput.up then
        y = y - 1
    end
    if UserInput.down then
        y = y + 1
    end

    self.x = MathUtil.clamp(self.x + (x * self.speed * dt), self.offsetX, self.rightBoundry)
    self.y = MathUtil.clamp(self.y + (y * self.speed * dt), self.offsetY, self.bottomBoundry)
    
    
    if UserInput.space then
        self.shooting:shoot(DEFAULT_BULLET, self.x, self.y - self.offsetY)
    end
    
    self.shooting:update(dt)
    
    for i, powerup in ipairs(self.activePowerups) do
        powerup.params.duration = powerup.params.duration - dt  
        if powerup.params.duration < 0 then
            Ship:disablePowerup(powerup)
            table.remove(self.activePowerups, i)
            break
        end
    end
end

function Ship:draw()
    self.super.draw(self)
    self.shooting:draw()
    
    for i, powerup in ipairs(self.activePowerups) do
        love.graphics.draw(powerup.asset, 20, ScreenSize.screenHeight - 20, powerup.rotation, 1, 1, powerup.offsetX, powerup.offsetY)
        love.graphics.print(tostring(math.ceil(powerup.params.duration)), 40, ScreenSize.screenHeight - 30)
    end
end

function Ship:makeDamage(damage)
    self.health = self.health - damage
    return self.health <= 0
end

function Ship:consumeDrop(drop)
    print("Consumed drop: " .. drop.params.dropType)
    local effect = drop.params.effect 
    if effect == "health" then
        self.health = self.health + drop.params.amount
    elseif effect == "points" then
        self.score = self.score + drop.params.amount
    elseif effect == "shooting" then
        Ship:setShootingType(drop.params.shootingType)
        table.insert(self.activePowerups, drop)
    end
end

function Ship:disablePowerup(powerup)
    local effect = powerup.params.effect 
    if effect == "shooting" then
        Ship:setShootingType(DEFAULT_SHOOTING)
    end
end

function Ship:setShootingType(shootingType)
    self.shooting = ShipShootingManager.getShooting(shootingType)
end


return Ship