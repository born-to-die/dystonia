---@class MoveToAroundPlayer : Behavior
---@field mapItems MapItem[]
MoveToAroundPlayer = setmetatable({}, Behavior)
MoveToAroundPlayer.__index = MoveToAroundPlayer

---@param mob Mob
function MoveToAroundPlayer:new(mob)

    local obj = {}

    obj.name = "MoveToAroundPlayer"
    obj.mob = mob
    obj.move = false

    obj.call = function ()
      obj:execute()
    end

    obj.timer = TIMER(2, obj.call)

    return setmetatable(obj, self)
end

---@return boolean
function MoveToAroundPlayer:canExecute()

  local distance = MathService:distance(self.mob, GameScene.player)

  if distance < 200  then
    return true
  end

  return false
end

function MoveToAroundPlayer:execute()

  self.mob.vector = MathService:getDirectionVector(
      self.mob.x, self.mob.y,
      GameScene.player.x, GameScene.player.y,
      self.mob.speed
  )
end
