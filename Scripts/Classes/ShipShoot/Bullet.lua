local classes = require("Scripts/Classes/classes")
local Model = require("Scripts/Models/Model")
local ScreenObject = require("Scripts/Classes/ScreenObject")

local Bullet = classes.class(ScreenObject)

local stageWidth = nil
local stageHeight = nil

function Bullet:init(params)
    print("Bullet init!")
    
    self.super:init(params)
    
    stageWidth = Model.stage.stageWidth
    stageHeight = Model.stage.stageHeight
    
    self.bulletType = params.bulletType
    self.x = 0
    self.y = 0
    self.speed = params.speed
    self.fireRate = params.fireRate
    self.damage = params.damage
    
end

function Bullet:reset()
    
    
end

function Bullet:update(dt)  

end

function Bullet:someMethod(dt)  
  
end


return Bullet
