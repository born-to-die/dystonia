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
  obj.wasSpawned2 = false
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

    if obj.wasSpawned2 then
      return
    end

    if GameScene.inGameTime < 100 then
      return
    end

    if obj.wasSpawned then

      for index, mob in ipairs(GameScene.mobs) do
        if mob.name == "HoundMob" and mob.alive == true then
          return
        end
      end

      if GameScene.inGameTime < 150 then
        return
      end

      obj:trySpawn(2)
    else
      obj:trySpawn(1)
    end
  end

  ---@param numberSpawn number
  function obj:trySpawn(numberSpawn)
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

    if numberSpawn == 1 then
      obj.wasSpawned = true
    else 
      obj.wasSpawned2 = true
    end
  end

  setmetatable(obj, self)
  self.__index = self

  return obj
end