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
                  bulletType = "bullet",
                  assetName = "bullet",
                  speed = 500,
                  fireRate = 0.5,
                  damage = 5
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
    
    for index, bullet in pairs(Model.bulletsParams) do
        bullet.asset = AssetsManager.sprites[bullet.assetName]
    end
    
    --define enemies here

end


return Model