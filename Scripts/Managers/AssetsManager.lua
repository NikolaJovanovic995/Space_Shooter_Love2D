local AssetsManager = {}

AssetsManager.init = function()
    
    local sprites = {
        ship = love.graphics.newImage("Assets/Sprites/ship.png"),
        enemy_1 = love.graphics.newImage("Assets/Sprites/enemy_1.png"),
        enemy_2 = love.graphics.newImage("Assets/Sprites/enemy_2.png"),
        bullet = love.graphics.newImage("Assets/Sprites/bullet.png"),
        explosion = love.graphics.newImage("Assets/Sprites/explosion.png"),
        coin = love.graphics.newImage("Assets/Sprites/coin.png"),
        health = love.graphics.newImage("Assets/Sprites/health.png"),
        shield = love.graphics.newImage("Assets/Sprites/shield.png"),
        magnet = love.graphics.newImage("Assets/Sprites/magnet.png"),
        fireRate = love.graphics.newImage("Assets/Sprites/fireRate.png"),
        fireAngles = love.graphics.newImage("Assets/Sprites/fireAngles.png"),
    }
  
    local sounds = {
        playerShoot = love.audio.newSource("Assets/Sounds/playerShoot.wav", "static")
    }
  
  AssetsManager.sprites = sprites
  AssetsManager.sounds = sounds
    
end



return AssetsManager