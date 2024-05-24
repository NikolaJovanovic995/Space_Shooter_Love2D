local BaseState = require("Scripts/Classes/States/BaseState")
PlayState = classes.class(BaseState)

local ShipCls = require("Scripts/Classes/Ship")
local ship = nil

local StarsCls = require("Scripts/Classes/Stars")
local stars = nil

local ExplosionsCls = require("Scripts/Classes/Explosions")
local explosions = nil


local SoundManager = require("Scripts/Managers/SoundManager")
local LevelManager = require("Scripts/Managers/LevelManager")
local Model = require("Scripts/Models/Model")
local LevelModel = require("Scripts/Models/LevelModel")
local UserInput = require("Scripts/Models/UserInput")
local mathUtil = require ("Scripts/Utils/MathUtil")
local objectUtil = require ("Scripts/Utils/ObjectUtil")

function PlayState:init()
  
    LevelModel.init()
  
    stars = StarsCls.new( Model.starsParams)
    ship = ShipCls.new( Model.shipParams )
    explosions = ExplosionsCls.new( Model.explosionsParams )
end

function PlayState:enter(level)
  
    if level > #LevelModel.levels then
        gStateMachine:change('score', {
            score = ship.score,
            msg = "YOU WON"
        })
    else
        LevelManager.init(level, objectUtil.deepCopy( LevelModel.levels[level]), LevelModel.enemies)
    end
end

function PlayState:update(dt)
    
    stars:update(dt)
    ship:update(dt)
    explosions:update(dt)
    LevelManager.update(dt)

    PlayState:checkCollisions()
end

function PlayState:render()
    
    stars:draw()
    ship:draw()
    LevelManager.draw()
    explosions:draw(dt)
    
    love.graphics.print("HP: " .. ship.health , 30, 30)
    love.graphics.print("SCORE: " .. ship.score , 180, 30)
    love.graphics.print("FPS: " .. love.timer.getFPS() , 360, 30)
end


function PlayState:checkCollisions()
  
    for i, enemy in ipairs(LevelManager.SpawnedEnemies()) do
      
        if mathUtil.isColliding(enemy.x, enemy.y, enemy.offsetX, enemy.offsetY, ship.x, ship.y, ship.offsetX, ship.offsetY)  then
          
            print("Player got hit")
            
            SoundManager.sounds.hit:play()
            local isGameOver = ship:makeDamage(enemy.impactDamage)
            
            if isGameOver then
                gStateMachine:change('score', {
                    score = ship.score,
                    msg = "YOU LOST"
                })
                return
            end
            
            local isEnemyDead = enemy:makeDamage(i, enemy.health)
            if isEnemyDead then
              
                LevelManager.destroyEnemy(i)
                explosions:spawnExplosion((enemy.x + ship.x) / 2, (enemy.y + ship.y) / 2)
                SoundManager.sounds.explosion:play()
            end
            break
        
        else
            for j, bullet in ipairs(ship.shooting.spawnedBullets) do
              
                if mathUtil.isColliding(enemy.x, enemy.y, enemy.offsetX, enemy.offsetY, bullet.x, bullet.y, bullet.offsetX, bullet.offsetY)  then
                    print("Enemy hit")
                    local destroyed = enemy:makeDamage(i, bullet.damage)
                    ship.shooting:bulletHit(j)
                    if destroyed then
                        LevelManager.destroyEnemy(i)
                        explosions:spawnExplosion((enemy.x + bullet.x) / 2, (enemy.y + bullet.y) / 2)
                        ship.score = ship.score + enemy.pointsValue
                        SoundManager.sounds.explosion:play()
                    else
                        SoundManager.sounds.hit:play()
                    end
                    return
                end
            end
        end
    end
  
end

return PlayState