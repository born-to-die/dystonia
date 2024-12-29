---@class BlueMushroomsObject
BlueMushroomsObject = {};

---@param worldX number
---@param worldY number
function BlueMushroomsObject:create(worldX, worldY)

    local obj = Object:create(worldX, worldY)

    -- Properties

    obj.name = "blue-mushrooms"
    obj.type = 'passive-activity'

    obj.sprite = love.graphics.newImage("gfx/blue_mushrooms_object.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)

    -- Methods

    -- Magic

    setmetatable(obj, self)

    return obj
end