local MoveStraightCls = require("Scripts/Classes/Movement/MoveStraight")
local MoveSinCls = require("Scripts/Classes/Movement/MoveSin")

local MovementManager = {}

MovementManager.getMovement = function(movementType) 
  
    if movementType == "straight" then
        return MoveStraightCls.new()
    elseif movementType == "sin" then
        return MoveSinCls.new()
    else
        error("Can not resolve movement type: " .. movementType)
    end
end


return MovementManager