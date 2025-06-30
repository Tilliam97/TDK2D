local Player = require 'Player'

function love.load()

  camera = require 'libraries/camera'
  cam = camera()

  --anim8 = require 'libraries/anim8'

  sti = require 'libraries/sti'
  gameMap = sti('maps/Tutorial_map.lua')

  love.graphics.setDefaultFilter("nearest", "nearest")

  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  player = Player:new(--[[player.x]]width*0.5, --[[player.y]]height*0.5, --[[speed]]250)
  -- player = {}
  -- player.x = width / 2
  -- player.y = height / 2
  -- player.speed = 500
  -- --player.sprite = love.graphics.sprite
  -- --player.spriteSheet = love.graphics.newImage('sprites/rogue_sat.png')
  -- player.spriteSheet = love.graphics.newImage('sprites/rogue_sat.png')
  -- --player.grid = anim8.newGrid(325, 380, player.spriteSheet:getWidth(), player.spriteSheet:getHeight(), 0, 0, 6)
  -- player.grid = anim8.newGrid(42, 48, player.spriteSheet:getWidth(), player.spriteSheet:getHeight(), 0, 0, 1.2)

  -- player.animations = {}
  -- player.animations.up = anim8.newAnimation(player.grid('1-3', 4), 0.20)
  -- player.animations.down = anim8.newAnimation(player.grid('1-3', 1), 0.20)
  -- player.animations.left = anim8.newAnimation(player.grid('1-3', 2), 0.20)
  -- player.animations.right = anim8.newAnimation(player.grid('1-3', 3), 0.20) 

  -- player.anim = player.animations.down

  --background = love.graphics.newImage('sprites/background.png')
end 

function love.update(dt)
  player:update(dt)
  -- local isMoving = false

  -- if love.keyboard.isDown("right") then 
  --   isMoving = true
  --   player.x = player.x + player.speed
  --   player.anim = player.animations.right
  -- end
  -- if love.keyboard.isDown("left") then
  --   isMoving = true 
  --   player.x = player.x - player.speed
  --   player.anim = player.animations.left
  -- end
  -- if love.keyboard.isDown("up") then 
  --   isMoving = true
  --   player.y = player.y - player.speed
  --   player.anim = player.animations.up
  -- end
  -- if love.keyboard.isDown("down") then 
  --   isMoving = true
  --   player.y = player.y + player.speed
  --   player.anim = player.animations.down
  -- end
  -- if isMoving == false then
  --   player.anim:gotoFrame(2)
  -- end

  -- player.anim:update(dt)

  cam:lookAt(player.x, player.y)
  
  local halfW = width / 2 
  local halfH = height / 2

  
  if cam.x < halfW then
    cam.x = halfW
  end
  
  if cam.y < halfH then
    cam.y = halfH
  end
  
  local mapWidth = gameMap.width * gameMap.tilewidth
  local mapHeight = gameMap.height * gameMap.tileheight
  
  --Right Border Camera Buffer
  if cam.x > (mapWidth - width/2) then
    cam.x = math.floor((mapWidth - width/2))
  end
  
  --Bottom Border Camera Buffer
  if cam.y > (mapHeight - height/2) then
    cam.y = math.floor((mapHeight - height/2))
  end
end

function love.draw()
--How to get access to the layers in the group
-- local y = 10
-- for k,v in pairs(gameMap.layers) do
--   love.graphics.print(string.format("%s (%s)", k, v.type), 10, y)
--   y = y + 20
  --debug.debug()
-- end

  cam:attach()
    --   for y = 0, height - 1, background:getHeight() do  [[loops over an image to display it as the background over the entire window size]]
    --     for x = 0, width -1, background:getWidth() do
    --     love.graphics.draw(background, x, y)
    --   end
    -- end
    -- gameMap:drawLayer(gameMap.layers["Ground"])
    -- gameMap:drawLayer(gameMap.layers["Trees.Trees_1"])
    -- gameMap:drawLayer(gameMap.layers["Trees.Trees_2"])
    -- gameMap:drawLayer(gameMap.layers["Trees.Trees_3"])     starter Map
    -- gameMap:drawLayer(gameMap.layers["Trees.Trees_4"])
    -- gameMap:drawLayer(gameMap.layers["Trees.Trees_5"])
    -- gameMap:drawLayer(gameMap.layers["Shrubs"])
    -- gameMap:drawLayer(gameMap.layers["Shrubs_2"])
    -- gameMap:drawLayer(gameMap.layers["Camp"])
    -- gameMap:drawLayer(gameMap.layers["Bridge"])

    gameMap:drawLayer(gameMap.layers["Ground"])
    gameMap:drawLayer(gameMap.layers["Shade"])
    player:draw()
    gameMap:drawLayer(gameMap.layers["Trees.Trees_1"])
    gameMap:drawLayer(gameMap.layers["Trees.Shade"])
    gameMap:drawLayer(gameMap.layers["Trees.Grass"])
    gameMap:drawLayer(gameMap.layers["Cliff"])
    gameMap:drawLayer(gameMap.layers["Cliff_Shade"])
    gameMap:drawLayer(gameMap.layers["Camp"])
    gameMap:drawLayer(gameMap.layers["Bridge_Exit"])
    gameMap:drawLayer(gameMap.layers["Cobble_Exit"])
    --love.graphics.draw(background, 0, 0)
    --player.anim:draw(player.spriteSheet, player.x, player.y, nil, 2, nil, --[[offset x , offset y]] 21, 24)
    -- love.window.setFullscreen(true) makes the game fullscreen
  cam:detach()
end
