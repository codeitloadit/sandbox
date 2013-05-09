module(..., package.seeall)

BOMB_DROP_SND = love.sound.newSoundData("bomb_explode.wav")

function create(x, y)
    local this = {}
    this.x = x or 0
    this.y = y or 0
    this.radius = 4
    this.color = {255, 102, 102, 255}
    this.time = 50
    this.segments = 6

    function this:update()
        this.time = this.time - 1
        if this.time == 0 then 
            TEsound.play(BOMB_DROP_SND)
            this.segments = 12
        end
        if this.time < 0 then
            this.radius = this.radius + 5 
            this.color[4] = this.color[4] - 5
            if this.color[4] <= 0 then
                table.remove(bombs, 1)
            end
        end
    end

    function this:draw()
        love.graphics.setColor(this.color)
        love.graphics.setLineWidth(2)
        love.graphics.circle("line", this.x, this.y, this.radius, this.segments)
    end

    return this
end