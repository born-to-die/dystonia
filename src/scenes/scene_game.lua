---@class GameScene
---@field objectsRender ObjectsRender
---@field MAP_RIGHT_BORDER number
---@field MAP_LEFT_BORDER number
---@field events EventAbstract[]
---@field mobs Mob[]
GameScene = {};

Extended(GameScene, Scene)

GameScene.player = nil
GameScene.playerControl = nil
GameScene.playerRender = nil
GameScene.backgroundRender = nil
GameScene.objectsRender = nil
GameScene.mobsRender = nil
GameScene.wall = nil
GameScene.walls = {}
GameScene.items = {}
GameScene.objects = {}
GameScene.events = {}
GameScene.mobs = {}
GameScene.spawnEvent = nil
GameScene.inventory = nil
GameScene.inGameTime = 0

GameScene.SX = 1 -- scale on X axis
GameScene.SY = 1 -- scale on Y axis
GameScene.PX = GFX_TILE_SIZE_PX / 2 * GameScene.SX * 9 -- padding on x axis
GameScene.PY = GFX_TILE_SIZE_PX / 2 * GameScene.SY -- padding on x axis
GameScene.DT = 0 -- delta time

GameScene.MAP_RIGHT_BORDER = GameScene.PX + 10 * GFX_TILE_SIZE_PX - GFX_TILE_SIZE_PX / 2
GameScene.MAP_LEFT_BORDER = GameScene.PX + GFX_TILE_SIZE_PX / 2
GameScene.MAP_TOP_BORDER = GameScene.PY + GFX_TILE_SIZE_PX / 2
GameScene.MAP_BOTTOM_BORDER = GameScene.PY + 10 * GFX_TILE_SIZE_PX - GFX_TILE_SIZE_PX / 2

GameScene.FONT_DEFAULT = love.graphics.newFont(12)
GameScene.FONT_MEDIUM = love.graphics.newFont(24)

function GameScene:load()

  math.randomseed(os.time())
  love.graphics.setFont(GameScene.FONT_DEFAULT)

  self.scaleX = 1 --love.graphics.getWidth() * GFX_DEFAULT_SCALE_IMAGE / 1280
  self.scaleY = 1 --love.graphics:getHeight() * GFX_DEFAULT_SCALE_IMAGE / 720

  self.px = GFX_TILE_SIZE_PX / 2 * self.scaleX * 9
  self.py = GFX_TILE_SIZE_PX / 2 * self.scaleY

  self.player = Player:create(1, 1, self.px + 96, self.py + 96, self.scaleX, self.scaleY)
  
  self.playerControl = PlayerControl:create()
  self.inventory = Inventory:create()
  
  self.itemsRender = ItemsRender:create()
  self.mobsRender = MobsRender:create()
  self.playerRender = PlayerRender:create()
  self.backgroundRender = BackgroundRender:create()
  self.wallRender = WallRender:create()
  self.inventoryRender = InventoryRender:create()
  self.objectsRender = ObjectsRender:create()

  self.collisionChecker = CollisionChecker:create()

  self.spawnEvent = SpawnEvent:create()
  self.spawnEvent.init(self.walls, self.player, self.objects)

  table.insert(self.walls, Wall:create(5, 5, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(6, 6, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(4, 7, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(5, 7, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(6, 7, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(6, 5, self.px, self.py, self.scaleX, self.scaleY))
  table.insert(self.walls, Wall:create(4, 6, self.px, self.py, self.scaleX, self.scaleY))

  -- ITEMS
  table.insert(self.items, BeaconMapItem:create(0, 0))
  table.insert(self.items, BeaconMapItem:create(2, 2))
  table.insert(self.items, BeaconMapItem:create(3, 4))

  -- OBJECTS
  table.insert(self.objects, BeaconObject:create(1, 1))

  -- EVENTS
  table.insert(self.events, WallSpawnerEvent:create(self.walls, self.player, self.objects, self.items))
  table.insert(self.events, CrateSpawnerEvent:create(self.walls, self.player, self.objects))

  table.insert(self.mobs, SlimeMob:create(5, 1))
end

function GameScene:update()

  local deltaTime = love.timer.getDelta()
  GameScene.DT = deltaTime

  -- PLAYER CONTROL AND MOVEMENT
  -- TODO Move to special class

  self.playerControl:update(self.player, deltaTime, self.items, self.inventory)

  self.player.x = self.player.x + self.player.vector:getSpeedX() * GameScene.DT
  self.player.y = self.player.y + self.player.vector:getSpeedY() * GameScene.DT

  for i = 1, #self.walls do
    local isC = self.collisionChecker:isPointInRect(self.walls[i], self.player)

    if isC == true then
      self.player.vector:invert()
      self.player.x = self.player.x + self.player.vector:getSpeedX() * GameScene.DT
      self.player.y = self.player.y + self.player.vector:getSpeedY() * GameScene.DT
      break
    end
  end

  self.player.worldX = math.floor((self.player.x - self.px) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE))
  self.player.worldY = math.floor((self.player.y - self.py) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE))

  self.player.vector:reset()

  for i = 1, #self.mobs do

    if self.mobs[i].alive == false then
      goto continue
    end

    self.mobs[i]:update()

    local newX = self.mobs[i].x + self.mobs[i].vector:getSpeedX() * GameScene.DT
    local newY = self.mobs[i].y + self.mobs[i].vector:getSpeedY() * GameScene.DT

    if 
      newX > GameScene.MAP_RIGHT_BORDER
      or newX < GameScene.MAP_LEFT_BORDER
      or newY > GameScene.MAP_BOTTOM_BORDER
      or newY < GameScene.MAP_TOP_BORDER
    then
      goto continue
    end

    self.mobs[i].x = self.mobs[i].x + self.mobs[i].vector:getSpeedX() * GameScene.DT
    self.mobs[i].y = self.mobs[i].y + self.mobs[i].vector:getSpeedY() * GameScene.DT

    for j = 1, #self.walls do
      local isC = self.collisionChecker:isPointInRect(self.walls[j], self.mobs[i])
  
      if isC == true then
        self.mobs[i].vector:invert()
        self.mobs[i].x = self.mobs[i].x + self.mobs[i].vector:getSpeedX() * GameScene.DT
        self.mobs[i].y = self.mobs[i].y + self.mobs[i].vector:getSpeedY() * GameScene.DT
        break
      end
    end
    ::continue::
  end

  -- EVENTS
  for i = 1, #self.events do
    self.events[i]:update()
  end
end

function GameScene:render()
    self.backgroundRender:render(self.player, self.px, self.py, self.scaleX, self.scaleY)
  
    self.itemsRender:render(self.items)

    self.objectsRender:render(self.objects)

    self.playerRender:render(self.player, self.px, self.py, self.scaleX, self.scaleY)

    self.mobsRender:render(self.mobs)
    
    self.wallRender:render(self.walls, self.scaleX, self.scaleY)

    self.inventoryRender:render(self.inventory)
end

function GameScene:keypressed(key)
  self.playerControl:keypressed(key, self.player, self.inventory, self.items, self.objects)
end

function GameScene:wheelmoved(x, y)
  self.playerControl:wheelmoved(x, y, self.inventory)
end