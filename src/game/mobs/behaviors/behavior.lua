-- Интерфейс для поведения
---@class Behavior
---@field mob Mob
Behavior = {}
Behavior.__index = Behavior

Behavior.mob = nill

---@param mob Mob
function Behavior:new(mob)
    self.mob = mob
    return setmetatable({}, self)
end

function Behavior:canExecute()
    -- Условие, нужно переопределить
    return false
end

function Behavior:execute()
    -- Действие, нужно переопределить
end
