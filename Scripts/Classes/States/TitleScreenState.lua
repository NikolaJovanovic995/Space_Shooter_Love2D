local UserInput = require("Scripts/Models/UserInput")
local ScreenSize = require("Scripts/Models/ScreenSize")
local BaseState = require("Scripts/Classes/States/BaseState")

TitleScreenState = classes.class(BaseState)

function TitleScreenState:update(dt)
  
    if UserInput.space then
        gStateMachine:change("play")
    end
end

function TitleScreenState:render()
  
    love.graphics.printf("Space Shooter Game", 0, 64, ScreenSize.screenWidth, "center")
    love.graphics.printf('Press SPACE to start!', 0, 100, ScreenSize.screenWidth, "center")
end

return TitleScreenState