--EXAMPLES
----------------------
--for debugging in zero brane
require("mobdebug").start()

--this is to make prints appear right away in zerobrane
io.stdout:setvbuf("no")

local StateMashineCls = require("Scripts/Classes/States/StateMachine")
local TitleScreenStateCls = require("Scripts/Classes/States/TitleScreenState")
local PlayStateCls = require("Scripts/Classes/States/PlayState")
local ScoreStateCls = require("Scripts/Classes/States/ScoreState")

----EXAMPLES: INSTANTIARING A CLASS

local AssetsManager = require("Scripts/Managers/AssetsManager")
local Model = require("Scripts/Models/Model")
local UserInput = require("Scripts/Models/UserInput")

local LEFT_KEY = "left"
local RIGHT_KEY = "right"
local UP_KEY = "up"
local DOWN_KEY = "down"
local SPACE_KEY = "space"

function love.load()
    print("love.load")
    AssetsManager.init()
    Model.init()
    
    gStateMachine = StateMashineCls.new(
      {
        ['title'] = function() return TitleScreenStateCls.new() end,
        ['play'] = function() return PlayStateCls.new() end,
        ['score'] = function() return ScoreStateCls.new() end
      }
    )
    gStateMachine:change('title')
end

function love.update(dt)
  
    gStateMachine:update(dt)
end


function love.draw()
  
    gStateMachine:render()
end


function love.keypressed(key)
    print(key)
    if key == LEFT_KEY then
        UserInput.left = true
    elseif key == RIGHT_KEY then
        UserInput.right = true
    end
    
    if key == UP_KEY then
        Model.movement.up = true
    elseif key == DOWN_KEY then
        UserInput.down = true
    end
    
    if key == SPACE_KEY then
        UserInput.space = true
    end

end

function love.keyreleased(key)
    if key == LEFT_KEY then
        UserInput.left = false
    elseif key == RIGHT_KEY then
        UserInput.right = false
    end
    
    if key == UP_KEY then
        UserInput.up = false
    elseif key == DOWN_KEY then
        UserInput.down = false
    end
    
    if key == SPACE_KEY then
        UserInput.space = false
    end
end