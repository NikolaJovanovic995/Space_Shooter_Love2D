local classes = require("Scripts/Classes/classes")
local Model = require("Scripts/Models/Model")
local Bullets = require("Scripts/Classes/Bullets")
local MathUtil = require("Scripts/Utils/MathUtils")
local AssetsManager = require("Scripts/Managers/AssetsManager")

local Ship = classes.class()

function Ship:init(params)
    print("Ship init!")
    self.health = params.health
    self.speed = params.speed
    self.asset = params.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.x = Model.stage.stageWidth / 2
    self.y = Model.stage.stageHeight * 3 / 4
    self.offsetX = self.w / 2
    self.offsetY = self.h / 2
    self.rightBoundry = Model.stage.stageWidth - self.offsetX
    self.bottomBoundry = Model.stage.stageHeight - self.offsetY
    
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

    self.x = MathUtil.clamp(self.x + (x * self.speed * dt), self.offsetX, self.rightBoundry)
    self.y = MathUtil.clamp(self.y + (y * self.speed * dt), self.offsetY, self.bottomBoundry)
    
    
    if shoot then
        self.bullets:fireBullet(self.x, self.y - self.offsetY)
        AssetsManager.sounds.playerShoot:play()
    end

end

function Ship:draw()
    love.graphics.draw(self.asset, self.x - self.offsetX, self.y - self.offsetY)
end

function Ship:makeDamage(damage)
    self.health = self.health - damage
    return self.health <= 0
end


return Ship