local ShootingModel = require("Scripts/Models/ShootingModel")
local ObjectPoolCls = require("Scripts/Classes/ObjectPool")
local BulletCls = require("Scripts/Classes/ShipShoot/Bullet")
local BulletObjectPool = nil

local ShipShootSingleCls = require("Scripts/Classes/ShipShoot/ShipShootSingle")
local ShipShootTripleCls = require("Scripts/Classes/ShipShoot/ShipShootTriple")
local ShipShootTripleAngleCls = require("Scripts/Classes/ShipShoot/ShipShootTripleAngle")

local ShipShootingManager = {}
local shootingTypes = {}

local activeShooting = nil

ShipShootingManager.init = function()
  
    ShootingModel.init()
    activeShooting = nil
    BulletObjectPool = ObjectPoolCls.new(
      {
          objectClass = BulletCls,
          objectConfigs = ShootingModel.bulletsParams
      })
    shootingTypes = {
        single = ShipShootSingleCls.new(ShootingModel.shootingParams["single"], BulletSpawner),
        triple = ShipShootTripleCls.new(ShootingModel.shootingParams["triple"], BulletSpawner),
        tripleAngle = ShipShootTripleAngleCls.new(ShootingModel.shootingParams["tripleAngle"], BulletSpawner)
    }
end

ShipShootingManager.getShooting = function(shootType) 
    
    local shooting = shootingTypes[shootType]
    if shooting == nil then
        error("Can not resolve ship shoot type: " .. shootType)
    end
    
    shooting.bulletObjectPool = BulletObjectPool
    shooting.spawnedBullets = activeShooting and activeShooting.spawnedBullets or {}
    activeShooting = shooting
    return shooting
end

return ShipShootingManager