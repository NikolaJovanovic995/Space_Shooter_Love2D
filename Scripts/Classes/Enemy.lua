local classes = require("Scripts/Classes/classes")
local Model = require("Scripts/Models/Model")
local ScreenObject = require("Scripts/Classes/ScreenObject")
local EnemyMoveManager = require("Scripts/Managers/EnemyMoveManager")

local Enemy = classes.class(ScreenObject)

local stageWidth = nil
local stageHeight = nil
math.randomseed(os.clock())

function Enemy:init(params)
    print("Enemy init!")
    
    self.super:init(params)
    
    stageWidth = Model.stage.stageWidth
    stageHeight = Model.stage.stageHeight
    self.movement = EnemyMoveManager.getMovement(params.movementType)
    self.enemyType = params.enemyType
    self.x = math.random( self.offsetX, stageWidth - self.offsetX)
    self.y = - self.h
    self.speed = params.speed
    self.health = params.health
    self.impactDamage = params.impactDamage
    self.pointsValue = params.pointsValue
    
end

function Enemy:reset()
    self.x = math.random( self.offsetX, stageWidth - self.offsetX)
    self.y = - self.h
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