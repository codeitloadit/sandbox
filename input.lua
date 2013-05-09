module(..., package.seeall)

function handle(dt)

	-- Player movement.
    player.angle = -1
    if love.keyboard.isDown("w") and love.keyboard.isDown("d") then
        player.angle = 315
    elseif love.keyboard.isDown("w") and love.keyboard.isDown("a") then
        player.angle = 225
    elseif love.keyboard.isDown("s") and love.keyboard.isDown("d") then
        player.angle = 45
    elseif love.keyboard.isDown("s") and love.keyboard.isDown("a") then
        player.angle = 135
    elseif love.keyboard.isDown("w") then
        player.angle = 270
    elseif love.keyboard.isDown("s") then
        player.angle = 90
    elseif love.keyboard.isDown("a") then
        player.angle = 180
    elseif love.keyboard.isDown("d") then
        player.angle = 0
    end

    -- Fire bullets.
    local alphaLimit = 240
    if love.keyboard.isDown("up") and love.keyboard.isDown("right") then
        	player.bulletAngle = 315
    elseif love.keyboard.isDown("up") and love.keyboard.isDown("left") then
        	player.bulletAngle = 225
    elseif love.keyboard.isDown("down") and love.keyboard.isDown("right") then
        	player.bulletAngle = 45
    elseif love.keyboard.isDown("down") and love.keyboard.isDown("left") then
        	player.bulletAngle = 135
    elseif love.keyboard.isDown("up") then
        	player.bulletAngle = 270
    elseif love.keyboard.isDown("down") then
        	player.bulletAngle = 90
    elseif love.keyboard.isDown("left") then
        	player.bulletAngle = 180
    elseif love.keyboard.isDown("right") then
        player.bulletAngle = 0
    end

    if love.keyboard.isDown(",") then
        player.bulletAngle = player.bulletAngle - 3
    end
    if love.keyboard.isDown(".") then
        player.bulletAngle = player.bulletAngle + 3
    end
    if love.keyboard.isDown(",") or love.keyboard.isDown(".") or love.keyboard.isDown("up") or love.keyboard.isDown("down") or love.keyboard.isDown("left") or love.keyboard.isDown("right") then
        if #bullets == 0 or bullets[#bullets].color[4] <= alphaLimit then
        	bullets[#bullets+1] = Bullet.create(player.x, player.y, player.bulletAngle)
        end
    end

    -- Drop bombs.
    local bomdDelay = 25
    if love.keyboard.isDown(" ") then
        if #bombs == 0 or bombs[#bombs].time <= bomdDelay then
	    	bombs[#bombs+1] = Bomb.create(player.x, player.y)
    	end
    end

    -- Spawn enemy
    local enemyBuffer = 200
    if love.keyboard.isDown("rshift") then
    	Enemy.spawnEnemy()
    end

    -- Physics test.
	if love.keyboard.isDown("e") then --press the right arrow key to push the ball to the right
		player.body:applyForce(5, 0)
	elseif love.keyboard.isDown("q") then --press the left arrow key to push the ball to the left
		player.body:applyForce(-5, 0)
	elseif love.keyboard.isDown("x") then --press the up arrow key to set the ball in the air
		player.body:setPosition(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
	end

end