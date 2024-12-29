---@class DivisionBehavior : Behavior
DivisionBehavior = setmetatable({}, Behavior)
DivisionBehavior.__index = DivisionBehavior

function DivisionBehavior:new(mob)

    self.call = function ()

        self:execute(mob)
      end

    self.timer = TIMER(8, self.call)

    return setmetatable({}, self)
end

function DivisionBehavior:canExecute()
    if not self.timer.isExpired() then
        self.timer.update(GameScene.DT)
        return false
      else
        self.timer = TIMER(8, self.call)
        return true
      end
end

---@param mob Mob
function DivisionBehavior:execute(mob)
  --table.insert(GameScene.mobs, SlimeMob:create(mob.x, mob.y))
end
