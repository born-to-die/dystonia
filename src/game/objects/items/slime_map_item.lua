---@class SlimeMapItem
SlimeMapItem = {};

function SlimeMapItem:create(worldX, worldY)

    local obj = MapItem:create(worldX, worldY)

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/slime_item.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    obj.item = SlimeItem:create()

    -- Methods

    -- Magic

    setmetatable(obj, self)

    return obj
end