local classes = require("Scripts/Classes/classes")
local ShipShootBaseCls = require("Scripts/Classes/ShipShoot/ShipShootBase")
--local BulletCls = require("Scripts/Classes/Bullet")

local ShipShootSingle = classes.class(ShipShootBaseCls)


function ShipShootSingle:init(params)
    self.super:init(params)
end

function ShipShootSingle:update(dt)
    self.super.update(self, dt)
end

function ShipShootSingle:shoot(bulletType, x, y)
    if self.super.isReadyToShoot(self) then
        local bullet = self.bulletSpawner.spawn(bulletType)
        table.insert(self.spawnedBullets, bullet )
        print("Spawn single bullet")
    end
end


return ShipShootSingle