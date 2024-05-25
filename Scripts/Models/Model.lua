local AssetsManager = require("Scripts/Managers/AssetsManager")

local Model = {}

Model.shipParams = {
    assetName = "ship",
    speed = 400,
    health = 100
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
    Model.explosionsParams.asset = AssetsManager.sprites[Model.explosionsParams.assetName]
end

return Model