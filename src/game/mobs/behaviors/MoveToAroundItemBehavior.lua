---@class MoveToAroundItem : Behavior
---@field mapItems MapItem[]
MoveToAroundItem = setmetatable({}, Behavior)
MoveToAroundItem.__index = MoveToAroundItem

MoveToAroundItem.mapItems = {}

---@param mob Mob
---@param mapItems MapItem[]
function MoveToAroundItem:new(mob, mapItems)

    self.mob = mob
    self.mapItems = mapItems
    self.aroundItemPosition = nil
    self.inProcess = false

    self.call = function ()
      self:execute()
    end

    self.timer = TIMER(2, self.call)

    return setmetatable({}, self)
end

---@return boolean
function MoveToAroundItem:canExecute()

  if self.inProcess == true then
    return false
  end

  for i, mapItem in ipairs(self.mapItems) do
    if MathService:distance(self.mob, mapItem) < 500 and mapItem.name == BlueMushroomMapItem.name then
      self.aroundItemPosition = {
        x = mapItem.x,
        y = mapItem.y
      }

      return true
    end
  end

  return false
end

function MoveToAroundItem:execute()
    
  self.mob.vector = MathService:getDirectionVector(
      self.mob.x, self.mob.y,
      self.aroundItemPosition.x, self.aroundItemPosition.y,
      self.mob.speed
    )

    self.inProcess = true
end
