---@class Vector
Vector = {}

function Vector:create()

  local obj = {}

    obj.x = 0
    obj.y = 0
    obj.speed = 0

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
    end

    function obj:setY(y, speed)
        obj.y = y
        obj.speed = speed
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

  setmetatable(obj, self)
    self.__index = self

    return obj
end