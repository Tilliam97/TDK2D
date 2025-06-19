function love.load()
  anim8 = require 'libraries/anim8'
  love.graphics.setDefaultFilter("nearest", "nearest")

  player = {}
  player.x = 400
  player.y = 200
  player.speed = 3
  --player.sprite = love.graphics.sprite
  --player.spriteSheet = love.graphics.newImage('sprites/rogue_sat.png')
  player.spriteSheet = love.graphics.newImage('sprites/rogue_sat.png')
  --player.grid = anim8.newGrid(325, 380, player.spriteSheet:getWidth(), player.spriteSheet:getHeight(), 0, 0, 6)
  player.grid = anim8.newGrid(42, 48, player.spriteSheet:getWidth(), player.spriteSheet:getHeight(), 0, 0, 1.2)

  player.animations = {}
  player.animations.up = anim8.newAnimation(player.grid('1-3', 4), 0.20)
  player.animations.down = anim8.newAnimation(player.grid('1-3', 1), 0.20)
  player.animations.left = anim8.newAnimation(player.grid('1-3', 2), 0.20)
  player.animations.right = anim8.newAnimation(player.grid('1-3', 3), 0.20) 

  player.anim = player.animations.down

  background = love.graphics.newImage('sprites/background.png')
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
end 

function love.update(dt)
  local isMoving = false

  if love.keyboard.isDown("right") then 
    isMoving = true
    player.x = player.x + player.speed
    player.anim = player.animations.right
  end
  if love.keyboard.isDown("left") then
    isMoving = true 
    player.x = player.x - player.speed
    player.anim = player.animations.left
  end
  if love.keyboard.isDown("up") then 
    isMoving = true
    player.y = player.y - player.speed
    player.anim = player.animations.up
  end
  if love.keyboard.isDown("down") then 
    isMoving = true
    player.y = player.y + player.speed
    player.anim = player.animations.down
  end
  if isMoving == false then
    player.anim:gotoFrame(2)
  end

  player.anim:update(dt)
end

function love.draw()
    for y = 0, height - 1, background:getHeight() do
      for x = 0, width -1, background:getWidth() do
      love.graphics.draw(background, x, y)
    end
  end
  --love.graphics.draw(background, 0, 0)
  player.anim:draw(player.spriteSheet, player.x, player.y, nil, 2)
  -- love.window.setFullscreen(true) makes the game fullscreen
end
