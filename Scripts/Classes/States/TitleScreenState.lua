local UserInput = require("Scripts/Models/UserInput")
local ScreenSize = require("Scripts/Models/ScreenSize")
local BaseState = require("Scripts/Classes/States/BaseState")

TitleScreenState = classes.class(BaseState)

function TitleScreenState:update(dt)
  
    if UserInput.enter then
        gStateMachine:change("play", 1)
    end
end

function TitleScreenState:render()
  
    love.graphics.printf("Space Shooter Game", 0, 100, ScreenSize.screenWidth, "center")
    love.graphics.printf('Press ENTER to start!', 0, 160, ScreenSize.screenWidth, "center")
end

return TitleScreenState