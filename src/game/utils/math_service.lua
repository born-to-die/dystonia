---@class MathService
MathService = {}

function MathService:create()

    local obj = {}

    -- Properties

    -- Methods

    ---@param wx1 number
    ---@param wy1 number
    ---@param wx2 number
    ---@param wy2 number
    function obj:distanceTiles(wx1, wy1, wx2, wy2)
        local x1 = wx1 + wx1 / 2
        local y1 = wy1 + wy1 / 2
        local x2 = wx2 + wx2 / 2
        local y2 = wy2 + wy2 / 2

        return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
    end

    ---@param obj1 table
    ---@param obj2 table
    ---@return number
    function obj:distance(obj1, obj2)
        return math.sqrt((obj2.x - obj1.x)^2 + (obj2.y - obj1.y)^2)
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end