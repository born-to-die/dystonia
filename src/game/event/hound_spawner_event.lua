---@class HoundSpawnerEvent : EventAbstract
HoundSpawnerEvent = {}

---@param walls Wall[]
---@param player Player
---@param objects Object[]
---@param items MapItem[]
function HoundSpawnerEvent:create(
  walls,
  player,
  objects,
  items
  )

  local obj = EventAbstract:create(walls, player, objects, items, inGameTime)

  -- properties

  obj.interval = 30
  obj.chance = 1
  obj.wasSpawned = false
  obj.tileChecker = TileChecker:create()

  function obj.update()
    if not obj.timer.isExpired() then
      obj.timer.update(GameScene.DT)
    else
      
      obj.timer = TIMER(obj.interval, obj.check)
    end
  end

  -- methods
  function obj.run()

    if obj.wasSpawned or GameScene.inGameTime < 100 then
      return
    end

    local wx = math.random(10) - 1
    local wy = math.random(10) - 1

    local isFreeTile = obj.tileChecker:isFreeTile(wx, wy)

    if isFreeTile == false then
      return
    end

    table.insert(
      GameScene.mobs,
      HoundMob:create(
        wx * GFX_TILE_SIZE_PX * GameScene.SX + GameScene.PX + GFX_TILE_HALF_SIZE_PX,
        wy * GFX_TILE_SIZE_PX * GameScene.SY + GameScene.PY + GFX_TILE_HALF_SIZE_PX
      )
    )

    obj.wasSpawned = true
  end

  setmetatable(obj, self)
  self.__index = self

  return obj
end