local classes = require("Scripts/Classes/classes")
local SoundManager = require("Scripts/Managers/SoundManager")
local BulletCls = require("Scripts/Classes/ShipShoot/Bullet")
local ShipShootBase = classes.class()

function ShipShootBase:init(params)
    
    self.fireRate = params.fireRate
    self.fireTime = params.fireRate
    self.speed = params.speed
    self.damage = params.damage
    
    self.bulletObjectPool = {}
    self.spawnedBullets = {}     
end

function ShipShootBase.update(self, dt)  
  
    self.fireTime = self.fireTime + dt
    
    for i, bullet in ipairs(self.spawnedBullets) do
        bullet:update(dt)
    end
    
    for i, bullet in ipairs(self.spawnedBullets) do
        if bullet.y + bullet.offsetY < 0 then
            local bullet = table.remove(self.spawnedBullets, i)
            self.bulletObjectPool:despawn(bullet, bullet.bulletType)
            break
        end
    end
end

function ShipShootBase:draw()
  
    for i, bullet in pairs(self.spawnedBullets) do
        bullet:draw()
    end
end

function ShipShootBase:isReadyToShoot()
    if self.fireTime > self.fireRate then
        self.fireTime = 0
        SoundManager.sounds.playerShoot:play()
        return true
    end
    return false
end

function ShipShootBase:bulletHit(index)
    local bullet = table.remove(self.spawnedBullets, index)
    self.bulletObjectPool:despawn(bullet, bullet.bulletType)
end

return ShipShootBase