<<<<<<< HEAD
function love.load()
  anim8 = require 'libraries/anim8'

  player = {}
  player.x = 400
  player.y = 200
  player.speed = 3
  --player.sprite = love.graphics.sprite
  player.spriteSheet = love.graphics.newImage('sprites/Swordsman.png')
  background = love.graphics.newImage('sprites/background.png')
  player.grid = anim8.newGrid(24, 21, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())
end 

function love.update(dt)
  if love.keyboard.isDown("right") then 
    player.x = player.x + player.speed
  end
  if love.keyboard.isDown("left") then 
    player.x = player.x - player.speed
  end
  if love.keyboard.isDown("up") then 
    player.y = player.y - player.speed
  end
  if love.keyboard.isDown("down") then 
    player.y = player.y + player.speed
  end
end

function love.draw()
  love.graphics.circle("fill", player.x, player.y, 90)
  -- love.window.setFullscreen(true) makes the game fullscreen
end
=======
function love.load()
  player = {}
  player.x = 400
  player.y = 200
  player.speed = 5
end

function love.update(dt)
  if love.keyboard.isDown("up") then 
    player.y = player.y - player.speed
  end

  if love.keyboard.isDown("down") then
    player.y = player.y + player.speed
  end

  if love.keyboard.isDown("left") then 
    player.x = player.x - player.speed
  end

  if love.keyboard.isDown("right") then 
    player.x = player.x + player.speed
  end

end

function love.draw()
  love.graphics.circle("fill", player.x, player.y,100)
end
>>>>>>> 60e24aee5bf9c55c332a08f26f7b97561666238b
