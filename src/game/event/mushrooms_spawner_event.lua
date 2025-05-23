---@class MushroomsSpawnerEvent
MushroomsSpawnerEvent = {}

---@param walls Wall[]
---@param player Player
---@param objects Object[]
---@param items InventoryItem[]
function MushroomsSpawnerEvent:create(walls, player, objects, items)

  local obj = EventAbstract:create(walls, player, objects, items)

  -- properties

  obj.interval = 5
  obj.chance = 1
  obj.tileChecker = TileChecker:create()
  obj.mathService = MathService:create()

  function obj.update()
    if not obj.timer.isExpired() then
      obj.timer.update(GameScene.DT)
    else
        obj.timer = TIMER(obj.interval, obj.check)
    end
  end

  -- methods

  function obj.run()

    for i = 1, 100, 1 do
      local wx = math.random(10) - 1
      local wy = math.random(10) - 1

      local isFreeFromWalls = obj.tileChecker:isFreeTileForList(wx, wy, walls)
      local isFreeFromPlayer = obj.tileChecker:isFreeTileForObject(wx, wy, player)

      if isFreeFromWalls and isFreeFromPlayer then
          table.insert(items, BlueMushroomMapItem:create(wx, wy))
          break
      end
    end
  end

  setmetatable(obj, self)
  self.__index = self

  return obj
end