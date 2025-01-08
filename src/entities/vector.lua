---@class Vector
---@field x number
---@field y number
---@field setX fun(self:self, x:number, speed:number)
---@field setY fun(self:self, y:number, speed:number)
Vector = {}

---@param x number
---@param y number
---@param speed number
---@return Vector
function Vector:create(x, y, speed)

  local obj = {}

    obj.x = x
    obj.y = y
    obj.speed = speed

    local lenght = math.sqrt(obj.x^2 + obj.y^2)

    if lenght > 0 then
        obj.x = obj.x / lenght
        obj.y = obj.y / lenght
    else
        obj.x = 0
        obj.y = 0
    end

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function Vector:normalize()
    local lenght = math.sqrt(self.x^2 + self.y^2)

    if lenght > 0 then
        self.x = self.x / lenght
        self.y = self.y / lenght
    else
        self.x = 0
        self.y = 0
    end
end

---@param x number
---@param y number
---@param speed number
function Vector:set(x, y, speed)
    self.x = x
    self.y = y
    self.speed = speed
    self:normalize()
end

---@param x number
---@param speed number
function Vector:setX(x, speed)
    self.x = x
    self.speed = speed
    self:normalize()
end

---@param y number
---@param speed number
function Vector:setY(y, speed)
    self.y = y
    self.speed = speed
    self:normalize()
end

function Vector:invert()
    self:set(-self.x, -self.y, self.speed)
end

function Vector:reset()
    self.x = 0
    self.y = 0
    self.speed = 0
end

---@return number
function Vector:getSpeedX()
    return self.x * self.speed
end

---@return number
function Vector:getSpeedY()
    return self.y * self.speed
end