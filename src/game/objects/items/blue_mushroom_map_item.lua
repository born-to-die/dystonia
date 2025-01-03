---@class BlueMushroomMapItem
BlueMushroomMapItem = {};

---@param worldX number
---@param worldY number
function BlueMushroomMapItem:create(worldX, worldY)

    local obj = MapItem:create(worldX, worldY)

    -- Properties

    obj.name = "Blue mushroom"
    obj.sprite = love.graphics.newImage("gfx/blue_mushrooms_object.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    obj.item = BlueMushroomsItem:create()

    -- Methods

    -- Magic

    setmetatable(obj, self)

    return obj
end