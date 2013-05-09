module(..., package.seeall)

function distanceBetweenPoints(a, b)
	return math.sqrt((a.x - b.x ) * ( a.x - b.x) + (a.y - b.y) * (a.y - b.y));
end

function areCirclesColliding(a, b)
	return distanceBetweenPoints(a, b) <= a.radius + b.radius;
end

function handle()
	-- Bullets and enemies.
    for i, bullet in ipairs(bullets) do
        for j, enemy in ipairs(enemies) do
            if collision.areCirclesColliding(bullet, enemy) then
            	if enemy.life == 2 then
            		enemy.life = 1
            		enemy.radius = enemy.radius/2 
            	else
	                table.remove(enemies, j)
	                Enemy.spawnEnemy()
	                Enemy.spawnEnemy()
	            end
                table.remove(bullets, i)
            end
        end
    end

	-- Bombs and enemies.
    for i, bomb in ipairs(bombs) do
        for j, enemy in ipairs(enemies) do
            if collision.areCirclesColliding(bomb, enemy) then
            	if enemy.life == 2 then
            		enemy.life = 1
            		enemy.radius = enemy.radius/2 
            	else
	                table.remove(enemies, j)
	                Enemy.spawnEnemy()
	            end
            end
        end
    end

	-- Playe and enemies.
    for i, enemy in ipairs(enemies) do
        if collision.areCirclesColliding(player, enemy) then
        	player.color = {255, 0, 0}
        end
    end
end