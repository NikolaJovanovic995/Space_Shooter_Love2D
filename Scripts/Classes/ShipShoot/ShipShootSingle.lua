local classes = require("Scripts/Classes/classes")
local ShipShootBaseCls = require("Scripts/Classes/ShipShoot/ShipShootBase")

local ShipShootSingle = classes.class(ShipShootBaseCls)

function ShipShootSingle:shoot(bulletType, x, y)
  
    if self.super.isReadyToShoot(self) then
      
        local bullet = self.bulletObjectPool:spawn(bulletType)
        bullet:setPositionAndVector(x, y, 0, -1)
        table.insert(self.spawnedBullets, bullet )
    end
end

return ShipShootSingle