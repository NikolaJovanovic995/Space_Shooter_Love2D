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
    for i=1, #self.starsArr do
        self.starsArr[i].y = self.starsArr[i].y + dist > ScreenSize.screenHeight and 0 or self.starsArr[i].y + dist
    end
end

function Stars:draw()
  
    love.graphics.setColor(1, 1, 1)
    for i=1, #self.starsArr do
        love.graphics.circle("fill", self.starsArr[i].x, self.starsArr[i].y, self.radius) -- Draw white circle with 100 segments.
    end
end

return Stars