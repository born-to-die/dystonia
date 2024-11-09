---@class BeaconObject
BeaconObject = {};

---@param worldX number
---@param worldY number
function BeaconObject:create(worldX, worldY)

    local obj = Object:create(worldX, worldY)

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/beacon_object.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)

    -- Methods

    -- Magic

    setmetatable(obj, self)

    return obj
end