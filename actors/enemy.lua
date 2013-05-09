module(..., package.seeall)

function spawnEnemy()
    local enemyBuffer = 200
    local spawn = {
        x = math.random(SCREEN_WIDTH), 
        y = math.random(SCREEN_HEIGHT)
    }
    if collision.distanceBetweenPoints(spawn, player) >= enemyBuffer then
        enemies[#enemies+1] = Enemy.create(spawn.x, spawn.y)
    else
        spawnEnemy()
    end
end

function create(x, y)
    local this = {}
    this.x = x or 0
    this.y = y or 0
    this.radius = 20
    this.angle = -1
    this.speed = 0.5
    this.color = {102, 204, 255}
    this.life = 2

    function this:takeHit(index)
        if this.life == 1 then table.remove(enemies, index) end
        if this.life == 2 then this.life = 1 end
    end

    function this:update()
        this.angle = math.deg(math.atan2(player.y - this.y, player.x - this.x)) + 360;
        
        if this.angle >= 0 then
            this.x = this.x + math.cos(math.rad(this.angle)) * this.speed;
            this.y = this.y + math.sin(math.rad(this.angle)) * this.speed;

            -- Keep player within screen bounds.
            if this.x < this.radius then this.x = this.radius end
            if this.x > SCREEN_WIDTH - this.radius then this.x = SCREEN_WIDTH - this.radius end
            if this.y < this.radius then this.y = this.radius end
            if this.y > SCREEN_HEIGHT - this.radius then this.y = SCREEN_HEIGHT - this.radius end
        end
    end

    function this:draw()
        love.graphics.setColor(this.color)
        if this.life == 2 then
            love.graphics.setLineWidth(1)
            love.graphics.circle("line", this.x, this.y, this.radius, 6)
            love.graphics.setLineWidth(2)
            love.graphics.circle("line", this.x, this.y, this.radius/2, 6)
        else
            love.graphics.setLineWidth(2)
            love.graphics.circle("line", this.x, this.y, this.radius, 6)
        end
    end

    return this
end