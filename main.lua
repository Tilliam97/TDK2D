local Player = require 'Player'

function love.load()

  camera = require 'libraries/camera'
  cam = camera()

  --anim8 = require 'libraries/anim8' MOVED TO Player

  sti = require 'libraries/sti'
  gameMap = sti('maps/Tutorial_map.lua')

 
  world:addCollisionClass('World')
  world:addCollisionClass('Player')

  bounds = {}
  --vertices = {}
  if gameMap.layers["Tree_Bounds"] then
    for i, obj in pairs(gameMap.layers["Tree_Bounds"].objects) do
      local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height) 
      wall:setType('static')
      wall:setCollisionClass('World'--[[,{ignores = {'Player'}}]])
      table.insert(bounds, wall)
    end
  end

  if gameMap.layers["Cliff_Bounds"] then
      for j, obj in pairs(gameMap.layers["Cliff_Bounds"].objects) do
        if obj.shape == "rectangle" then
          local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
          wall:setType('static')
          table.insert(bounds, wall)
          wall:setCollisionClass('World')
        end
      end
    end

    -- if gameMap.layers["Cliff_Bounds"] then
    --   for j, obj in ipairs( gameMap.layers["Cliff_Bounds"].objects) do
    --     if obj.polygon and (obj.name == "cliff_1" or obj.name == "cliff_2") then
    --       local vertices = {}
    --       for k, point in pairs(obj.polygon) do
    --         table.insert(vertices, point.x)
    --         table.insert(vertices, point.y)
    --       end
    --       local cliff = world:newPolygonCollider(vertices)
    --        cliff:setType('static')
           --table.insert(bounds, vertices)

          -- elseif obj.polygon and obj.name == "cliff_2" then
          --   --local vertices_2 = {}
          --   for k, point in pairs(obj.polygon) do
          --     table.insert(vertices, point.x)
          --     table.insert(vertices, point.y)
          -- end
          -- local cliff = world:newPolygonCollider(vertices)
          --  cliff:setType('static')
            --local cliff = world:newPolygonCollider(vertices)
    --     end
    --   end
    -- end

    if gameMap.layers["Camp_Bounds"] then
      for l, obj in pairs(gameMap.layers["Camp_Bounds"].objects) do
        if obj.ellipse then
          --Convert to circle 
          local centerX = obj.x + obj.width / 2
          local centerY = obj.y + obj.height / 2
          local diameter = (67.6923 + 42.3077) / 2 --nums aren't arbitrary got from tiled map data for Camp_Bounds

          local camp = world:newCircleCollider(centerX, centerY, diameter/2) 
          camp:setType('static')
          table.insert(bounds, camp)
          camp:setCollisionClass('World')
        end
      end
    end

    

    --world:draw() --draws debug collisions

  love.graphics.setDefaultFilter("nearest", "nearest")

  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  player = Player:new(--[[player.x]]width*0.5, --[[player.y]]height*0.5, --[[speed]]250)
 
  --background = love.graphics.newImage('sprites/background.png')
end 



function love.update(dt)
  player:update(dt)
  

  playerLoc = cam:lookAt(player.x, player.y)
  
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

--  --MINI MAP
-- mapSize = 250

-- local scaleX = mapSize / mapWidth
-- local scaleY = mapSize / mapHeight
-- local scale = math.min(scaleX, scaleY)  -- maintain aspect ratio

-- canvas = love.graphics.newCanvas(mapSize, mapSize)
-- love.graphics.setCanvas(canvas)
--   love.graphics.clear()

--   love.graphics.push()
--   love.graphics.scale(scale, scale)

--   for _, layer in ipairs(gameMap.layers) do 
--     if layer.type == "tilelayer" then
--       --gameMap:drawLayer(gameMap.layers["Cliff"])
--       gameMap:drawLayer(gameMap.layers[layer.name])
--     end
--   end

--   love.graphics.circle("fill", player.x + 16, player.y + 16 , 2 / scale)

--   love.graphics.pop()

-- love.graphics.setCanvas()
end



function love.draw()
--How to get access to the layers in the group
-- local y = 10
-- for k,v in pairs(gameMap.layers) do
--   love.graphics.print(string.format("%s (%s)", k, v.type), 10, y)
--   y = y + 20
--   --debug.debug()
-- end



  cam:attach()
    --   for y = 0, height - 1, background:getHeight() do         [[loops over an image to display it as the background over the entire window size]] --debugging logic 
    --     for x = 0, width -1, background:getWidth() do
    --     love.graphics.draw(background, x, y)
    --   end
    -- end
    

    gameMap:drawLayer(gameMap.layers["Ground"])
    gameMap:drawLayer(gameMap.layers["Shade"])
    gameMap:drawLayer(gameMap.layers["Trees.Shade"])
    gameMap:drawLayer(gameMap.layers["Trees.Grass"])
    gameMap:drawLayer(gameMap.layers["Cliff"])
    --gameMap:drawLayer(gameMap.layers["Cliff_Shade"])
    gameMap:drawLayer(gameMap.layers["Camp"])
    gameMap:drawLayer(gameMap.layers["Bridge_Exit"])
    gameMap:drawLayer(gameMap.layers["Cobble_Exit"])
    player:draw()
    gameMap:drawLayer(gameMap.layers["Trees.Trees_1"])
    --love.graphics.draw(background, 0, 0)
    --player.anim:draw(player.spriteSheet, player.x, player.y, nil, 2, nil, --[[offset x , offset y]] 21, 24)
    -- love.window.setFullscreen(true) makes the game fullscreen
  cam:detach()

  -- MINI MAP DRAW
  -- draw the minimap in screen corner (e.g., top-right)
  --love.graphics.setColor(1, 1, 1, 1)
  --love.graphics.draw(canvas, love.graphics.getWidth() - mapSize - 10, 10)
  --love.graphics.print(string.format("%s (%s)", player.x, player.y))
  --love.graphics.print(string.format("%s (%s)", player.y, 80, 50))
end
