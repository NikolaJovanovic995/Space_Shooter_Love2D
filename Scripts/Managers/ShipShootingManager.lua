local Model = require("Scripts/Models/Model")

local ShipShootSingleCls = require("Scripts/Classes/ShipShoot/ShipShootSingle")
local ShipShootTripleCls = require("Scripts/Classes/ShipShoot/ShipShootTriple")
local ShipShootTripleAngleCls = require("Scripts/Classes/ShipShoot/ShipShootTripleAngle")

local ShipShootingManager = {}

ShipShootingManager.getShooting = function(shootType) 
  
    local shooting = ShipShootingManager.shootingTypes[shootType]
    
    if shooting == nil then
        error("Can not resolve ship shoot type: " .. shootType)
    end
    
    return shooting
end


ShipShootingManager.shootingTypes = {
  
      single = ShipShootSingleCls.new(Model.shootingParams["single"])
      --triple = ShipShootTripleCls.new(Model.shootingParams["tripple"]),
      --tripleAngle = ShipShootTripleAngleCls.new(Model.shootingParams["trippleAngle"])
}

return ShipShootingManager