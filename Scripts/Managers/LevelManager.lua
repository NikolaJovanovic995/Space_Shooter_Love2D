local ObjectPoolCls = require("Scripts/Classes/ObjectPool")
local EnemyCls = require("Scripts/Classes/Enemy")
local LevelModel = require("Scripts/Models/LevelModel")
local ScreenSize = require("Scripts/Models/ScreenSize")

local LevelManager = {}

local enemyObjectPool = nil
local levelData = nil
local currentLevel = nil
local currentWave = nil
local currentLevelIndex = 1
local spawnTimer = 0
local nextSpawnTime = 0
local currentWaveIndex = 1

local spawnedEnemies = {}

math.randomseed(os.clock())

LevelManager.init = function(levelNumber, levelDataParam, enemyParams)
    print("Level manager init!")
    enemyObjectPool = ObjectPoolCls.new(
      {
          objectClass = EnemyCls,
          objectConfigs = enemyParams
      })
    
    currentLevelIndex = levelNumber
    currentLevel = levelDataParam
    currentWave = currentLevel.waves[1]
    spawnTimer = 0
    nextSpawnTime = levelDataParam.waveSpawnTime
    currentWaveIndex = 1
    spawnedEnemies = {}
    spawnedDrops = {}
end


LevelManager.update = function(dt)
  
    spawnTimer = spawnTimer + dt
    
    if #currentWave.enemies > 0 then
        if spawnTimer > nextSpawnTime then
            local index = math.random(1, #currentWave.enemies)
            local enemy = currentWave.enemies[index]
            if enemy == nil then
              print("fdsf")
            end
            enemy.count = enemy.count -1
            print("Level: " .. currentLevelIndex .. "  Wave: " .. currentWaveIndex .. "  spawn enemy type: " .. enemy.enemyType .. "  remaining: " .. enemy.count)
            local enemySpawned = enemyObjectPool:spawn(enemy.enemyType)
            table.insert(spawnedEnemies, enemySpawned)
            
            if enemy.count == 0 then
                table.remove(currentWave.enemies, index)
            end
            
            spawnTimer = 0
            nextSpawnTime = math.random(currentWave.minSpawnTime, currentWave.maxSpawnTime)
            
        end
      
    elseif #spawnedEnemies == 0 and #spawnedDrops == 0 then
        
        currentWaveIndex = currentWaveIndex + 1
        
        if currentWaveIndex <= #currentLevel.waves then
            currentWave = currentLevel.waves[currentWaveIndex]
            print("Next wave: " .. currentWaveIndex)
        else
            gStateMachine:change("play", currentLevelIndex + 1)
            return
        end
    end
    
    for i, enemy in ipairs(spawnedEnemies) do
        if enemy.y - enemy.offsetY > ScreenSize.screenHeight then
            local removeEnemy = table.remove(spawnedEnemies, i)
            enemyObjectPool:despawn(removeEnemy, removeEnemy.enemyType)
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

LevelManager.destroyEnemy = function(index)
    local enemy = table.remove(spawnedEnemies, index)
    enemyObjectPool:despawn(enemy, enemy.enemyType)
end

LevelManager.SpawnedEnemies = function()
    return spawnedEnemies
end


return LevelManager