local LevelManager = {}

local levelData = nil
local currentLevel = nil
local currentLevelIndex = 1
local spawnTimer = 0
local nextSpawnTime = 0
local lastLevelIndex = 0

math.randomseed(os.clock())

LevelManager.init = function(params)
    print("Level manager init!")
    levelData = params
    currentLevel = levelData[1]
    lastLevelIndex = #levelData
    spawnTimer = 0
end


LevelManager.update = function(dt)
    spawnTimer = spawnTimer + dt
    
    if currentLevelIndex > 0 then
        if #currentLevel.enemies > 0 then
            if spawnTimer > nextSpawnTime then
                print("spawn enemy")
                local index = math.random(1, #currentLevel.enemies)
                local enemy = currentLevel.enemies[index]
                print("enemy type: " .. enemy.enemyType)
                enemy.count = enemy.count -1
                print("enemy count: " .. enemy.count)
                
                if enemy.count == 0 then
                    table.remove(currentLevel.enemies, index)
                    print("removing enemy type")
                end
                
                spawnTimer = 0
                nextSpawnTime = math.random(currentLevel.minSpawnTime, currentLevel.maxSpawnTime)
                
            end
          
        else
            currentLevelIndex = currentLevelIndex + 1
            if currentLevelIndex <= lastLevelIndex then
                currentLevel = levelData[currentLevelIndex]
                print("next level")
            else
                currentLevelIndex = -1
                print("End of the game")
            end
        end
    end
    
end

LevelManager.draw = function()

end


return LevelManager


--[[
local classes = require("classes")
local Enemies = classes.class()
local Model = require("Model")

local stageWidth = nil
local stageHeight = nil
math.randomseed(os.clock())

function LevelManager:init(enemiesParams)
    print("Enemies init!")
    
    stageWidth = Model.stage.stageWidth
    stageHeight = Model.stage.stageHeight
    
    self.asset = enemiesParams.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.offsetX = self.w / 2
    self.offsetY = self.h / 2
    self.speed = enemiesParams.speed
    self.health = enemiesParams.health
    self.impactDamage = enemiesParams.impactDamage
    self.pointsValue = enemiesParams.pointsValue
    
    self.spawnedEnemies = {}
    self.spawnTime = math.random(0,2)
    self.spawnTimer = 0
    
end

function LevelManager:update(dt)  
    self.spawnTimer = self.spawnTimer + dt
  
    for i=1, #self.spawnedEnemies do
        local enemy = self.spawnedEnemies[i]
        enemy.y = enemy.y + self.speed * dt
    end
    
    if self.spawnTimer > self.spawnTime then
        self:spawnEnemy()
    end

end

function LevelManager:draw()
  
    for i=1, #self.spawnedEnemies do
        local enemy = self.spawnedEnemies[i]
        love.graphics.draw(self.asset, enemy.x - self.offsetX, enemy.y - self.offsetY)
    end
end

function Enemies:spawnEnemy()
  
    table.insert(self.spawnedEnemies, { x = math.random( self.offsetX, stageWidth - self.offsetX), y = - self.h, health = self.health, impactDamage = self.impactDamage })
    self.spawnTimer = 0
    self.spawnTime = math.random(0, 2)
end

function Enemies:makeDamage(index, damage)
  
    local enemy = self.spawnedEnemies[index]
    enemy.health = enemy.health - damage
    if enemy.health <= 0 then
        table.remove(self.spawnedEnemies, index)
        return true
    else
        return false
    end
end


return Enemies
]]