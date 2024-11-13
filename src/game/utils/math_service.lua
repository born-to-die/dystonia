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

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end