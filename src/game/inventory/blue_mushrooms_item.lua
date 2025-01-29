BlueMushroomsItem = {};

function BlueMushroomsItem:create()

    local obj = InventoryItem:create()

    -- Properties

    obj.name = "Blue mushroom"
    obj.desc = "To be honest, it looks inedible - it oozes acid"
    obj.sprite = love.graphics.newImage("gfx/blue_mushrooms_object.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    obj.type = InventoryItemType.USE

    -- Methods

    ---@overload fun(worldX:number, worldY:number): nil
    function obj:getMapItem(worldX, worldY)
        return BlueMushroomMapItem:create(worldX, worldY)
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end