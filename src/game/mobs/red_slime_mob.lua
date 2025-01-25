---@class RedSlimeMob : SlimeMob
RedSlimeMob = {}

---@param x number
---@param y number
function RedSlimeMob:create(x, y)

    local obj = SlimeMob:create(x, y)

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/red_slime_mob.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)

    -- Attributes
    obj.health = 40

    obj.vector = Vector:create(0, 0, obj.speed)

    -- Magic

    setmetatable(obj, self)

    return obj
end