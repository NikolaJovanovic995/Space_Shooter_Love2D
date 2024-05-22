local ShipShootSingleCls = require("Scripts/Classes/ShipShoot/ShipShootSingle")
local ShipShootTripleCls = require("Scripts/Classes/ShipShoot/ShipShootTriple")
local ShipShootTripleAngleCls = require("Scripts/Classes/ShipShoot/ShipShootTripleAngle")

local ShipShootingManager = {}

ShipShootingManager.getShooting = function(shootType) 
  
    if shootType == "single" then
        return ShipShootSingleCls.new()
    elseif shootType == "triple" then
        return ShipShootTripleCls.new()
    elseif shootType == "triple" then
        return ShipShootTripleAngleCls.new()
    else
        error("Can not resolve ship shoot type: " .. shootType)
    end
end


return ShipShootingManager