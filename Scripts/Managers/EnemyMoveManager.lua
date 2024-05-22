local MoveStraightCls = require("Scripts/Classes/EnemyMoveStraight")
local MoveSinCls = require("Scripts/Classes/EnemyMoveSin")

local EnemyMoveManager = {}

EnemyMoveManager.getMovement = function(movementType) 
  
    if movementType == "straight" then
        return MoveStraightCls.new()
    elseif movementType == "sin" then
        return MoveSinCls.new()
    else
        error("Can not resolve enemy movement type: " .. movementType)
    end
end


return EnemyMoveManager