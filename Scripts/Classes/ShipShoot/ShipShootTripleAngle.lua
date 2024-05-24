local classes = require("Scripts/Classes/classes")
local ShipShootBaseCls = require("Scripts/Classes/ShipShoot/ShipShootBase")

local ShipShootTripleAngle = classes.class(ShipShootBaseCls)

local direction = math.sin(1)
local angle = math.pi / 4
local offset = 4


function ShipShootTripleAngle:shoot(bulletType, x, y)
  
    if self.super.isReadyToShoot(self) then
      
        local bullet
        bullet = self.bulletObjectPool:spawn(bulletType)
        bullet:setPositionAndVector(x - offset, y, -direction, -direction, -angle)
        table.insert(self.spawnedBullets, bullet)
        
        bullet = self.bulletObjectPool:spawn(bulletType)
        bullet:setPositionAndVector(x, y, 0, -1)
        table.insert(self.spawnedBullets, bullet)
        
        bullet = self.bulletObjectPool:spawn(bulletType)
        bullet:setPositionAndVector(x + offset, y, direction, -direction, angle)
        table.insert(self.spawnedBullets, bullet)
    end
end

return ShipShootTripleAngle