---@class SlimeSpawnerEvent : EventAbstract
SlimeSpawnerEvent = {}

---@param walls Wall[]
---@param player Player
---@param objects Object[]
---@param items MapItem[]
---@param mobs Mob[]
function SlimeSpawnerEvent:create(
  walls,
  player,
  objects,
  items,
  mobs
  )

  local obj = EventAbstract:create(walls, player, objects, items, inGameTime)

  obj.mobs = mobs

  -- properties

  obj.interval = 5
  obj.chance = 0.25
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

    for index, mob in ipairs(obj.mobs) do
      if (mob.name == "SlimeMob" or mob.name == "RedSlimeMob") and mob.alive == true then
        return
      end
    end

    local wx = math.random(10) - 1
    local wy = math.random(10) - 1

    local isFreeTile = obj.tileChecker:isFreeTile(wx, wy)

    if isFreeTile == false then
      return
    end

    table.insert(
      GameScene.mobs,
      RedSlimeMob:create(
        wx * GFX_TILE_SIZE_PX * GameScene.SX + GameScene.PX + 32,
        wy * GFX_TILE_SIZE_PX * GameScene.SY + GameScene.PY + 32
      )
    )
  end

  setmetatable(obj, self)
  self.__index = self

  return obj
end