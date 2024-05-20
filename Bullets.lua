local classes = require("classes")
local Bullets = classes.class()
local Model = require("Model")

function Bullets:init(bulletParams)
    print("Bullets init!")
    
    self.asset = bulletParams.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.radius = self.h / 2
    self.offsetX = self.w / 2
    self.offsetY = self.h / 2
    self.fireRate = bulletParams.fireRate
    self.fireTime = bulletParams.fireRate
    self.speed = bulletParams.speed
    self.bullets = {}
    self.bulletsCount = 0
    
    self.fireBullet = function (x, y)
      
        if self.fireTime > self.fireRate then
            self.bulletsCount = self.bulletsCount + 1
            table.insert(self.bullets, { x = x - self.offsetX, y = y - self.offsetY } )
            self.fireTime = 0
        end
    end
end

function Bullets:update(dt)  
    self.fireTime = self.fireTime + dt
    for i=1, #self.bullets do
        local bullet = self.bullets[i]
        bullet.y = bullet.y - self.speed * dt
    end
    
    for i=1, #self.bullets do
        local bullet = self.bullets[i]
        if bullet.y < 0 then
            table.remove(self.bullets, i)
            self.bulletsCount = self.bulletsCount - 1
            break
        end
    end
    
end

function Bullets:draw()
  
    for i=1, #self.bullets do
        local bullet = self.bullets[i]
        love.graphics.draw(self.asset, bullet.x, bullet.y)
    end
end

return Bullets