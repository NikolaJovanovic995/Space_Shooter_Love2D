--[[
    TitleScreenState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The TitleScreenState is the starting screen of the game, shown on startup. It should
    display "Press Space" and also our highest score.
]]
local UserInput = require("Scripts/Models/UserInput")
local ScreenSize = require("Scripts/Models/ScreenSize")
local BaseState = require("Scripts/Classes/States/BaseState")

TitleScreenState = classes.class(BaseState)

function TitleScreenState:update(dt)
    if UserInput.space then
        gStateMachine:change("countdown")
    end
end

function TitleScreenState:render()
    -- simple UI code
    love.graphics.print("Space Shooter Game", 0, 64)

    love.graphics.print('Press SPACE to start!', 0, 100)
end

return TitleScreenState