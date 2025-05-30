---@class MoveToAroundPlayer : Behavior
---@field distance number
MoveToAroundPlayer = setmetatable({}, Behavior)
MoveToAroundPlayer.__index = MoveToAroundPlayer

---@param mob Mob
---@param distance number
function MoveToAroundPlayer:new(mob, distance)

    local obj = {}

    obj.name = "MoveToAroundPlayer"
    obj.mob = mob
    obj.move = false
    obj.distanceToPlayer = 0
    obj.distance = distance

    obj.call = function ()
      obj:execute()
    end

    obj.timer = TIMER(2, obj.call)

    return setmetatable(obj, self)
end

---@return boolean
function MoveToAroundPlayer:canExecute()

  if GameScene.player.health <= 0 then
    return false
  end

  self.distanceToPlayer = MathService:distance(self.mob, GameScene.player)

  if self.distance == 0 then
    return true
  elseif self.distanceToPlayer < self.distance  then
    return true
  end

  self.mob.inAttack = false
  return false
end

function MoveToAroundPlayer:execute()

  local isCloseToPlayer = self.distanceToPlayer < self.mob.attackRadius

  local speed = self.mob.speed

  if isCloseToPlayer then
    speed = 0
  end

  if isCloseToPlayer then
    self.mob:attack()
  end
  
  if isCloseToPlayer then speed = 0 end

  self.mob.vector = MathService:getDirectionVector(
      self.mob.x, self.mob.y,
      GameScene.player.x, GameScene.player.y,
      speed
  )
end
