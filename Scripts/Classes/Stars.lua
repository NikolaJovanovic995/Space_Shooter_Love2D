local ScreenSize = require("Scripts/Models/ScreenSize")

local Stars = classes.class()

function Stars:init(params)
  
    print("Stars init!")
    self.speed = params.speed
    self.radius = params.radius
    self.starsArr = {}
    
    for i=1, params.numStars do
        local x = math.random() * ScreenSize.screenWidth
        local y = math.random() * ScreenSize.screenHeight
        local star = {x = x, y = y}
        table.insert(self.starsArr, star)
    end
    
end


function Stars:update(dt)
  
    for i, star in ipairs(self.starsArr) do
        local y = star.y + self.speed * dt
        
        if y > ScreenSize.screenHeight then
          y = 0
          star.x = math.random() * ScreenSize.screenWidth
        end
        star.y = y
    end
end

function Stars:draw()
  
    love.graphics.setColor(1, 1, 1)
    local radius = self.radius
    local numStars = self.numStars
    
    for i, star in ipairs(self.starsArr) do
        love.graphics.circle("fill", star.x, star.y, radius) -- Draw white circle with 100 segments.
    end
end

return Stars