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
      if (player.foodSaturation > 0) then
        player.foodSaturation = player.foodSaturation - 1
      else 
        if player.health > 0 then
          player.health = player.health - 3
        end
      end

      
      GameScene.inGameTime = GameScene.inGameTime + 1
      obj.timer = TIMER(obj.interval, obj.check)
    end
  end

  -- methods

  function obj.run()

    local wx = math.random(10) - 1
    local wy = math.random(10) - 1

    local isFreeTile = obj.tileChecker:isFreeTile(wx, wy)

    if isFreeTile == false then
      return
    end

    for i = 1, #objects do
      local dw = obj.mathService:distanceTiles(wx, wy, objects[i].worldX, objects[i].worldY)

      if dw < 3.2 then
        return
      end
    end

    table.insert(walls, Wall:create(wx, wy, GameScene.PX, GameScene.PY, GameScene.SX, GameScene.SY))
  end

  setmetatable(obj, self)
  self.__index = self

  return obj
end