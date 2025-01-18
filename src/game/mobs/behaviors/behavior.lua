-- Интерфейс для поведения
---@class Behavior
---@field mob Mob
Behavior = {}
Behavior.__index = Behavior

---@param mob Mob
function Behavior:new(mob)
    self.mob = mob
    self.name = "Unsetted behavior"
    return setmetatable({}, self)
end

function Behavior:canExecute()
    -- Условие, нужно переопределить
    return false
end

function Behavior:execute()
    -- Действие, нужно переопределить
end
