local classes = require("Scripts/Classes/classes")
local Model = require("Scripts/Models/Model")
local EnemyMoveManager = require("Scripts/Managers/EnemyMoveManager")
local Enemy = classes.class()

local stageWidth = nil
local stageHeight = nil
math.randomseed(os.clock())

function Enemy:init(params)
    print("Enemy init!")
    
    stageWidth = Model.stage.stageWidth
    stageHeight = Model.stage.stageHeight
    self.movement = EnemyMoveManager.getMovement(params.movementType)
    
    self.asset = params.asset
    self.enemyType = params.enemyType
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.offsetX = self.w / 2
    self.offsetY = self.h / 2
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

function Enemy:draw()
    love.graphics.draw(self.asset, self.x - self.offsetX, self.y - self.offsetY)
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