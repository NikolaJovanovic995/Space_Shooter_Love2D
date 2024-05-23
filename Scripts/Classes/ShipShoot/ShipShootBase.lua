local classes = require("Scripts/Classes/classes")
local BulletCls = require("Scripts/Classes/ShipShoot/Bullet")
local ShipShootBase = classes.class()

function ShipShootBase:init(params)
    
    self.fireRate = params.fireRate
    self.fireTime = params.fireRate
    self.speed = params.speed
    self.damage = params.damage
    self.spawnedBullets = {}     
end

function ShipShootBase.update(self, dt)  
  
    self.fireTime = self.fireTime + dt
    
    for i, bullet in ipairs(self.spawnedBullets) do
        bullet:update(dt)
    end
    --[[
    for i, bullet in ipairs(self.spawnedBullets) do
        if bullet.y + self.offsetY < 0 then
            table.remove(self.spawnedBullets, i)
            break
        end
    end]]
end

function ShipShootBase:draw()
  
    for i, bullet in pairs(self.spawnedBullets) do
        bullet:draw()
    end
end

function ShipShootBase:isReadyToShoot()
    if self.fireTime > self.fireRate then
        self.fireTime = 0
        return true
    end
    return false
end

function ShipShootBase:bulletHit(index)
    table.remove(self.spawnedBullets, index)
end

return ShipShootBase