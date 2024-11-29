---@class WallSpawnerEvent
---@field create fun(self: self, walls: Wall[], player: Player, objects: Object[], items: MapItem[]): table
WallSpawnerEvent = {}

function WallSpawnerEvent:create(walls, player, objects, items)

  local obj = EventAbstract:create(walls, player, objects, items, inGameTime)

  -- properties

  obj.interval = 5
  obj.chance = 0.75
  obj.tileChecker = TileChecker:create()
  obj.mathService = MathService:create()

  function obj.update()
    if not obj.timer.isExpired() then
      obj.timer.update(GameScene.DT)
    else
      GameScene.inGameTime = GameScene.inGameTime + 1
        obj.timer = TIMER(obj.interval, obj.check)
    end
  end

  -- methods

  function obj.run()

    player.foodSaturation = player.foodSaturation - 1

    for i = 1, 100, 1 do
      local wx = math.random(10) - 1
      local wy = math.random(10) - 1

      local isFreeFromWalls = obj.tileChecker:isFreeTileForList(wx, wy, walls)
      local isFreeFromPlayer = obj.tileChecker:isFreeTileForObject(wx, wy, player)
      local isNoCloseToObjects = true
      
      for i = 1, #objects do
          local dw = obj.mathService:distanceTiles(wx, wy, objects[i].worldX, objects[i].worldY)

          if dw < 3.2 then
              isNoCloseToObjects = false
          end
      end

      if isFreeFromWalls and isFreeFromPlayer and isNoCloseToObjects then
          table.insert(walls, Wall:create(wx, wy, GameScene.PX, GameScene.PY, GameScene.SX, GameScene.SY))
          break
      end
    end
  end

  setmetatable(obj, self)
  self.__index = self

  return obj
end