local EnemySpawner = require("Scripts/Managers/EnemySpawner")
local Model = require("Scripts/Models/Model")

local LevelManager = {}

local stageWidth = nil
local stageHeight = nil
local levelData = nil
local currentLevel = nil
local currentWave = nil
local currentLevelIndex = 1
local spawnTimer = 0
local nextSpawnTime = 0
local lastLevelIndex = 0
local currentWaveIndex = 1

local spawnedEnemies = {}

math.randomseed(os.clock())

LevelManager.init = function(levelParams, enemyParams)
    print("Level manager init!")
    EnemySpawner.init(enemyParams)
    stageWidth = Model.stage.stageWidth
    stageHeight = Model.stage.stageHeight
    levelData = levelParams
    currentLevel = levelData[1]
    currentWave = currentLevel.waves[1]
    lastLevelIndex = #levelData
    spawnTimer = 0
    spawnedEnemies = {}
    
end


LevelManager.update = function(dt)
  
    spawnTimer = spawnTimer + dt
    
    if currentLevelIndex > 0 then
        if #currentWave.enemies > 0 then
            if spawnTimer > nextSpawnTime then
                local index = math.random(1, #currentWave.enemies)
                local enemy = currentWave.enemies[index]
                enemy.count = enemy.count -1
                print("Level: " .. currentLevelIndex .. "  Wave: " .. currentWaveIndex .. "  spawn enemy type: " .. enemy.enemyType .. "  remaining: " .. enemy.count)
                local enemySpawned = EnemySpawner.spawn(enemy.enemyType)
                table.insert(spawnedEnemies, enemySpawned)
                
                if enemy.count == 0 then
                    table.remove(currentWave.enemies, index)
                end
                
                spawnTimer = 0
                nextSpawnTime = math.random(currentWave.minSpawnTime, currentWave.maxSpawnTime)
                
            end
          
        else
            currentWaveIndex = currentWaveIndex + 1
            if currentWaveIndex > #currentLevel.waves then
                currentWaveIndex = 1
          
                currentLevelIndex = currentLevelIndex + 1
                if currentLevelIndex <= lastLevelIndex then
                    currentLevel = levelData[currentLevelIndex]
                    currentWave = currentLevel.waves[currentWaveIndex]
                    print("next level")
                else
                    currentLevelIndex = -1
                    print("End of the game")
                end
            else
                currentWave = currentLevel.waves[currentWaveIndex]
                print("Next wave")
            end
        end
    end
    
    
    for i, enemy in ipairs(spawnedEnemies) do
        if enemy.y - enemy.offsetY > stageHeight then
            local removeEnemy = table.remove(spawnedEnemies, i)
            EnemySpawner.despawn(removeEnemy)
            break
        end
    end
    
    for i, enemy in pairs(spawnedEnemies) do
        enemy:update(dt)
    end
    
end

LevelManager.draw = function()
    for i, enemy in ipairs(spawnedEnemies) do
        enemy:draw()
    end
end

LevelManager.removeEnemy = function(index)
    local enemy = table.remove(spawnedEnemies, index)
    EnemySpawner.despawn(enemy)
end

LevelManager.SpawnedEnemies = function()
    return spawnedEnemies
end


return LevelManager