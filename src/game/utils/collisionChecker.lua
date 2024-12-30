CollisionChecker = {}

function CollisionChecker:create()

    local obj = {}

    -- Properties

    -- Methods

    function obj:isPointInRect(rect, point)
        return rect.x <= point.x 
            and point.x <= rect.x + rect.w 
            and rect.y <= point.y 
            and point.y <= rect.y + rect.h
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end

---@param rect table (x, y, w, h)
---@param point table (x, y)
---@return boolean
function CollisionChecker:isPointInRect(rect, point)
    return rect.x <= point.x 
        and point.x <= rect.x + rect.w 
        and rect.y <= point.y 
        and point.y <= rect.y + rect.h
end