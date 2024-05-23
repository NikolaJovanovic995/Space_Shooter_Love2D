--EXAMPLES
----------------------
--for debugging in zero brane
require("mobdebug").start()

--this is to make prints appear right away in zerobrane
io.stdout:setvbuf("no")

local mathUtil = require ("Scripts/Utils/MathUtils")

----EXAMPLES: INSTANTIARING A CLASS

local ShipCls = require("Scripts/Classes/Ship")
local ship = nil

local StarsCls = require("Scripts/Classes/Stars")
local stars = nil

local ExplosionsCls = require("Scripts/Classes/Explosions")
local explosions = nil

local LevelManager = require("Scripts/Managers/LevelManager")
local AssetsManager = require("Scripts/Managers/AssetsManager")
local Model = require("Scripts/Models/Model")

local LEFT_KEY = "left"
local RIGHT_KEY = "right"
local UP_KEY = "up"
local DOWN_KEY = "down"
local SPACE_KEY = "space"

local isGameOver = false

function love.load()
    print("love.load")
    AssetsManager.init()
    Model.init()
    LevelManager.init(Model.levelParams, Model.enemies)
    stars = StarsCls.new( Model.starsParams)
    ship = ShipCls.new( Model.shipParams )
    explosions = ExplosionsCls.new( Model.explosionsParams )
end

function love.update(dt)
  
    if isGameOver == false then
      
        stars:update(dt)
        ship:update(dt)
        LevelManager.update(dt)
        explosions:update(dt)
        
        checkCollisions()
    end
end


function love.draw()
  
    if isGameOver == false then
        
        love.graphics.draw(AssetsManager.sprites.fireAngles, 0,0 )
        stars:draw()
        ship:draw()
        LevelManager.draw()
        explosions:draw(dt)
        
        --love.graphics.print("You Win!", 180, 350)
        love.graphics.print("HP: " .. ship.health , 180, 30)
        love.graphics.print("FPS: " .. love.timer.getFPS() , 30, 30)
    end
end


function love.keypressed(key)
    print(key)
    if key == LEFT_KEY then
        Model.movement.left = true
    elseif key == RIGHT_KEY then
        Model.movement.right = true
    end
    
    if key == UP_KEY then
        Model.movement.up = true
    elseif key == DOWN_KEY then
        Model.movement.down = true
    end
    
    if key == SPACE_KEY then
        Model.movement.space = true
    end

end

function love.keyreleased(key)
    if key == LEFT_KEY then
        Model.movement.left = false
    elseif key == RIGHT_KEY then
        Model.movement.right = false
    end
    
    if key == UP_KEY then
        Model.movement.up = false
    elseif key == DOWN_KEY then
        Model.movement.down = false
    end
    
    if key == SPACE_KEY then
        Model.movement.space = false
    end
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


