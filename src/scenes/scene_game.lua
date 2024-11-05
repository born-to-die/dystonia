GameScene = {};

Extended(GameScene, Scene)

GameScene.player = nil
GameScene.playerControl = nil
GameScene.playerRender = nil
GameScene.backgroundRender = nil
GameScene.wall = nil
GameScene.walls = {}


function GameScene:load()

  self.myTimer = TIMER(1 , function() 
    local wx = math.random(10)
    local wy = math.random(10)

    table.insert(self.walls, Wall:create(wx, wy, self.px, self.py, self.scaleX, self.scaleY))

    end
  )

  self.scaleX = 1 --love.graphics.getWidth() * GFX_DEFAULT_SCALE_IMAGE / 1280
  self.scaleY = 1 --love.graphics:getHeight() * GFX_DEFAULT_SCALE_IMAGE / 720

  self.px = GFX_TILE_SIZE_PX / 2 * self.scaleX * 9
  self.py = GFX_TILE_SIZE_PX / 2 * self.scaleY

  self.player = Player:create(1, 1, self.px + 96, self.py + 96, self.scaleX, self.scaleY)
  
  self.playerControl = PlayerControl:create()
  
  self.playerRender = PlayerRender:create()
  self.backgroundRender = BackgroundRender:create()
  self.wallRender = WallRender:create()

  self.collisionChecker = CollisionChecker:create()

  table.insert(self.walls, Wall:create(5, 5, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(6, 6, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(4, 7, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(5, 7, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(6, 7, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(6, 5, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(4, 6, self.px, self.py, self.scaleX, self.scaleY))
end

function GameScene:update()

  local deltaTime = love.timer.getDelta()

  if not self.myTimer.isExpired() then 
    self.myTimer.update(deltaTime)
  else
    self.myTimer = TIMER(1 , function() 
      print("Your timer is due!")
  
      local wx = math.random(10)
      local wy = math.random(10)
  
      table.insert(self.walls, Wall:create(wx, wy, self.px, self.py, self.scaleX, self.scaleY))
  
      end
    )
  end

  -- PLAYER CONTROL AND MOVEMENT
  -- TODO Move to special class

  self.playerControl:update(self.player, deltaTime)

  self.player.x = self.player.x + self.player.vector:getSpeedX()
  self.player.y = self.player.y + self.player.vector:getSpeedY()

  for i = 1, #self.walls do
    local isC = self.collisionChecker:isPointInRect(self.walls[i], self.player)

    if isC == true then
      self.player.vector.invert(5)
      self.player.x = self.player.x + self.player.vector:getSpeedX()
      self.player.y = self.player.y + self.player.vector:getSpeedY()
      break
    end
  end  

  self.player.vector:reset()
end

function GameScene:render()
    self.backgroundRender:render(self.player, self.px, self.py, self.scaleX, self.scaleY)
  
    self.playerRender:render(self.player, self.px, self.py, self.scaleX, self.scaleY)
    
    self.wallRender:render(self.walls, self.scaleX, self.scaleY)
end
