local classes = require("Scripts/Classes/classes")
local Model = require("Scripts/Models/Model")
local Explosions = classes.class()

math.randomseed(os.clock())

function Explosions:init(explosionsParams)
    print("Explosions init!")
    
    self.asset = explosionsParams.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.offsetX = self.w / 2
    self.offsetY = self.h / 2
    
    
    self.duration = explosionsParams.duration
    self.spawnedExplosions = {}
    
end

function Explosions:update(dt)  
  
    for index, value in ipairs(self.spawnedExplosions) do
        value.timer = value.timer + dt
        if value.timer > self.duration then
            table.remove(self.spawnedExplosions, index)
            break
        end
    end

end

function Explosions:draw()
  
    for index, value in ipairs(self.spawnedExplosions) do
        love.graphics.draw(self.asset, value.x - self.offsetX, value.y - self.offsetY)
    end
end

function Explosions:spawnExplosion(x, y)
    table.insert(self.spawnedExplosions, { x = x, y = y, timer = 0} )
end


return Explosions