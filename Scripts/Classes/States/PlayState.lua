local BaseState = require("Scripts/Classes/States/BaseState")
PlayState = classes.class(BaseState)

local ShipCls = require("Scripts/Classes/Ship")
local ship = nil

local StarsCls = require("Scripts/Classes/Stars")
local stars = nil

local ExplosionsCls = require("Scripts/Classes/Explosions")
local explosions = nil

local LevelManager = require("Scripts/Managers/LevelManager")
local AssetsManager = require("Scripts/Managers/AssetsManager")
local Model = require("Scripts/Models/Model")
local UserInput = require("Scripts/Models/UserInput")
local mathUtil = require ("Scripts/Utils/MathUtils")

function PlayState:init()
  
    LevelManager.init(Model.levelParams, Model.enemies)
    stars = StarsCls.new( Model.starsParams)
    ship = ShipCls.new( Model.shipParams )
    explosions = ExplosionsCls.new( Model.explosionsParams )
end

function PlayState:update(dt)
    
    stars:update(dt)
    ship:update(dt)
    LevelManager.update(dt)
    explosions:update(dt)
    
    checkCollisions()
    

    -- reset if we get to the ground
    --[[
    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        sounds['hurt']:play()

        gStateMachine:change('score', {
            score = self.score
        })
    end]]
end

function PlayState:render()
    
    love.graphics.draw(AssetsManager.sprites.fireAngles, 0,0 )
    stars:draw()
    ship:draw()
    LevelManager.draw()
    explosions:draw(dt)
    
    --love.graphics.print("You Win!", 180, 350)
    love.graphics.print("HP: " .. ship.health , 180, 30)
    love.graphics.print("FPS: " .. love.timer.getFPS() , 30, 30)
end



function checkCollisions()
  
    for i, enemy in ipairs(LevelManager.SpawnedEnemies()) do
      
        if mathUtil.isColliding(enemy.x, enemy.y, enemy.offsetX, enemy.offsetY, ship.x, ship.y, ship.offsetX, ship.offsetY)  then
          
            print("Player got hit")
            isGameOver = ship:makeDamage(enemy.impactDamage)
            local isEnemyDead = enemy:makeDamage(i, enemy.health)
            if isEnemyDead then
                LevelManager.removeEnemy(i)
                explosions:spawnExplosion((enemy.x + ship.x) / 2, (enemy.y + ship.y) / 2)
            end
            break
        
        else
            for j, bullet in ipairs(ship.shooting.spawnedBullets) do
              
                if mathUtil.isColliding(enemy.x, enemy.y, enemy.offsetX, enemy.offsetY, bullet.x, bullet.y, bullet.offsetX, bullet.offsetY)  then
                    print("Enemy hit")
                    local destroyed = enemy:makeDamage(i, bullet.damage)
                    ship.shooting:bulletHit(j)
                    if destroyed then
                        LevelManager.removeEnemy(i)
                        explosions:spawnExplosion((enemy.x + bullet.x) / 2, (enemy.y + bullet.y) / 2)
                    end
                    return
                end
            end
        end
    end
  
end


function PlayState:enter()

end


function PlayState:exit()

end

return PlayState