local ScreenSize = require("Scripts/Models/ScreenSize")
math.randomseed(os.clock())
local Stars = classes.class()

function Stars:init(params)
  
    print("Stars init!")
    self.speed = params.speed
    self.radius = params.radius
    self.starsArr = {}
    
    for i=1, params.numStars do
        table.insert(self.starsArr, { x = math.random() * ScreenSize.screenWidth, y = math.random() * ScreenSize.screenHeight })
    end
end

function Stars:update(dt)
    local dist = self.speed * dt
    local star = nil
    local newY = 0
    for i=1, #self.starsArr do
        star = self.starsArr[i]
        newY = star.y + dist
        if newY > ScreenSize.screenHeight then
          newY = 0
          star.x = math.random() * ScreenSize.screenWidth
        end
        star.y = newY
    end
end

function Stars:draw()
  
    love.graphics.setColor(1, 1, 1)
    local star = nil
    for i=1, #self.starsArr do
        star = self.starsArr[i]
        love.graphics.circle("fill", star.x, star.y, self.radius) -- Draw white circle with 100 segments.
    end
end

return Stars