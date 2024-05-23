local AssetsManager = require("Scripts/Managers/AssetsManager")

local Model = {}

Model.shipParams = {
    assetName = "ship",
    speed = 400,
    health = 100
}

Model.shootingParams = {
    single =  {
                assetName = "bullet",
                speed = 500,
                fireRate = 0.5,
                damage = 5
              },
    triple =  {
                assetName = "bullet",
                speed = 500,
                fireRate = 0.5,
                damage = 5
              },
    tripleAngle = {
                assetName = "bullet",
                speed = 500,
                fireRate = 0.5,
                damage = 5
              }
}

Model.bulletsParams = {
    bullet =    {
                  assetName = "bullet",
                  speed = 500,
                  fireRate = 0.5,
                  damage = 5
                }
}

Model.levelParams = {
    {
        levelName = "Level 1",
        waveSpawnTime = 3,
        waves = { 
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_1" , count = 5 } } 
                    }, -- wave 1
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_2" , count = 10 } } 
                    }, -- wave 2
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_3" , count = 15 } } 
                    } -- wave 3
                }
    },
    {
        levelName = "Level 2",
        minSpawnTime = 2,
        maxSpawnTime = 3,
        waveSpawnTime = 3,
        waves = { 
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_1" , count = 1 } } 
                    }, -- wave 1
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_1" , count = 1 } } 
                    }, -- wave 2
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_1" , count = 1 } } 
                    } -- wave 3
                }
    },
    {
        levelName = "Level 3",
        minSpawnTime = 1,
        maxSpawnTime = 3,
        waveSpawnTime = 3,
        waves = { 
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_1" , count = 1 } } 
                    }, -- wave 1
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_1" , count = 1 } } 
                    }, -- wave 2
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_1" , count = 1 } } 
                    } -- wave 3
                }
    }
}

Model.enemies = {
    enemy_1 = {
                  enemyType = "enemy_1",
                  movementType = "straight",
                  assetName = "enemy_1",
                  speed = 250,
                  health = 10,
                  impactDamage = 10,
                  pointsValue = 1
              },
    enemy_2 = {
                  enemyType = "enemy_2",
                  movementType = "straight",
                  assetName = "enemy_2",
                  speed = 400,
                  health = 5,
                  impactDamage = 50,
                  pointsValue = 2
              },
    enemy_3 = {
                  enemyType = "enemy_3",
                  movementType = "sin",
                  assetName = "enemy_2",
                  speed = 250,
                  health = 10,
                  impactDamage = 10,
                  pointsValue = 2
              }
}

Model.starsParams = {
    radius = 1,
    speed = 100,
    numStars = 200
}

Model.explosionsParams = {
    assetName = "explosion",
    duration = 0.2
}

Model.init = function()
    --init assets dynamically
    Model.shipParams.asset = AssetsManager.sprites[Model.shipParams.assetName]
    Model.bulletsParams.asset = AssetsManager.sprites[Model.bulletsParams.assetName]
    Model.explosionsParams.asset = AssetsManager.sprites[Model.explosionsParams.assetName]
    
    for index, enemy in pairs(Model.enemies) do
        enemy.asset = AssetsManager.sprites[enemy.assetName]
    end
    
    for index, bullet in pairs(Model.bulletsParams) do
        bullet.asset = AssetsManager.sprites[bullet.assetName]
    end
    
    --define enemies here

end


return Model