---@class CannedMapItem
---@field worldX number
---@field worldY number
CannedMapItem = {};

-- @param int worldX
-- @param int worldY
function CannedMapItem:create(worldX, worldY)

    local obj = MapItem:create(worldX, worldY)

    -- Properties

    obj.name = "Canned food"
    obj.sprite = love.graphics.newImage("gfx/canned_map_item.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    obj.item = CannedItem:create()

    -- Methods

    -- Magic

    setmetatable(obj, self)

    return obj
end