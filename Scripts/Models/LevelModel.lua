local AssetsManager = require("Scripts/Managers/AssetsManager")

local LevelModel = {}


LevelModel.levels = {
    {
        levelName = "Level 1",
        waveSpawnTime = 3,
        waves = { 
                  {   
                      minSpawnTime = 2,
                      maxSpawnTime = 3,
                      enemies = { { enemyType = "enemy_1" , count = 1 } }, 
                      drops = {
                        { 
                            dropType = "triple_short",
                            dropTime = 1     
                        }
                      }
                  }, -- wave 1
                  {   
                      minSpawnTime = 2,
                      maxSpawnTime = 3,
                      enemies = { { enemyType = "enemy_2" , count = 1 } } ,
                      drops = {
                        { 
                            dropType = "coin_small",
                            dropTime = 3   
                        }
                      }
                  }, -- wave 2
                  {   
                      minSpawnTime = 2,
                      maxSpawnTime = 3,
                      enemies = { { enemyType = "enemy_3" , count = 1 } } ,
                      drops = {
                        { 
                            dropType = "hp_small",
                            dropTime = 5     
                        }
                      }
                  } -- wave 3
              }
    },
    {
        levelName = "Level 2",
        waveSpawnTime = 3,
        waves = { 
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 3,
                        enemies = { { enemyType = "enemy_1" , count = 2 } } , 
                        drops = {
                          { 
                              dropType = "tripleAngle_short",
                              dropTime = 1     
                          }
                        }
                    }, -- wave 1
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 3,
                        enemies = { { enemyType = "enemy_2" , count = 2 } } , 
                        drops = {
                          { 
                              dropType = "hp_small",
                              dropTime = 1     
                          }
                        }
                    }, -- wave 2
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 3,
                        enemies = { { enemyType = "enemy_3" , count = 2 } } , 
                        drops = {
                          { 
                              dropType = "hp_small",
                              dropTime = 1     
                          }
                        }
                    } -- wave 3
                }
    },
    {
        levelName = "Level 3",
        waveSpawnTime = 3,
        waves = { 
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_3" , count = 3 } } , 
                        drops = {
                          { 
                              dropType = "hp_small",
                              dropTime = 1     
                          }
                        }
                    }, -- wave 1
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_3" , count = 3 } } , 
                        drops = {
                          { 
                              dropType = "hp_small",
                              dropTime = 1     
                          }
                        }
                    }, -- wave 2
                    {   
                        minSpawnTime = 2,
                        maxSpawnTime = 4,
                        enemies = { { enemyType = "enemy_3" , count = 3 } } , 
                        drops = {
                          { 
                              dropType = "hp_small",
                              dropTime = 1     
                          }
                        }
                    } -- wave 3
                }
    }
}

LevelModel.drops = {
    hp_small = {
                    dropType = "hp_small",
                    effect = "health",
                    movementType = "straight",
                    assetName = "health",
                    speed = 600,
                    amount = 20
                },
    coin_small = {
                    dropType = "coin_small",
                    effect = "points",
                    movementType = "straight",
                    assetName = "coin",
                    speed = 600,
                    amount = 10

                },
    triple_short = {
                    dropType = "triple_short",
                    effect = "shooting",
                    movementType = "sin",
                    assetName = "fireRate",
                    speed = 300,
                    duration = 10,
                    shootingType = "triple"
                },
    tripleAngle_short = {
                    dropType = "tripleAngle_short",
                    effect = "shooting",
                    movementType = "sin",
                    assetName = "fireAngles",
                    speed = 300,
                    duration = 10,
                    shootingType = "tripleAngle"
                }
}


LevelModel.enemies = {
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
                  speed = 500,
                  health = 5,
                  impactDamage = 50,
                  pointsValue = 2
              },
    enemy_3 = {
                  enemyType = "enemy_3",
                  movementType = "sin",
                  assetName = "enemy_2",
                  speed = 250,
                  health = 20,
                  impactDamage = 10,
                  pointsValue = 2
              }
}

LevelModel.init = function()
    
    for index, drop in pairs(LevelModel.drops) do
        drop.asset = AssetsManager.sprites[drop.assetName]
    end
    
    for index, enemy in pairs(LevelModel.enemies) do
        enemy.asset = AssetsManager.sprites[enemy.assetName]
    end
    
end

return LevelModel

