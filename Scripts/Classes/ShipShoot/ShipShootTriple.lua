local classes = require("Scripts/Classes/classes")
local ShipShootBaseCls = require("Scripts/Classes/ShipShoot/ShipShootBase")

local ShipShootTriple = classes.class(ShipShootBaseCls)

local offset = 10

function ShipShootTriple:shoot(bulletType, x, y)
  
    if self.super.isReadyToShoot(self) then
      
        local bullet
        
        bullet = self.bulletObjectPool:spawn(bulletType)
        bullet:setPositionAndVector(x - offset, y, 0, -1)
        table.insert(self.spawnedBullets, bullet)
        
        bullet = self.bulletObjectPool:spawn(bulletType)
        bullet:setPositionAndVector(x, y, 0, -1)
        table.insert(self.spawnedBullets, bullet)
        
        bullet = self.bulletObjectPool:spawn(bulletType)
        bullet:setPositionAndVector(x + offset, y, 0, -1)
        table.insert(self.spawnedBullets, bullet)
    end
end

return ShipShootTriple