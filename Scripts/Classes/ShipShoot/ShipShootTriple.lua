local classes = require("Scripts/Classes/classes")
local ShipShootBaseCls = require("Scripts/Classes/ShipShoot/ShipShootBase")

local ShipShootTriple = classes.class(ShipShootBaseCls)

function ShipShootTriple:shoot(bulletType, x, y)
  
    if self.super.isReadyToShoot(self) then
      
        local bullet
        
        bullet = self.bulletSpawner.spawn(bulletType)
        bullet:setPositionAndVector(x - 10, y, 0, -1)
        table.insert(self.spawnedBullets, bullet)
        
        bullet = self.bulletSpawner.spawn(bulletType)
        bullet:setPositionAndVector(x, y, 0, -1)
        table.insert(self.spawnedBullets, bullet)
        
        bullet = self.bulletSpawner.spawn(bulletType)
        bullet:setPositionAndVector(x + 10, y, 0, -1)
        table.insert(self.spawnedBullets, bullet)
        
        print("Spawn triple bullet")
    end
end

return ShipShootTriple