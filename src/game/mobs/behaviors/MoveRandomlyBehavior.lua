---@class MoveRandomly : Behavior
MoveRandomly = setmetatable({}, Behavior)
MoveRandomly.__index = MoveRandomly

MoveRandomly.INTERVAL = 3

function MoveRandomly:new(mob)

    self.call = function ()

        self:execute(mob)
      end

    self.timer = TIMER(MoveRandomly.INTERVAL, self.call)
    self.name = "MoveRandomly"

    return setmetatable({}, self)
end

function MoveRandomly:canExecute()
    if not self.timer.isExpired() then
        self.timer.update(GameScene.DT)
        return false
      else
        self.timer = TIMER(MoveRandomly.INTERVAL, self.call)
        return true
      end
end

---@param mob Mob
function MoveRandomly:execute(mob)
    mob:moveRandomly()
end
