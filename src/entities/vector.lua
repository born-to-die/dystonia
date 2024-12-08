---@class Vector
---@field setX fun(self:self, x:number, speed:number)
---@field setY fun(self:self, y:number, speed:number)
Vector = {}

---@param x number
---@param y number
---@param speed number
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

    ---@param x number
    ---@param y number
    ---@param speed number
    function obj:set(x, y, speed)
        obj.x = x
        obj.y = y
        obj.speed = speed
    end

    ---@param x number
    ---@param speed number
    function obj:setX(x, speed)
        obj.x = x
        obj.speed = speed
        obj:normalize()
    end

    ---@param y number
    ---@param speed number
    function obj:setY(y, speed)
        obj.y = y
        obj.speed = speed
        obj:normalize()
    end

    function obj:setSpeed(speed)
        obj.speed = speed
    end

    function obj:getSpeedX()
        return obj.x * obj.speed
    end

    function obj:getSpeedY()
        return obj.y * obj.speed
    end

    function obj.invert(speed)
        obj.x = -obj.x
        obj.y = -obj.y

        if speed > 0 then
            obj.speed = speed
        end
    end

    function obj.reset()
        obj.x = 0
        obj.y = 0
        obj.speed = 0
    end

    function obj:normalize()
        local lenght = math.sqrt(obj.x^2 + obj.y^2)

        if lenght > 0 then
            obj.x = obj.x / lenght
            obj.y = obj.y / lenght
        else
            obj.x = 0
            obj.y = 0
        end
    end

    setmetatable(obj, self)
    self.__index = self

    return obj
end