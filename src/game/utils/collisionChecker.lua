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

---@param cx number circle hitbox x
---@param cy number circle hitbox y
---@param cr number circle hitbox radius
---@param px number point x
---@param py number point y
---@return boolean
function CollisionChecker:isPointInCircle(cx, cy, cr, px, py)
    return math.sqrt((cx - px)^2 + (cy - py)^2) <= cr
end

---@param cx number
---@param cy number
---@param radius number
---@param rx number
---@param ry number
---@param rw number
---@param rh number
function CollisionChecker:isCircleRectangleCollition(cx, cy, radius, rx, ry, rw, rh)
    local nearestX = math.max(rx, math.min(cx, rx + rw))
    local nearestY = math.max(ry, math.min(cy, ry + rh))

    local dx = cx - nearestX
    local dy = cy - nearestY
    local distanceSquared = dx * dx + dy * dy

    return distanceSquared <= radius * radius
end