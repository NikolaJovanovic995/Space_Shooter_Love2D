local classes = require("Scripts/Classes/classes")
local Model = require("Scripts/Models/Model")
local Bullets = classes.class()

function Bullets:init(bulletParams)
    print("Bullets init!")
    
    self.asset = bulletParams.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.offsetX = self.w / 2
    self.offsetY = self.h / 2
    self.fireRate = bulletParams.fireRate
    self.fireTime = bulletParams.fireRate
    self.speed = bulletParams.speed
    self.damage = bulletParams.damage
    self.spawnedBullets = {}     
        
end

function Bullets:update(dt)  
  
    self.fireTime = self.fireTime + dt
    
    for i, bullet in ipairs(self.spawnedBullets) do
        bullet.y = bullet.y - self.speed * dt
    end
    
    for i, bullet in ipairs(self.spawnedBullets) do
        if bullet.y + self.offsetY < 0 then
            table.remove(self.spawnedBullets, i)
            break
        end
    end
end

function Bullets:draw()
  
    for i, bullet in ipairs(self.spawnedBullets) do
        love.graphics.draw(self.asset, bullet.x - self.offsetX, bullet.y - self.offsetY)
    end
end

function Bullets:fireBullet(x, y)
    if self.fireTime > self.fireRate then
        table.insert(self.spawnedBullets, { x = x, y = y, damage = self.damage } )
        self.fireTime = 0
    end
end

function Bullets:explode(index)
    table.remove(self.spawnedBullets, i)
end

return Bullets