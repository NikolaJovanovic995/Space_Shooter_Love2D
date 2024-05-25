local AssetsManager = require("Scripts/Managers/AssetsManager")

local ShootingModel = {}

ShootingModel.shootingParams = {
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

ShootingModel.bulletsParams = {
    bullet =    {
                  bulletType = "bullet",
                  assetName = "bullet",
                  speed = 500,
                  fireRate = 0.5,
                  damage = 5
                }
}

ShootingModel.init = function()
    for index, bullet in pairs(ShootingModel.bulletsParams) do
        bullet.asset = AssetsManager.sprites[bullet.assetName]
    end
end

return ShootingModel