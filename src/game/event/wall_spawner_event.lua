---@class WallSpawnerEvent
WallSpawnerEvent = {}

---@param walls Wall[]
---@param player Player
---@param objects Object[]
---@param items MapItem[]
---@param mobs Mob[]
function WallSpawnerEvent:create(
  walls,
  player,
  objects,
  items,
  mobs
  )

  local obj = EventAbstract:create(walls, player, objects, items, inGameTime)

  -- properties

  obj.interval = 3
  obj.chance = 0.25
  obj.tileChecker = TileChecker:create()
  obj.mathService = MathService:create()

  function obj.update()
    if not obj.timer.isExpired() then
      obj.timer.update(GameScene.DT)
    else
      player.foodSaturation = player.foodSaturation - 1
      GameScene.inGameTime = GameScene.inGameTime + 1
      obj.timer = TIMER(obj.interval, obj.check)
    end
  end

  -- methods

  function obj.run()

    for i = 1, 5, 1 do
      local wx = math.random(10) - 1
      local wy = math.random(10) - 1

      local isFreeFromWalls = obj.tileChecker:isFreeTileForList(wx, wy, walls)

      if isFreeFromWalls == false then
        break
      end

      local isFreeFromItems = obj.tileChecker:isFreeTileForList(wx, wy, items)

      if isFreeFromItems == false then
        break
      end

      local isFreeFromPlayer = obj.tileChecker:isFreeTileForObject(wx, wy, player)

      if isFreeFromPlayer == false then
        break
      end

      local isFreeFromMobs = obj.tileChecker:isFreeTileFromMobs(wx, wy, mobs)

      if isFreeFromMobs == false then
        break
      end

      local isNoCloseToObjects = true
      
      for i = 1, #objects do
          local dw = obj.mathService:distanceTiles(wx, wy, objects[i].worldX, objects[i].worldY)

          if dw < 3.2 then
              isNoCloseToObjects = false
          end
      end

      if isNoCloseToObjects == false then
        break
      end

      table.insert(walls, Wall:create(wx, wy, GameScene.PX, GameScene.PY, GameScene.SX, GameScene.SY))
    end
  end

  setmetatable(obj, self)
  self.__index = self

  return obj
end