local classes = require("Scripts/Classes/classes")
local Model = require("Scripts/Models/Model")
local Effects = classes.class()

math.randomseed(os.clock())

function Effects:init(explosionsParams)
    print("Effects init!")
    
    self.asset = explosionsParams.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.offsetX = self.w / 2
    self.offsetY = self.h / 2
    
    self.duration = explosionsParams.duration
    self.spawnedExplosions= {}
    self.spawnedIndicators= {}
    
end

function Effects:update(dt)  
  
    self.updateTimers(dt, self.spawnedExplosions, self.duration)  
    self.updateTimers(dt, self.spawnedIndicators, self.duration * 4)  
end

function Effects:draw()
  
    for index, value in ipairs(self.spawnedExplosions) do
        love.graphics.draw(self.asset, value.x - self.offsetX, value.y - self.offsetY)
    end
    
    for index, value in ipairs(self.spawnedIndicators) do
        love.graphics.printf(tostring(value.damage), value.x, value.y, 50)
    end
end

function Effects:spawnExplosion(x, y, dmg)
    table.insert(self.spawnedExplosions, { x = x, y = y, timer = 0} )
    Effects.spawnDamageIndicator(self, x, y, dmg)
end

function Effects:spawnDamageIndicator(x, y, dmg)
    
    table.insert(self.spawnedIndicators, { 
        x = x + math.random(-10, 10), 
        y = y + math.random(-10, 10),  
        timer = 0,
        damage = dmg  
    })
end

function Effects.updateTimers(dt, list, duration)  
  
    for index, value in ipairs(list) do
        value.timer = value.timer + dt
        if value.timer > duration then
            table.remove(list, index)
            break
        end
    end
end


return Effects