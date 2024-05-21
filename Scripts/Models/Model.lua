local AssetsManager = require("Scripts/Managers/AssetsManager")

local Model = {
    movement = {
        up = false,
        down = false,
        left = false,
        right = false,
        space = false
    }
}

Model.shipParams = {
    assetName = "ship",
    speed = 400,
    health = 100
}

Model.bulletsParams = {
    assetName = "bullet",
    speed = 500,
    fireRate = 0.5,
    damage = 5
}

Model.levelParams = {
    {
        levelName = "Level 1",
        minSpawnTime = 2,
        maxSpawnTime = 4,
        enemies = {  { enemyType = "enemy_1" , count = 1 }  }
    },
    {
        levelName = "Level 2",
        minSpawnTime = 2,
        maxSpawnTime = 3,
        enemies = {  { enemyType = "enemy_1" , count = 10 } , { enemyType = "enemy_2" , count = 5 } }
    },
    {
        levelName = "Level 3",
        minSpawnTime = 1,
        maxSpawnTime = 3,
        enemies = {  { enemyType = "enemy_1" , count = 10 } , { enemyType = "enemy_2" , count = 10 }}
    }
}

Model.enemies = {
    {
        assetName = "enemy_1",
        speed = 250,
        health = 5,
        impactDamage = 10,
        pointsValue = 1
    },
    {
        assetName = "enemy_2",
        speed = 250,
        health = 10,
        impactDamage = 20,
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
    Model.stage = {
        stageHeight = love.graphics.getHeight(),
        stageWidth = love.graphics.getWidth()
    }
    
    
    --init assets dynamically
    Model.shipParams.asset = AssetsManager.sprites[Model.shipParams.assetName]
    Model.bulletsParams.asset = AssetsManager.sprites[Model.bulletsParams.assetName]
    Model.explosionsParams.asset = AssetsManager.sprites[Model.explosionsParams.assetName]
    --Model.enemiesParams.asset = AssetsManager.sprites[Model.enemiesParams.assetName]
    
    for index, enemy in ipairs(Model.enemies) do
        enemy.asset = AssetsManager.sprites[enemy.assetName]
    end
    
    --define enemies here

end


return Model