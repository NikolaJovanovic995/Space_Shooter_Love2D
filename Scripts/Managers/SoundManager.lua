local SoundManager = {}

SoundManager.init = function()
  
    local sounds = {
        playerShoot = love.audio.newSource("Assets/Sounds/playerShoot.wav", "static"),
        hit = love.audio.newSource("Assets/Sounds/hit.wav", "static"),
        explosion = love.audio.newSource("Assets/Sounds/explosion.wav", "static"),
        coin = love.audio.newSource("Assets/Sounds/coin.wav", "static"),
        powerup = love.audio.newSource("Assets/Sounds/powerup.wav", "static")
    }
  
  SoundManager.sounds = sounds
    
end

return SoundManager