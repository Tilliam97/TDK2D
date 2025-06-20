class = require 'libraries/middleclass'
anim8 = require 'libraries/anim8'
wf = require 'libraries/windfield'

world = wf.newWorld(0,0)

local Player = class('Player')

function Player:initialize(x, y, speed)
  self.collider = world:newBSGRectangleCollider(400, 250, 42, 80, 11)
  self.collider:setFixedRotation(true)
  self.x = math.floor(x)
  self.y = math.floor(y)
  self.speed = speed
  --p.sprite = love.graphics.sprite
  self.spriteSheet = love.graphics.newImage('sprites/rogue_sat.png')
  self.grid = anim8.newGrid(24, 21, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())

  self.grid = anim8.newGrid(42, 48, self.spriteSheet:getWidth(), self.spriteSheet:getHeight(), 0, 0, 1.2)

  self.animations = {}
  self.animations.up = anim8.newAnimation(self.grid('1-3', 4), 0.20)
  self.animations.down = anim8.newAnimation(self.grid('1-3', 1), 0.20)
  self.animations.left = anim8.newAnimation(self.grid('1-3', 2), 0.20)
  self.animations.right = anim8.newAnimation(self.grid('1-3', 3), 0.20) 

  self.anim = self.animations.down
end

function Player:update(dt)
  local isMoving = false

  local vx = 0 --collider velocity x direction
  local vy = 0 --collider velocity y direction

  if love.keyboard.isDown("right") then 
    isMoving = true
    vx = self.speed
    self.anim = self.animations.right
  end
  if love.keyboard.isDown("left") then
    isMoving = true 
    vx = -self.speed
    self.anim = self.animations.left
  end
  if love.keyboard.isDown("up") then 
    isMoving = true
    vy = -self.speed
    self.anim = self.animations.up
  end
  if love.keyboard.isDown("down") then 
    isMoving = true
    vy = self.speed
    self.anim = self.animations.down
  end

  self.collider:setLinearVelocity(vx, vy)

  if isMoving == false then
    self.anim:gotoFrame(2)
  end

  world:update(dt)
  self.x = math.floor(self.collider:getX())
  self.y = math.floor(self.collider:getY())

  self.anim:update(dt)
end

function Player:draw()
   self.anim:draw(self.spriteSheet, self.x, self.y, nil, 2, nil, --[[offset x , offset y]] 21, 24)
   world:draw()
end

return Player