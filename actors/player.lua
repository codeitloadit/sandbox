module(..., package.seeall)

function create(x, y)
    local this = {}
    this.x = x or 0
    this.y = y or 0
    this.radius = 7
    this.angle = -1
    this.speed = 4
    this.color = {255, 102, 255}
    this.bulletAngle = 0

    -- Physics
    this.body = love.physics.newBody(world, this.x, this.y, "dynamic")
    this.shape = love.physics.newCircleShape(this.radius)
    this.fixture = love.physics.newFixture(this.body, this.shape, 1)
    -- this.fixture:setRestitution(0.9)

    function this:update()
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
        love.graphics.setLineWidth(2)
        love.graphics.circle("line", this.x, this.y, this.radius, 6)
        -- love.graphics.circle("line", this.body:getX(), this.body:getY(), this.shape:getRadius())
    end

    return this
end