function love.load()
  anim8 = require 'libraries/anim8'
  love.graphics.setDefaultFilter("nearest", "nearest")

  player = {}
  player.x = 400
  player.y = 200
  player.speed = 3
  --player.sprite = love.graphics.sprite
  player.spriteSheet = love.graphics.newImage('sprites/rogue.png')
  player.grid = anim8.newGrid(32, 37, player.spriteSheet:getWidth(), player.spriteSheet:getHeight(), 0, 0, 1)
  player.animations = {}
  player.animations.up = anim8.newAnimation(player.grid('1-3', 4), 0.20)
  player.animations.down = anim8.newAnimation(player.grid('1-3', 1), 0.20)
  player.animations.left = anim8.newAnimation(player.grid('1-3', 2), 0.20)
  player.animations.right = anim8.newAnimation(player.grid('1-3', 3), 0.20) 

  player.anim = player.animations.left

  background = love.graphics.newImage('sprites/background.png')
end 

function love.update(dt)
  if love.keyboard.isDown("right") then 
    player.x = player.x + player.speed
    player.anim = player.animations.right
  end
  if love.keyboard.isDown("left") then 
    player.x = player.x - player.speed
    player.anim = player.animations.left
  end
  if love.keyboard.isDown("up") then 
    player.y = player.y - player.speed
    player.anim = player.animations.up
  end
  if love.keyboard.isDown("down") then 
    player.y = player.y + player.speed
    player.anim = player.animations.down
  end

  player.anim:update(dt)
end

function love.draw()
  love.graphics.draw(background, 0, 0)
  player.anim:draw(player.spriteSheet, player.x, player.y, nil, 3)
  -- love.window.setFullscreen(true) makes the game fullscreen
end
