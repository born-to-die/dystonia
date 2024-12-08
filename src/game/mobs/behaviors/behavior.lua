-- Интерфейс для поведения
---@class Behavior
Behavior = {}
Behavior.__index = Behavior

function Behavior:new()
    return setmetatable({}, self)
end

function Behavior:canExecute()
    -- Условие, нужно переопределить
    return false
end

function Behavior:execute(enemy, gameState)
    -- Действие, нужно переопределить
end
