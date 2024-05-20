local classes = require("classes")
local Enemies = classes.class()
local Model = require("Model")

math.randomseed(os.clock())

function Enemies:init(enemiesParams)
    print("Enemies init!")
    
    local stageWidth = Model.stage.stageWidth
    local stageHeight = Model.stage.stageHeight
    
    self.asset = enemiesParams.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.radius = self.h / 2
    self.speed = enemiesParams.speed
    self.enemies = {}
    self.enemiesCount = 0
    self.spawnTime = math.random(1,3)
    self.spawnTimer = 0
    
    self.spawnEnemy = function ()
        self.enemiesCount = self.enemiesCount + 1
        self.enemies[self.enemiesCount] = { x = math.random( self.w / 2 , stageWidth - self.w / 2), y = self.h / - 2 }
        self.spawnTimer = 0
        self.spawnTime = math.random(3,6)
    end
    
end

function Enemies:update(dt)  
    self.spawnTimer = self.spawnTimer + dt
  
    for i=1, #self.enemies do
        local enemy = self.enemies[i]
        enemy.y = enemy.y + self.speed * dt
    end
    
    if self.spawnTimer > self.spawnTime then
        self:spawnEnemy()
    end

end

function Enemies:draw()
  
    for i=1, #self.enemies do
        local enemy = self.enemies[i]
        love.graphics.draw(self.asset, enemy.x, enemy.y)
    end
end

return Enemies