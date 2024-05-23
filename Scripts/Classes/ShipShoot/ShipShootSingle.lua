local classes = require("Scripts/Classes/classes")
local ShipShootBaseCls = require("Scripts/Classes/ShipShoot/ShipShootBase")

local ShipShootSingle = classes.class(ShipShootBaseCls)


function ShipShootSingle:init(params)
    self.super:init(params)
end

function ShipShootSingle:update(dt, speed, x, y)
  
end


return ShipShootSingle