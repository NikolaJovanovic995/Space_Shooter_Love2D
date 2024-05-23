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
    
    self.movement = EnemyMoveManager.getMovement(params.movementType)
    self.enemyType = params.enemyType
    self.x = math.random( self.offsetX, stageWidth - self.offsetX)
    self.y = - self.h
    self.speed = params.speed
    self.health = params.health
    self.impactDamage = params.impactDamage
    self.pointsValue = params.pointsValue
    
end

function Bullet:reset()
    
    
end

function Bullet:update(dt)  
    --x,y
end


return Bullet
