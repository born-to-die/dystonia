BeaconMapItem = {};

-- @param int worldX
-- @param int worldY
function BeaconMapItem:create(worldX, worldY)

    local obj = MapItem:create(worldX, worldY)

    -- Properties

    obj.name = "Beacon"
    obj.sprite = love.graphics.newImage("gfx/beacon_map_item.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)

    -- Methods

    -- Magic

    setmetatable(obj, self)

    return obj
end