---@class BlueMushroomMapItem : MapItem
BlueMushroomMapItem = {};

BlueMushroomMapItem.name = "blue_mushroom"

---@param worldX number
---@param worldY number
function BlueMushroomMapItem:create(worldX, worldY)

    local obj = MapItem:create(worldX, worldY)

    -- Properties
    obj.name = BlueMushroomMapItem.name
    obj.sprite = love.graphics.newImage("gfx/blue_mushrooms_object.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    obj.item = BlueMushroomsItem:create()

    -- Methods

    -- Magic

    setmetatable(obj, self)

    return obj
end