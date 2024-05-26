local UserInput = require("Scripts/Models/UserInput")
local ScreenSize = require("Scripts/Models/ScreenSize")
local BaseState = require("Scripts/Classes/States/BaseState")

local fileName = "highscore.txt"
local gameStateMachine = nil

ScoreState = classes.class(BaseState)

function ScoreState:enter(params)
    gameStateMachine = params.stateMachine
    self.score = params.score
    self.msg = params.msg
    self.isHighScore = ScoreState:updateHighScore(fileName, self.score)
end

function ScoreState:update(dt)
  
    if UserInput.enter then
        gameStateMachine:change("play-new", {
            stateMachine = gameStateMachine,
            level = 1
        })
    end
end

function ScoreState:render()
    
    love.graphics.printf(self.msg, 0, 100, ScreenSize.screenWidth, "center")
    love.graphics.printf("YOUR SCORE IS: " .. self.score, 0, 160, ScreenSize.screenWidth, "center")
    if self.isHighScore then
        love.graphics.printf("NEW HIGHSCORE", 0, 220, ScreenSize.screenWidth, "center")
    end
    love.graphics.printf("PRESS ENTER TO PLAY AGAIN!", 0, 280, ScreenSize.screenWidth, "center")

end

function ScoreState:updateHighScore(filename, newScore)
    
    local oldScore = 0
    
    if love.filesystem.getInfo(filename) then
        local file = love.filesystem.newFile(filename)
        file:open("r")
        local val = file:read()
        oldScore = tonumber(val)
        file:close()
    end
    
    if newScore > oldScore then
        file = love.filesystem.newFile(filename)
        file:open("w")
        file:write(newScore)
        file:close()
        return true
    else
        return false
    end
end

return ScoreState