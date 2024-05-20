local classes = require("classes")
local Ship = classes.class()
local Model = require("Model")
local Bullets = require("Bullets")

require "mathUtil"

function Ship:init(params)
    print("Ship init!")
    self.speed = params.speed
    self.asset = params.asset
    self.x = Model.stage.stageWidth / 2
    self.y = Model.stage.stageHeight * 3 / 4
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.leftBoundry = self.asset:getWidth() / 2
    self.rightBoundry = Model.stage.stageWidth - self.asset:getWidth() / 2
    self.topBoundry = self.asset:getHeight() / 2
    self.bottomBoundry = Model.stage.stageHeight - self.asset:getHeight() / 2
    self.bulletOffsetY = self.topBoundry
    
    self.bullets = params.bullets
    
end

function Ship:update(dt)

    local left = Model.movement.left
    local right = Model.movement.right
    local up = Model.movement.up
    local down = Model.movement.down
    local shoot = Model.movement.space

    local x = 0
    local y = 0

    if left then
        x = x + -1
    end
    if right then
        x = x + 1
    end

    if up then
        y = y + -1
    end
    if down then
        y = y + 1
    end

    self.x = clamp(self.x + (x * self.speed * dt), self.leftBoundry, self.rightBoundry)
    self.y = clamp(self.y + (y * self.speed * dt), self.topBoundry, self.bottomBoundry)
    
    
    if shoot then
        self.bullets.fireBullet(self.x, self.y - self.bulletOffsetY)
    end

end

function Ship:draw()
    local newX = self.x - (self.w/2)
    local newY = self.y - (self.h/2)
    love.graphics.draw(self.asset, newX,newY )
end


return Ship