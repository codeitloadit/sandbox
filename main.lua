require"collision"
require"TEsound"

Player = require("actors/player")
Bullet = require("actors/bullet")
Bomb = require("actors/bomb")
Enemy = require("actors/enemy")

function love.load()
    input = require("input")

    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, true)

    player = Player.create(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
    bullets = {}
    bombs = {}
    enemies = {}

    Enemy.spawnEnemy()
    love.graphics.setBackgroundColor(0,0,0)
end

function love.update(dt)
    world:update(dt)
    input.handle(dt)

    player:update()
    for i, bullet in ipairs(bullets) do bullet:update() end
    for i, bomb in ipairs(bombs) do bomb:update() end
    for i, enemy in ipairs(enemies) do enemy:update() end

    collision.handle()
    TEsound.cleanup()
end

function love.draw()
    for i, bomb in ipairs(bombs) do bomb:draw() end
    for i, bullet in ipairs(bullets) do bullet:draw() end
    for i, enemy in ipairs(enemies) do enemy:draw() end
    player:draw()

    if debug then
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("FPS: "..tostring(love.timer.getFPS()..
            "\nBullets: "..#bullets..
            "\nBombs: "..#bombs..
            "\nEnemies: "..#enemies), 0, 0)
    end
end
