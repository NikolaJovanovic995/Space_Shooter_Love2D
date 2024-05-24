local UserInput = require("Scripts/Models/UserInput")
local ScreenSize = require("Scripts/Models/ScreenSize")
local BaseState = require("Scripts/Classes/States/BaseState")

ScoreState = classes.class(BaseState)

function ScoreState:enter(params)
  
    self.score = params.score
    self.msg = params.msg
end

function ScoreState:update(dt)
  
    if UserInput.enter then
        gStateMachine:change('play-new', 1)
    end
end

function ScoreState:render()
    
    love.graphics.printf(self.msg, 0, 100, ScreenSize.screenWidth, "center")
    love.graphics.printf("Your score is: " .. self.score, 0, 160, ScreenSize.screenWidth, "center")
    love.graphics.printf("Press Enter to Play Again!", 0, 220, ScreenSize.screenWidth, "center")

end

return ScoreState