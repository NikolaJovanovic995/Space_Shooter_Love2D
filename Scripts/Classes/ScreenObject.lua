local classes = require("Scripts/Classes/classes")
local ScreenObject = classes.class()

function ScreenObject:init(params)
    local w = params.asset:getWidth()
    local h = params.asset:getHeight()
    self.asset = params.asset
    self.w = w
    self.h = h 
    self.offsetX = w / 2
    self.offsetY = h / 2
end

function ScreenObject:draw()
    love.graphics.draw(self.asset, self.x - self.offsetX, self.y - self.offsetY)
end

return ScreenObject