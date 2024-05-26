local ObjectPoolCls = require("Scripts/Classes/ObjectPool")
local EnemyCls = require("Scripts/Classes/Enemy")
local DropCls = require("Scripts/Classes/Drop")
local LevelModel = require("Scripts/Models/LevelModel")
local ScreenSize = require("Scripts/Models/ScreenSize")

local LevelManager = {}

local enemyObjectPool = nil
local dropObjectPool = nil
local levelData = nil
local currentLevel = nil
local currentWave = nil
local currentLevelIndex = 1
local waveTimer = 0
local spawnTimer = 0
local nextSpawnTime = 0
local currentWaveIndex = 1

local spawnedEnemies = {}
local spawnedDrops = {}
local gameStateMachine = nil

math.randomseed(os.clock())

LevelManager.init = function()
    print("Level manager init!")
    
    enemyObjectPool = ObjectPoolCls.new( { objectClass = EnemyCls, objectConfigs = LevelModel.enemies })
    dropObjectPool = ObjectPoolCls.new( { objectClass = DropCls, objectConfigs = LevelModel.drops })
end

LevelManager.startLevel = function(params)
    print("Start level: " .. params.level)
    
    gameStateMachine = params.stateMachine
    currentLevelIndex = params.level
    currentLevel = params.levelData 
    currentWave = currentLevel.waves[1]
    nextSpawnTime = currentLevel.waveSpawnTime
    waveTimer = 0
    spawnTimer = 0
    currentWaveIndex = 1
    spawnedEnemies = {}
    spawnedDrops = {}
end


LevelManager.update = function(dt)
    waveTimer = waveTimer + dt
    spawnTimer = spawnTimer + dt
    LevelManager.checkSpawnEnemy()
    LevelManager.checkSpawnDrop()
    LevelManager.updateSpawnedObjects(dt)
end  

LevelManager.draw = function()
  
    for i, enemy in ipairs(spawnedEnemies) do
        enemy:draw()
    end
    for i, drop in ipairs(spawnedDrops) do
        drop:draw()
    end
end

LevelManager.destroyEnemy = function(index)
    local enemy = table.remove(spawnedEnemies, index)
    enemyObjectPool:despawn(enemy, enemy.enemyType)
end

LevelManager.removeDrop = function(index)
    local drop = table.remove(spawnedDrops, index)
    dropObjectPool:despawn(drop, drop.params.dropType)
end

LevelManager.SpawnedEnemies = function()
    return spawnedEnemies
end

LevelManager.SpawnedDrops = function()
    return spawnedDrops
end

LevelManager.checkSpawnEnemy = function()
    
    if #currentWave.enemies > 0 then
        if spawnTimer > nextSpawnTime then
            local index = math.random(1, #currentWave.enemies)
            local enemy = currentWave.enemies[index]
            enemy.count = enemy.count -1
            --print("Level: " .. currentLevelIndex .. "  Wave: " .. currentWaveIndex .. "  spawn enemy type: " .. enemy.enemyType .. "  remaining: " .. enemy.count)
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
            --print("Next wave: " .. currentWaveIndex)
        else
            gameStateMachine:change("play", {
                stateMachine = gameStateMachine,
                level = currentLevelIndex + 1
            })
            return
        end
    end
end

LevelManager.checkSpawnDrop = function()
    
    for i, drop in ipairs(currentWave.drops) do
        if drop.dropTime < waveTimer then
            local dropSpawned = dropObjectPool:spawn(drop.dropType)
            table.insert(spawnedDrops, dropSpawned)
            table.remove(currentWave.drops, i)
            break
        end
    end
end

LevelManager.updateSpawnedObjects = function(dt)
    
    for i, enemy in ipairs(spawnedEnemies) do
        if enemy.y - enemy.offsetY > ScreenSize.screenHeight then
            LevelManager.destroyEnemy(i) 
            break
        end
    end
    
    for i, drop in ipairs(spawnedDrops) do
        if drop.y - drop.offsetY > ScreenSize.screenHeight then
            LevelManager.removeDrop(i)
            break
        end
    end
    
    for i, enemy in pairs(spawnedEnemies) do
        enemy:update(dt)
    end
    
    for i, drop in pairs(spawnedDrops) do
        drop:update(dt)
    end
  
end


return LevelManager