local Model = require("Scripts/Models/Model")
local ObjectPoolCls = require("Scripts/Classes/ObjectPool")
local BulletCls = require("Scripts/Classes/ShipShoot/Bullet")
local BulletObjectPool = nil

local ShipShootSingleCls = require("Scripts/Classes/ShipShoot/ShipShootSingle")
local ShipShootTripleCls = require("Scripts/Classes/ShipShoot/ShipShootTriple")
local ShipShootTripleAngleCls = require("Scripts/Classes/ShipShoot/ShipShootTripleAngle")

local ShipShootingManager = {}

ShipShootingManager.init = function()
    BulletObjectPool = ObjectPoolCls.new(
      {
          objectClass = BulletCls,
          objectConfigs = Model.bulletsParams
      })
end

ShipShootingManager.getShooting = function(shootType) 
  
    local shooting = ShipShootingManager.shootingTypes[shootType]
    
    if shooting == nil then
        error("Can not resolve ship shoot type: " .. shootType)
    end
    
    shooting.bulletObjectPool = BulletObjectPool
    return shooting
end


ShipShootingManager.shootingTypes = {
  
      single = ShipShootSingleCls.new(Model.shootingParams["single"], BulletSpawner),
      triple = ShipShootTripleCls.new(Model.shootingParams["triple"], BulletSpawner),
      tripleAngle = ShipShootTripleAngleCls.new(Model.shootingParams["tripleAngle"], BulletSpawner)
}

return ShipShootingManager