local classes = require("Scripts/Classes/classes")
local ShipShootBase = classes.class()

function ShipShootBase:init(params)
    
    self.fireRate = params.fireRate
    self.fireTime = params.fireRate
    self.speed = params.speed
    self.damage = params.damage
    self.spawnedBullets = {}     
end

function ShipShootBase:update(dt)  
  
    self.fireTime = self.fireTime + dt
    
    for i, bullet in ipairs(self.spawnedBullets) do
        bullet:update(dt)
    end
    
    for i, bullet in ipairs(self.spawnedBullets) do
        if bullet.y + self.offsetY < 0 then
            table.remove(self.spawnedBullets, i)
            break
        end
    end
end

function ShipShootBase:draw()
  
    for i, bullet in ipairs(self.spawnedBullets) do
        bullet:draw()
    end
end

function ShipShootBase:shoot(x, y)
    if self.fireTime > self.fireRate then
        table.insert(self.spawnedBullets, { x = x, y = y, damage = self.damage } )
        self.fireTime = 0
    end
end

function ShipShootBase:explode(index)
    table.remove(self.spawnedBullets, i)
end

return ShipShootBase