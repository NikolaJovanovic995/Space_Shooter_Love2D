local classes = require("Scripts/Classes/classes")
local ScreenSize = require("Scripts/Models/ScreenSize")
local ScreenObject = require("Scripts/Classes/ScreenObject")
local MovementManager = require("Scripts/Managers/MovementManager")

local Enemy = classes.class(ScreenObject)

math.randomseed(os.clock())

function Enemy:init(params)
    print("Enemy init!")
    
    self.super:init(params)
    
    self.movement = MovementManager.getMovement(params.movementType)
    self.enemyType = params.enemyType
    self.x = math.random( self.offsetX, ScreenSize.screenWidth - self.offsetX)
    self.y = - self.h
    self.speed = params.speed
    self.health = params.health
    self.startingHealth = params.health
    self.impactDamage = params.impactDamage
    self.pointsValue = params.pointsValue
    
end

function Enemy:reset(params)
    self.x = math.random( self.offsetX, ScreenSize.screenWidth - self.offsetX)
    self.y = - self.h
    self.health = self.startingHealth
end

function Enemy:update(dt)  
    self.x, self.y = self.movement:update(dt, self.speed, self.x, self.y)
end

function Enemy:makeDamage(index, damage)
  
    self.health = self.health - damage
    if self.health <= 0 then
        return true
    else
        return false
    end
end

return Enemy