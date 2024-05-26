local UserInput = require("Scripts/Models/UserInput")
local ScreenSize = require("Scripts/Models/ScreenSize")
local BaseState = require("Scripts/Classes/States/BaseState")

TitleScreenState = classes.class(BaseState)

local gameStateMachine = nil

function TitleScreenState:enter(stateMachine)
    
    gameStateMachine = stateMachine
end

function TitleScreenState:update(dt)
  
    if UserInput.enter then
        gameStateMachine:change("play", {
            stateMachine = gameStateMachine,
            level = 1
        })
    end
end

function TitleScreenState:render()
  
    love.graphics.printf("SPACE SHOOTER GAME", 0, 100, ScreenSize.screenWidth, "center")
    love.graphics.printf('PRESS ENTER TO START!', 0, 160, ScreenSize.screenWidth, "center")
end

return TitleScreenState