---@class HoundMob : Mob
HoundMob = {};

---@param x number
---@param y number
---@return HoundMob
function HoundMob:create(x, y)

    ---@class obj: HoundMob
    local obj = Mob:create(x, y)

    -- Properties

    obj.name = "HoundMob"
    obj.sprite = love.graphics.newImage("gfx/hound_mob.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)

    -- Attributes
    obj.health = 60
    obj.speed = 100
    obj.isEating = false

    obj.vector = Vector:create(0, 0, obj.speed)

    table.insert(obj.behaviors, 1, MoveToAroundPlayer:new(obj, 0))

    -- Methods

    -- Magic

    setmetatable(obj, self)

    return obj
end