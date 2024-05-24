local EnemyCls = require("Scripts/Classes/Enemy")
local objectUtil = require ("Scripts/Utils/ObjectUtil")

local EnemySpawner = {}

local enemiesConfig = {}
local enemiesPool = {}

EnemySpawner.init = function(params)
    enemiesConfig = params
end


EnemySpawner.spawn = function(enemyType)
    if enemiesPool[enemyType] == nil or #enemiesPool[enemyType] == 0 then
        print("No enemies in pool of type: " .. enemyType)
        return EnemyCls.new(objectUtil.deepCopy(enemiesConfig[enemyType]))
    else
        print("Get enemy from pool of type: " .. enemyType)
        local enemy = table.remove(enemiesPool[enemyType])
        enemy:reset(enemiesConfig[enemyType])
        return enemy
    end
end

EnemySpawner.despawn = function(enemy)
  
    if enemiesPool[enemy.enemyType] == nil then
        print("Create new table in pool for enemy type: " .. enemy.enemyType)
        enemiesPool[enemy.enemyType] = {}
    end
    
    print("Return enemy in pool for enemy type: ".. enemy.enemyType)
    table.insert(enemiesPool[enemy.enemyType], enemy)
end


return EnemySpawner