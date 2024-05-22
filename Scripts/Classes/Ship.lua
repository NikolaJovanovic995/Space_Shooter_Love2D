local classes = require("Scripts/Classes/classes")
local Model = require("Scripts/Models/Model")
local ShipShootingManager = require("Scripts/Managers/ShipShootingManager")
local MathUtil = require("Scripts/Utils/MathUtils")
local ScreenObject = require("Scripts/Classes/ScreenObject")
local AssetsManager = require("Scripts/Managers/AssetsManager")

local Ship = classes.class(ScreenObject)

function Ship:init(params)
    print("Ship init!")
    
    self.super:init(params)
    
    self.health = params.health
    self.speed = params.speed
    self.x = Model.stage.stageWidth / 2
    self.y = Model.stage.stageHeight * 3 / 4
    self.rightBoundry = Model.stage.stageWidth - self.offsetX
    self.bottomBoundry = Model.stage.stageHeight - self.offsetY
    
    self.shooting = ShipShootingManager.getShooting("single")
    self.spawnedBullets = {}
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
        self.shooting:shoot()
        --self.bullets:fireBullet(self.x, self.y - self.offsetY)
        AssetsManager.sounds.playerShoot:play()
    end

end

function Ship:makeDamage(damage)
    self.health = self.health - damage
    return self.health <= 0
end


return Ship