---@class MoveToPlayer : Behavior
---@field distance number
MoveToPlayer = setmetatable({}, Behavior)
MoveToPlayer.__index = MoveToPlayer

function MoveToPlayer:new(mob)

    local obj = {}

    obj.name = "MoveToPlayer"
    obj.mob = mob

    obj.call = function ()
      obj:execute()
    end

    obj.timer = TIMER(2, obj.call)

    return setmetatable(obj, self)
end

---@return boolean
function MoveToPlayer:canExecute()
  return true
end

function MoveToPlayer:execute()

  self.mob.vector = Bfs:findPath(
    math.floor((self.mob.x - GameScene.PX) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE)),
    math.floor((self.mob.y - GameScene.PY) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE)),
    GameScene.player.worldX,
    GameScene.player.worldY,
    self.mob
  )
end
