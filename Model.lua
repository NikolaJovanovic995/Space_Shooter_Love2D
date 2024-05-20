local AssetsManager = require("AssetsManager")
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
    speed = 500
}

Model.bulletParams = {
    assetName = "bullet",
    speed = 300,
    fireRate = 0.5
}

Model.enemiesParams = {
    assetName = "enemy",
    speed = 250
}

Model.starsParams = {
    radius = 1,
    speed = 100,
    numStars = 200
}

Model.init = function()
    Model.stage = {
        stageHeight = love.graphics.getHeight(),
        stageWidth = love.graphics.getWidth()
    }
    
    
    --init assets dynamically
    Model.shipParams.asset = AssetsManager.sprites[Model.shipParams.assetName]
    Model.bulletParams.asset = AssetsManager.sprites[Model.bulletParams.assetName]
    Model.enemiesParams.asset = AssetsManager.sprites[Model.enemiesParams.assetName]
    
    --define enemies here

end


return Model