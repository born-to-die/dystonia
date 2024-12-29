---@class CrateObject
CrateObject = {};

---@param worldX number
---@param worldY number
function CrateObject:create(worldX, worldY)

    local obj = Object:create(worldX, worldY)

    -- Properties

    obj.name = "crate"
    obj.type = 'player-activity'

    obj.sprite = love.graphics.newImage("gfx/crate_object.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)

    -- Methods

    ---@param items MapItem[]
    function obj:activate(items)
        local r = math.random(3)

        if r == 1 then
            table.insert(items, BeaconMapItem:create(obj.worldX, obj.worldY))
        elseif r == 2 then
            table.insert(items, CannedMapItem:create(obj.worldX, obj.worldY))
        end
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end