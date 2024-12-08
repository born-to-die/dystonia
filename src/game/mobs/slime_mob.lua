---@class SlimeMob
---@field worldX number
---@field worldY number
SlimeMob = {};

-- @param int worldX
-- @param int worldY
function SlimeMob:create(worldX, worldY)

    local obj = Mob:create(worldX, worldY)

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/slime_mob.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    obj.vector = Vector:create()
    obj.vector:set(1,1, obj.speed)
    table.insert(obj.behaviors, MoveRandomly:new(obj))

    -- Attributes
    obj.speed = 200
    obj.health = 40
    obj.foodSaturation = 100

    -- Methods

    -- Magic

    setmetatable(obj, self)

    return obj
end