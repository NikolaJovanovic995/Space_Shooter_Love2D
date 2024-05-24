local BulletCls = require("Scripts/Classes/ShipShoot/Bullet")

local BulletSpawner = {}

local bulletsConfig = {}
local bulletsPool = {}

BulletSpawner.init = function(params)
    bulletsConfig = params
end

BulletSpawner.spawn = function(bulletType)
    if bulletsPool[bulletType] == nil or #bulletsPool[bulletType] == 0 then
        print("No bullets in pool of type: " .. bulletType)
        return BulletCls.new(bulletsConfig[bulletType])
    else
        print("Get bullets from pool of type: " .. bulletType)
        local bullet = table.remove(bulletsPool[bulletType])
        bullet:reset()
        return bullet
    end
end

BulletSpawner.despawn = function(bullet)
  
    if bulletsPool[bullet.bulletType] == nil then
        print("Create new table in pool for bullet type: " .. bullet.bulletType)
        bulletsPool[bullet.bulletType] = {}
    end
    
    print("Return bullet in pool for bullet type: ".. bullet.bulletType)
    table.insert(bulletsPool[bullet.bulletType], bullet)
end

return BulletSpawner