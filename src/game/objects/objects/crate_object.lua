---@class CrateObject
CrateObject = {};

---@param worldX number
---@param worldY number
function CrateObject:create(worldX, worldY)

    local obj = Object:create(worldX, worldY)

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/crate_object.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    obj.type = 'player-activity'

    -- Methods

    ---@param items MapItem[]
    function obj:activate(items)
        table.insert(items, BeaconMapItem:create(obj.worldX, obj.worldY))
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end