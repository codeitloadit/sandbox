module(..., package.seeall)

BULLET_FIRE_SND = love.sound.newSoundData("bullet_fire.wav")

function create(x, y, angle)
    TEsound.play(BULLET_FIRE_SND)
    local this = {}
    this.x = x or 0
    this.y = y or 0
    this.angle = angle or -1
    this.radius = 2
    this.speed = 10
    this.color = {255, 255, 102, 255}

    function this:update()
        this.x = this.x + math.cos(math.rad(this.angle)) * this.speed;
        this.y = this.y + math.sin(math.rad(this.angle)) * this.speed;

        -- Fade away broken.
        this.color[4] = this.color[4] - 3
        if this.color[4] <= 0 then
            table.remove(bullets, 1)
        end
    end

    function this:draw()
        love.graphics.setColor(this.color)
        love.graphics.setLineWidth(2)
        love.graphics.circle("line", this.x, this.y, this.radius, 6)
    end

    return this
end