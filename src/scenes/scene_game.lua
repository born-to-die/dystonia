GameScene = {};

Extended(GameScene, Scene)

GameScene.player = nil
GameScene.playerControl = nil
GameScene.playerRender = nil
GameScene.backgroundRender = nil
GameScene.wall = nil
GameScene.walls = {}

function newTimer(time,callback)
  local expired = false
  local timer = {}
  
  function timer.update(dt)
       if time < 0 then
             expired = true
             callback()
       end
       time = time - dt         
  end

  function timer.isExpired()
      return expired
  end

  return timer
end

function GameScene:load()

  self.myTimer = newTimer(1 , function() 
    print("Your timer is due!")

    local wx = math.random(10)
    local wy = math.random(10)

    table.insert(self.walls, Wall:create(wx, wy, self.px, self.py, self.scaleX, self.scaleY))

    end
  )

  self.scaleX = 4 --love.graphics.getWidth() * GFX_DEFAULT_SCALE_IMAGE / 1280
  self.scaleY = 4 --love.graphics:getHeight() * GFX_DEFAULT_SCALE_IMAGE / 720

  self.px = 16 / 2 * self.scaleX * 9
  self.py = 16 / 2 * self.scaleY

  self.player = Player:create(1, 1, self.px + 32, self.py + 32, self.scaleX, self.scaleY)
  
  self.playerControl = PlayerControl:create()
  
  self.playerRender = PlayerRender:create()
  self.backgroundRender = BackgroundRender:create()

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
    self.myTimer = newTimer(1 , function() 
      print("Your timer is due!")
  
      local wx = math.random(10)
      local wy = math.random(10)
  
      table.insert(self.walls, Wall:create(wx, wy, self.px, self.py, self.scaleX, self.scaleY))
  
      end
    )
  end
  
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
    
    for i = 1, #self.walls do
      love.graphics.draw(
        self.walls[i].sprite,
        self.walls[i].x,
        self.walls[i].y,
        0, 
        self.scaleX, self.scaleY
        -- self.walls[i].sprite:getWidth() / 2, self.walls[i].sprite:getHeight() / 2
    )
    end
end
